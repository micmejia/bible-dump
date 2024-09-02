import json
from pathlib import Path

import pandas as pd
import psycopg

from chapters import CHAPTERS_COUNT
from env import PG_DB, PG_PASS, PG_USER


df = pd.read_csv("bible_books.csv")
json_root = Path.cwd().parent / "json" / "by_book"

connection = psycopg.connect(f"dbname={PG_DB} user={PG_USER} password={PG_PASS} host=127.0.0.1 port=5432", autocommit=False)
cursor = connection.cursor()


translations = [
    {
        "name": "NKJV",
        "language": "English",
        "full_name": "New King James Version",
        "year": "1975",
        "license": "Proprietary, Thomas Nelson",
        "bible_name": "New King James Version",
        "ot": "Old Testament",
        "nt": "New Testament",
        "description": "https://en.wikipedia.org/wiki/New_King_James_Version",
    },
    {
        "name": "ASND",
        "language": "Filipino",
        "full_name": "Ang Salita ng Dios (Tagalog Contemporary Bible)",
        "year": "2009",
        "license": "Proprietary, biblica.com",
        "bible_name": "Ang Salita ng Dios",
        "ot": "Lumang Tipan",
        "nt": "Bagong Tipan",
        "description": "https://www.biblegateway.com/versions/Ang-Salita-ng-Diyos-ASND/",
    },
    {
        "name": "AMPC",
        "language": "English",
        "full_name": "Amplified Bible, Classic Edition",
        "year": "1987",
        "license": "Proprietary, The Lockman Foundation",
        "bible_name": "Amplified Bible, Classic Edition",
        "ot": "Old Testament",
        "nt": "New Testament",
        "description": "https://en.wikipedia.org/wiki/Amplified_Bible",
    },
]

def get_language_id(language):
    language_id = cursor.execute(
        """
    SELECT id from "Language" where name=%s
    """,
        (language,),
    ).fetchone()
    if language_id is None:
        langauge_id = cursor.execute(
            """INSERT into "Language" ("name") VALUES (%s)""", (language,)
        )
        language_id = cursor.execute(
            """
        SELECT id from "Language" where name=%s
        """,
            (language,),
        ).fetchone()
    language_id = language_id[0]
    return language_id

def get_translation_id(translation):
    language_id = get_language_id(translation["language"])
    translation_id = cursor.execute("""
    SELECT id FROM "Translation" WHERE name=%s
    """, (translation["name"], )).fetchone()
    if translation_id is None:
        cursor.execute("""
        INSERT INTO "Translation" ("language_id", "name", "full_name", "year", "license", "description") VALUES (%s, %s, %s, %s, %s, %s)
        """, (language_id, translation["name"], translation["full_name"], translation["year"], translation["license"], translation["description"]))
        translation_id = cursor.execute("""
        SELECT id FROM "Translation" WHERE name=%s
        """, (translation["name"], )).fetchone()

    translation_id = translation_id[0]
    return translation_id

def get_testament_name_id(translation_id, testament, name):
    testament_name_id = cursor.execute("""
    SELECT id FROM "TestamentName" WHERE translation_id=%s AND testament=%s
    """, (translation_id, testament)).fetchone()
    if testament_name_id is None:
        cursor.execute("""
        INSERT INTO "TestamentName" ("translation_id", "testament", "name") VALUES (%s, %s, %s) 
        """, (translation_id, testament, name))
        testament_name_id = cursor.execute("""
        SELECT id FROM "TestamentName" WHERE translation_id=%s AND testament=%s
        """, (translation_id, testament)).fetchone()
    testament_name_id = testament_name_id[0]
    return testament_name_id

def get_translation_book_name_id(translation_id, book_id, book):
    translation_book_name_id = cursor.execute("""
    SELECT id FROM "TranslationBookName" WHERE translation_id=%s AND book_id=%s
    """, (translation_id, book_id)).fetchone()
    if translation_book_name_id is None:
        cursor.execute("""
        INSERT INTO "TranslationBookName" ("translation_id", "book_id", "name", "long_name") VALUES (%s, %s, %s, %s) 
        """, (translation_id, book_id, book.name, book.long_name))
        translation_book_name_id = cursor.execute("""
        SELECT id FROM "TranslationBookName" WHERE translation_id=%s AND book_id=%s
        """, (translation_id, book_id)).fetchone()
    translation_book_name_id = translation_book_name_id[0]
    return translation_book_name_id

def get_book_id(book):
    book_id = cursor.execute("""
    SELECT id FROM "Book" WHERE name=%s
    """, (book.name_english, )).fetchone()
    if book_id is None:
        cursor.execute("""
        INSERT INTO "Book" ("name", "long_name", "book_number", "abbreviation", "testament", "division") VALUES (%s, %s, %s, %s, %s, %s) 
        """, (book.name_english, book.long_name, book.book_number, book.abbreviation, book.testament, book.division))
        book_id = cursor.execute("""
        SELECT id FROM "Book" WHERE name=%s
        """, (book.name_english, )).fetchone()
    book_id = book_id[0]
    return book_id

