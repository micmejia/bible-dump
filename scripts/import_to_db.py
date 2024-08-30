import os
import glob
import pandas as pd
import psycopg
import requests
import subprocess

from pathlib import Path

subprocess.run(["./reset_db.sh"])

API = "https://api.versequick.com"
df = pd.read_csv("abbr.csv")
abbreviations = list(df["abbr"])

connection = psycopg.connect("dbname=bibledev user=berinaniesh", autocommit=True)
cursor = connection.cursor()

translations = [
    {
        "name": "AMPC",
        "language": "English",
        "full_name": "Amplified Bible, Classic Edition",
        "year": "1987",
        "license": "Proprietary, The Lockman Foundation",
        "bible_name": "Amplified Bible, Classic Edition",
        "ot": "Old Testament",
        "nt": "New Testament",
        "books": list(df["book"]),
        "description": "https://en.wikipedia.org/wiki/Amplified_Bible",
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
        "books": list(df["bookName"]),
        "description": "https://www.biblegateway.com/versions/Ang-Salita-ng-Diyos-ASND/",
    },
    {
        "name": "NKJV",
        "language": "English",
        "full_name": "New King James Version",
        "year": "1975",
        "license": "Proprietary, Thomas Nelson",
        "bible_name": "New King James Version",
        "ot": "Old Testament",
        "nt": "New Testament",
        "books": list(df["book"]),
        "description": "https://en.wikipedia.org/wiki/New_King_James_Version",
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

def get_book_id(book):
    book_id = cursor.execute("""
    SELECT id FROM "Book" WHERE name=%s
    """, (book, )).fetchone()
    if book_id is None:
        cursor.execute("""
        INSERT INTO "Book" ("name", "long_name", "book_number", "abbreviation", "testament") VALUES (%s, %s, %s, %s, %s) 
        """, ())
        book_id = cursor.execute("""
        SELECT id FROM "Book" WHERE name=%s
        """, (book)).fetchone()
    book_id = book_id[0]
    return book_id

json_root = Path.cwd().parent / "json" / "by_book"

def push_bible(translation):
    translation_id = get_translation_id(translation)

    json_file = json_root / f"{translation['name'].lower()}.json"
    assert Path.exists(json_file)
    print(json_file)

    with open(json_file) as f:
        data = json.load(f)

    for book in translation["books"]:
        print(f"{book}: {len(data[book])}")

for translation in translations:
    push_bible(translation)

connection.close()


