
from pathlib import Path

import psycopg

from chapters import CHAPTERS_COUNT
from env import PG_DB, PG_PASS, PG_USER

connection = psycopg.connect(f"dbname={PG_DB} user={PG_USER} password={PG_PASS} host=127.0.0.1 port=5432", autocommit=True)

cursor = connection.cursor()
# cursor.execute("DROP DATABASE bible_test_db WITH (FORCE);")
cursor.execute("CREATE DATABASE bible_test_db;")

# with open(Path.cwd() / "versequick_schema.sql", mode ='r')as f:
#     cursor.execute(f.read())
# cursor.execute("COMMIT")

connection.close()


