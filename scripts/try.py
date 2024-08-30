import json
import pandas as pd
from pathlib import Path

df = pd.read_csv("bible_index.csv")


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
        "books": list(df["book_asnd"]),
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

json_root = Path.cwd().parent / "json" / "by_book"

def push_bible(translation):
    # translation_id = get_translation_id(translation)

    json_file = json_root / f"{translation['name'].lower()}.json"
    assert Path.exists(json_file)
    print(json_file)

    with open(json_file) as f:
        data = json.load(f)

    for book in translation["books"]:
        print(f"{book}: {len(data[book])}")

for translation in translations:
    push_bible(translation)
