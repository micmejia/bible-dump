--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg120+1)
-- Dumped by pg_dump version 16.4

-- Started on 2024-08-31 16:15:40 PST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 857 (class 1247 OID 16391)
-- Name: Division; Type: TYPE; Schema: public; Owner: pgadmin
--

CREATE TYPE public."Division" AS ENUM (
    'Pentateuch',
    'HistoricalBook',
    'WisdomBook',
    'MajorProphet',
    'MinorProphet',
    'Gospel',
    'History',
    'PaulineEpistle',
    'GeneralEpistle',
    'Prophecy'
);


ALTER TYPE public."Division" OWNER TO pgadmin;

--
-- TOC entry 860 (class 1247 OID 16412)
-- Name: Testament; Type: TYPE; Schema: public; Owner: pgadmin
--

CREATE TYPE public."Testament" AS ENUM (
    'OldTestament',
    'NewTestament'
);


ALTER TYPE public."Testament" OWNER TO pgadmin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16417)
-- Name: Book; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public."Book" (
    id integer NOT NULL,
    name character varying NOT NULL,
    long_name character varying NOT NULL,
    book_number integer NOT NULL,
    abbreviation character varying NOT NULL,
    testament public."Testament" NOT NULL,
    division public."Division",
    description text
);


ALTER TABLE public."Book" OWNER TO pgadmin;

--
-- TOC entry 216 (class 1259 OID 16422)
-- Name: Book_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public."Book_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Book_id_seq" OWNER TO pgadmin;

--
-- TOC entry 3446 (class 0 OID 0)
-- Dependencies: 216
-- Name: Book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public."Book_id_seq" OWNED BY public."Book".id;


--
-- TOC entry 217 (class 1259 OID 16423)
-- Name: Chapter; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public."Chapter" (
    id integer NOT NULL,
    book_id integer NOT NULL,
    chapter_number integer NOT NULL,
    description text
);


ALTER TABLE public."Chapter" OWNER TO pgadmin;

--
-- TOC entry 218 (class 1259 OID 16428)
-- Name: Chapter_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public."Chapter_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Chapter_id_seq" OWNER TO pgadmin;

--
-- TOC entry 3447 (class 0 OID 0)
-- Dependencies: 218
-- Name: Chapter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public."Chapter_id_seq" OWNED BY public."Chapter".id;


