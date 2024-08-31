import os
import glob
import json
import pandas as pd
import psycopg
import requests
import subprocess

from pathlib import Path

from chapters import CHAPTERS_COUNT

connection = psycopg.connect("dbname=bible_db user=pgadmin password=x host=127.0.0.1 port=5432", autocommit=True)

cursor = connection.cursor()
# cursor.execute("DROP DATABASE bible_test_db WITH (FORCE);")
cursor.execute("CREATE DATABASE bible_test_db;")

# with open(Path.cwd() / "versequick_schema.sql", mode ='r')as f:
#     cursor.execute(f.read())
# cursor.execute("COMMIT")

connection.close()


