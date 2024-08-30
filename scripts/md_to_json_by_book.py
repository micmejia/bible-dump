
import csv
import json
import re

from pathlib import Path

from chapters import CHAPTERS_COUNT

MAX_VERSES = 176  # for longest chapter

translations = ['NKJV', 'ASND', 'AMPC']

root = Path.cwd().parent


verse_re = {}
for v in range(1, MAX_VERSES+1):
  # verse_re[v] = re.compile(fr"###+\s+{v}\s+(?P<verse_text>[^#]*)", re.M)  # normal verse heading scenario, e.g. ###### 17
  verse_re[v] = re.compile(fr"###+\s+{v}(?P<verse_text>[\-\s]+[^#]*)", re.M)  # consider verse number ranges for ASND, e.g. ####### 17-18

verse_range_re = re.compile(r"^\-(?P<verse_end_num>\d+)(?P<verse_text>[^#]*)", re.M)

for translation in translations:
  workdir = root / "md" / translation
  translation_output = {}
  translation_verses_count = 0
  print(f"\n\n{workdir}")

  with open('bible_index.csv', mode ='r')as index:
    bible_index = csv.DictReader(index)

    # process all books
    for b, row in enumerate(bible_index):
      book_output = []
      book = workdir / row['book']
      assert Path.exists(book), f"Missing book folder {book=}"
      book_verses_total = int(row['verses'])
      book_verses_count = 0

      assert CHAPTERS_COUNT[b][0] == row['book'], "mismatched book name"

      # process all markdown files (chapters) for a book
      for chapter in range(1, int(row['chapters'])+1):
        md = book / f"{row['md_name']} {chapter}.md"
        assert Path.exists(md), f"Missing chapter file {md=}"
        chapter_verses_total = CHAPTERS_COUNT[b][2][chapter-1]
        chapter_verses_count = 0

        text = md.read_text()
        # print(text)

        # process all verses for a markdown (single chapter)
        v = 1
        while v <= MAX_VERSES:
          if search := verse_re[v].search(text):
            translation_verses_count += 1
            book_verses_count += 1
            chapter_verses_count += 1
            verse = search.group("verse_text").strip()
            # print(f"{v}: {verse}")
            verse_record = {
              "ch": chapter,
              "v": v
            }
            if verse.startswith("-"):
              if match := verse_range_re.match(verse):
                verse_end_num = int(match.group("verse_end_num"))
                verse = match.group("verse_text").strip()
                verse_record["text"] = verse
                book_output.append(verse_record)

                while v < verse_end_num:
                  v += 1
                  translation_verses_count += 1
                  chapter_verses_count += 1
                  book_verses_count += 1                  
                  verse_record = {
                    "ch": chapter,
                    "v": v,
                    "text": ""
                  }        
                  book_output.append(verse_record)       
              else:
                raise Exception(f"unable to adjust verse range: {md=}; {v=}; {verse=}")
            else:
              verse_record["text"] = verse
              book_output.append(verse_record)
          else:
            assert chapter_verses_count == chapter_verses_total, \
                f"Chapter count mismatched: {chapter_verses_count=}; {chapter_verses_total=}; {md=}"
          v += 1

        # break  # chapter files

      print(f"{book}: {book_verses_count}")
      assert book_verses_count == book_verses_total, \
                f"Book verses count mismatched: {book_verses_count=}; {book_verses_total=}; {book=}"
      translation_output[row['book_asnd' if translation == 'ASND' else 'book']] = book_output

      # break  # books folders
    print(f"{translation}: {translation_verses_count}")
    # break  # translation


  output_json = root / "json" / "by_book" / f"{translation.lower()}.json"
  with open(output_json, "w") as f:
      json.dump(translation_output, f) #, indent=4, sort_keys=True)
      print(output_json)

  # print(translation_output)