--
-- TOC entry 219 (class 1259 OID 16429)
-- Name: Language; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public."Language" (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public."Language" OWNER TO pgadmin;

--
-- TOC entry 220 (class 1259 OID 16434)
-- Name: Language_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public."Language_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Language_id_seq" OWNER TO pgadmin;

--
-- TOC entry 3448 (class 0 OID 0)
-- Dependencies: 220
-- Name: Language_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public."Language_id_seq" OWNED BY public."Language".id;


--
-- TOC entry 221 (class 1259 OID 16435)
-- Name: TestamentName; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public."TestamentName" (
    id integer NOT NULL,
    translation_id integer NOT NULL,
    testament public."Testament" NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public."TestamentName" OWNER TO pgadmin;

--
-- TOC entry 222 (class 1259 OID 16440)
-- Name: TestamentName_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public."TestamentName_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."TestamentName_id_seq" OWNER TO pgadmin;

--
-- TOC entry 3449 (class 0 OID 0)
-- Dependencies: 222
-- Name: TestamentName_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public."TestamentName_id_seq" OWNED BY public."TestamentName".id;


--
-- TOC entry 223 (class 1259 OID 16441)
-- Name: Translation; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public."Translation" (
    id integer NOT NULL,
    language_id integer NOT NULL,
    name character varying NOT NULL,
    full_name character varying NOT NULL,
    year character varying,
    license character varying,
    description text,
    bible_name character varying
);


ALTER TABLE public."Translation" OWNER TO pgadmin;

--
-- TOC entry 224 (class 1259 OID 16446)
-- Name: TranslationBookName; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public."TranslationBookName" (
    id integer NOT NULL,
    translation_id integer NOT NULL,
    book_id integer NOT NULL,
    name character varying NOT NULL,
    long_name character varying
);


ALTER TABLE public."TranslationBookName" OWNER TO pgadmin;

--
-- TOC entry 225 (class 1259 OID 16451)
-- Name: TranslationBookName_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public."TranslationBookName_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."TranslationBookName_id_seq" OWNER TO pgadmin;

--
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 225
-- Name: TranslationBookName_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public."TranslationBookName_id_seq" OWNED BY public."TranslationBookName".id;


--
-- TOC entry 226 (class 1259 OID 16452)
-- Name: Translation_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public."Translation_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Translation_id_seq" OWNER TO pgadmin;

--
-- TOC entry 3451 (class 0 OID 0)
-- Dependencies: 226
-- Name: Translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public."Translation_id_seq" OWNED BY public."Translation".id;


--
-- TOC entry 227 (class 1259 OID 16453)
-- Name: Verse; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public."Verse" (
    id integer NOT NULL,
    chapter_id integer NOT NULL,
    verse_number integer NOT NULL
);


ALTER TABLE public."Verse" OWNER TO pgadmin;

--
-- TOC entry 228 (class 1259 OID 16456)
-- Name: VerseText; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public."VerseText" (
    id integer NOT NULL,
    translation_id integer NOT NULL,
    verse_id integer NOT NULL,
    verse character varying NOT NULL
);


ALTER TABLE public."VerseText" OWNER TO pgadmin;

--
-- TOC entry 229 (class 1259 OID 16461)
-- Name: VerseText_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public."VerseText_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."VerseText_id_seq" OWNER TO pgadmin;

--
-- TOC entry 3452 (class 0 OID 0)
-- Dependencies: 229
-- Name: VerseText_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public."VerseText_id_seq" OWNED BY public."VerseText".id;


--
-- TOC entry 230 (class 1259 OID 16462)
-- Name: Verse_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

CREATE SEQUENCE public."Verse_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Verse_id_seq" OWNER TO pgadmin;

--
-- TOC entry 3453 (class 0 OID 0)
-- Dependencies: 230
-- Name: Verse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public."Verse_id_seq" OWNED BY public."Verse".id;


--
-- TOC entry 231 (class 1259 OID 16463)
-- Name: _sqlx_migrations; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public._sqlx_migrations (
    version bigint NOT NULL,
    description text NOT NULL,
    installed_on timestamp with time zone DEFAULT now() NOT NULL,
    success boolean NOT NULL,
    checksum bytea NOT NULL,
    execution_time bigint NOT NULL
);


ALTER TABLE public._sqlx_migrations OWNER TO pgadmin;

--
-- TOC entry 232 (class 1259 OID 16469)
-- Name: fulltable; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.fulltable (
    id integer,
    translation character varying,
    book character varying,
    abbreviation character varying,
    book_name character varying,
    chapter integer,
    verse_number integer,
    verse character varying
);


ALTER TABLE public.fulltable OWNER TO pgadmin;

--
-- TOC entry 3252 (class 2604 OID 16474)
-- Name: Book id; Type: DEFAULT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Book" ALTER COLUMN id SET DEFAULT nextval('public."Book_id_seq"'::regclass);


--
-- TOC entry 3253 (class 2604 OID 16475)
-- Name: Chapter id; Type: DEFAULT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Chapter" ALTER COLUMN id SET DEFAULT nextval('public."Chapter_id_seq"'::regclass);


--
-- TOC entry 3254 (class 2604 OID 16476)
-- Name: Language id; Type: DEFAULT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Language" ALTER COLUMN id SET DEFAULT nextval('public."Language_id_seq"'::regclass);


--
-- TOC entry 3255 (class 2604 OID 16477)
-- Name: TestamentName id; Type: DEFAULT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."TestamentName" ALTER COLUMN id SET DEFAULT nextval('public."TestamentName_id_seq"'::regclass);


--
-- TOC entry 3256 (class 2604 OID 16478)
-- Name: Translation id; Type: DEFAULT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Translation" ALTER COLUMN id SET DEFAULT nextval('public."Translation_id_seq"'::regclass);


--
-- TOC entry 3257 (class 2604 OID 16479)
-- Name: TranslationBookName id; Type: DEFAULT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."TranslationBookName" ALTER COLUMN id SET DEFAULT nextval('public."TranslationBookName_id_seq"'::regclass);


--
-- TOC entry 3258 (class 2604 OID 16480)
-- Name: Verse id; Type: DEFAULT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Verse" ALTER COLUMN id SET DEFAULT nextval('public."Verse_id_seq"'::regclass);


--
-- TOC entry 3259 (class 2604 OID 16481)
-- Name: VerseText id; Type: DEFAULT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."VerseText" ALTER COLUMN id SET DEFAULT nextval('public."VerseText_id_seq"'::regclass);


--
-- TOC entry 3262 (class 2606 OID 16483)
-- Name: Book Book_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "Book_pkey" PRIMARY KEY (id);


--
-- TOC entry 3264 (class 2606 OID 16485)
-- Name: Chapter Chapter_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Chapter"
    ADD CONSTRAINT "Chapter_pkey" PRIMARY KEY (id);


--
-- TOC entry 3266 (class 2606 OID 16487)
-- Name: Language Language_name_key; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Language"
    ADD CONSTRAINT "Language_name_key" UNIQUE (name);


--
-- TOC entry 3268 (class 2606 OID 16489)
-- Name: Language Language_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Language"
    ADD CONSTRAINT "Language_pkey" PRIMARY KEY (id);


--
-- TOC entry 3270 (class 2606 OID 16491)
-- Name: TestamentName TestamentName_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."TestamentName"
    ADD CONSTRAINT "TestamentName_pkey" PRIMARY KEY (id);


--
-- TOC entry 3278 (class 2606 OID 16493)
-- Name: TranslationBookName TranslationBookName_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."TranslationBookName"
    ADD CONSTRAINT "TranslationBookName_pkey" PRIMARY KEY (id);


--
-- TOC entry 3272 (class 2606 OID 16495)
-- Name: Translation Translation_full_name_key; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Translation"
    ADD CONSTRAINT "Translation_full_name_key" UNIQUE (full_name);


--
-- TOC entry 3274 (class 2606 OID 16497)
-- Name: Translation Translation_name_key; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Translation"
    ADD CONSTRAINT "Translation_name_key" UNIQUE (name);


--
-- TOC entry 3276 (class 2606 OID 16499)
-- Name: Translation Translation_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Translation"
    ADD CONSTRAINT "Translation_pkey" PRIMARY KEY (id);


--
-- TOC entry 3282 (class 2606 OID 16501)
-- Name: VerseText VerseText_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."VerseText"
    ADD CONSTRAINT "VerseText_pkey" PRIMARY KEY (id);


--
-- TOC entry 3280 (class 2606 OID 16503)
-- Name: Verse Verse_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Verse"
    ADD CONSTRAINT "Verse_pkey" PRIMARY KEY (id);


--
-- TOC entry 3284 (class 2606 OID 16505)
-- Name: _sqlx_migrations _sqlx_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public._sqlx_migrations
    ADD CONSTRAINT _sqlx_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3285 (class 1259 OID 16506)
-- Name: fulltable_book_idx; Type: INDEX; Schema: public; Owner: pgadmin
--

CREATE INDEX fulltable_book_idx ON public.fulltable USING btree (book);


--
-- TOC entry 3286 (class 1259 OID 16507)
-- Name: fulltable_book_name_idx; Type: INDEX; Schema: public; Owner: pgadmin
--

CREATE INDEX fulltable_book_name_idx ON public.fulltable USING btree (book_name);


--
-- TOC entry 3287 (class 1259 OID 16508)
-- Name: fulltable_chapter_idx; Type: INDEX; Schema: public; Owner: pgadmin
--

CREATE INDEX fulltable_chapter_idx ON public.fulltable USING btree (chapter);


--
-- TOC entry 3288 (class 1259 OID 16509)
-- Name: fulltable_translation_idx; Type: INDEX; Schema: public; Owner: pgadmin
--

CREATE INDEX fulltable_translation_idx ON public.fulltable USING btree (translation);


--
-- TOC entry 3289 (class 1259 OID 16510)
-- Name: fulltable_verse_number_idx; Type: INDEX; Schema: public; Owner: pgadmin
--

CREATE INDEX fulltable_verse_number_idx ON public.fulltable USING btree (verse_number);


--
-- TOC entry 3290 (class 2606 OID 16511)
-- Name: Chapter Chapter_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Chapter"
    ADD CONSTRAINT "Chapter_book_id_fkey" FOREIGN KEY (book_id) REFERENCES public."Book"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3291 (class 2606 OID 16516)
-- Name: TestamentName TestamentName_translation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."TestamentName"
    ADD CONSTRAINT "TestamentName_translation_id_fkey" FOREIGN KEY (translation_id) REFERENCES public."Translation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3293 (class 2606 OID 16521)
-- Name: TranslationBookName TranslationBookName_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."TranslationBookName"
    ADD CONSTRAINT "TranslationBookName_book_id_fkey" FOREIGN KEY (book_id) REFERENCES public."Book"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3294 (class 2606 OID 16526)
-- Name: TranslationBookName TranslationBookName_translation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."TranslationBookName"
    ADD CONSTRAINT "TranslationBookName_translation_id_fkey" FOREIGN KEY (translation_id) REFERENCES public."Translation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3292 (class 2606 OID 16531)
-- Name: Translation Translation_language_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Translation"
    ADD CONSTRAINT "Translation_language_id_fkey" FOREIGN KEY (language_id) REFERENCES public."Language"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3296 (class 2606 OID 16536)
-- Name: VerseText VerseText_translation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."VerseText"
    ADD CONSTRAINT "VerseText_translation_id_fkey" FOREIGN KEY (translation_id) REFERENCES public."Translation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3297 (class 2606 OID 16541)
-- Name: VerseText VerseText_verse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."VerseText"
    ADD CONSTRAINT "VerseText_verse_id_fkey" FOREIGN KEY (verse_id) REFERENCES public."Verse"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3295 (class 2606 OID 16546)
-- Name: Verse Verse_chapter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Verse"
    ADD CONSTRAINT "Verse_chapter_id_fkey" FOREIGN KEY (chapter_id) REFERENCES public."Chapter"(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2024-08-31 16:15:45 PST

--
-- PostgreSQL database dump complete
--