def get_chapter_id(book_id, chapter_number):
    chapter_id = cursor.execute("""
    SELECT id FROM "Chapter" WHERE book_id=%s AND chapter_number=%s
    """, (book_id, chapter_number)).fetchone()
    if chapter_id is None:
        cursor.execute("""
        INSERT INTO "Chapter" ("book_id", "chapter_number") VALUES (%s, %s) 
        """, (book_id, chapter_number))
        chapter_id = cursor.execute("""
        SELECT id FROM "Chapter" WHERE book_id=%s AND chapter_number=%s
        """, (book_id, chapter_number)).fetchone()
    chapter_id = chapter_id[0]
    return chapter_id

def get_verse_id(chapter_id, verse_number):
    verse_id = cursor.execute("""
    SELECT id FROM "Verse" WHERE chapter_id=%s AND verse_number=%s
    """, (chapter_id, verse_number)).fetchone()
    if verse_id is None:
        cursor.execute("""
        INSERT INTO "Verse" ("chapter_id", "verse_number") VALUES (%s, %s) 
        """, (chapter_id, verse_number))
        verse_id = cursor.execute("""
        SELECT id FROM "Verse" WHERE chapter_id=%s AND verse_number=%s
        """, (chapter_id, verse_number)).fetchone()
    verse_id = verse_id[0]
    return verse_id

def get_verse_text_id(translation_id, verse_id, verse):
    verse_text_id = cursor.execute("""
    SELECT id FROM "VerseText" WHERE translation_id=%s AND verse_id=%s
    """, (translation_id, verse_id)).fetchone()
    if verse_text_id is None:
        cursor.execute("""
        INSERT INTO "VerseText" ("translation_id", "verse_id", "verse") VALUES (%s, %s, %s) 
        """, (translation_id, verse_id, verse))
        verse_text_id = cursor.execute("""
        SELECT id FROM "VerseText" WHERE translation_id=%s AND verse_id=%s
        """, (translation_id, verse_id)).fetchone()
    verse_text_id = verse_text_id[0]
    return verse_text_id

# def get_fulltable_id(translation, book, abbreviation, book_name, chapter, verse_number, verse):
#     fulltable_id = cursor.execute("""
#     SELECT id FROM "fulltable" WHERE translation=%s AND book=%s AND chapter=%s AND verse_number=%s
#     """, (translation, book, chapter, verse_number)).fetchone()
#     if fulltable_id is None:
#         cursor.execute("""
#         INSERT INTO "fulltable" ("translation", "book", "abbreviation", "book_name", "chapter", "verse_number", "verse") VALUES (%s, %s, %s, %s, %s, %s, %s) 
#         """, (translation, book, abbreviation, book_name, chapter, verse_number, verse))
#         fulltable_id = cursor.execute("""
#         SELECT id FROM "fulltable" WHERE translation=%s AND book=%s AND chapter=%s AND verse_number=%s
#         """, (translation, book, chapter, verse_number)).fetchone()
#     fulltable_id = fulltable_id[0]
#     return fulltable_id

def create_fulltable():
    cursor.execute("""
    drop table if exists fulltable;
    create table fulltable as select vv.id as id, t.name as translation, b.name as book, b.abbreviation as abbreviation, tt.name as book_name, c.chapter_number as chapter, v.verse_number as verse_number, verse from "VerseText" vv join "Translation" t on vv.translation_id=t.id join "Verse" v on v.id=vv.verse_id join "Chapter" c on v.chapter_id=c.id join "Book" b on c.book_id=b.id join "TranslationBookName" tt on (t.id=tt.translation_id and b.id=tt.book_id) order by vv.id;
    create index on fulltable(translation);
    create index on fulltable(book);
    create index on fulltable(book_name);
    create index on fulltable(chapter);
    create index on fulltable(verse_number);
    """)

def push_bible(translation):
    translation_id = get_translation_id(translation)
    get_testament_name_id(translation_id, "OldTestament", translation["ot"])
    get_testament_name_id(translation_id, "NewTestament", translation["nt"])

    cursor.execute("COMMIT")
    json_file = json_root / f"{translation['name'].lower()}.json"
    assert Path.exists(json_file)
    print(json_file)

    with open(json_file) as f:
        data = json.load(f)

    books = df[df.language == translation['language']]
    for book in books.itertuples():
        book_id = get_book_id(book)
        chapter_count=CHAPTERS_COUNT[book.book_number-1][1]
        _chapter_index = {}
        for chapter_number in range(1, chapter_count+1):
            chapter_id = get_chapter_id(book_id, chapter_number)
            _chapter_index[chapter_number] = chapter_id

        for verse in data[book.name]:
            verse_id = get_verse_id(_chapter_index[verse['ch']], verse['v'])
            get_verse_text_id(translation_id, verse_id, verse['text'])
            # get_fulltable_id(translation['name'], book.name_english, book.abbreviation, book.name, verse['ch'], verse['v'], verse['text'])
        cursor.execute("COMMIT")
        
        print(f"{book.name}: {len(data[book.name])}: {book_id=}: {chapter_count=}")
        translation_book_name_id = get_translation_book_name_id(translation_id, book_id, book)
        # break

for translation in translations:
    push_bible(translation)
    print('-----------------------------------------------')
    # break

create_fulltable()

cursor.execute("COMMIT")
connection.close()


