--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg120+1)
-- Dumped by pg_dump version 16.4

-- Started on 2024-09-01 00:48:22 PST

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
-- TOC entry 858 (class 1247 OID 17756)
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
-- TOC entry 861 (class 1247 OID 17778)
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
-- TOC entry 215 (class 1259 OID 17783)
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
-- TOC entry 216 (class 1259 OID 17788)
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
-- TOC entry 3449 (class 0 OID 0)
-- Dependencies: 216
-- Name: Book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public."Book_id_seq" OWNED BY public."Book".id;


--
-- TOC entry 217 (class 1259 OID 17789)
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
-- TOC entry 218 (class 1259 OID 17794)
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
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 218
-- Name: Chapter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public."Chapter_id_seq" OWNED BY public."Chapter".id;


--
-- TOC entry 219 (class 1259 OID 17795)
-- Name: Language; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public."Language" (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public."Language" OWNER TO pgadmin;

--
-- TOC entry 220 (class 1259 OID 17800)
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
-- TOC entry 3451 (class 0 OID 0)
-- Dependencies: 220
-- Name: Language_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public."Language_id_seq" OWNED BY public."Language".id;


--
-- TOC entry 221 (class 1259 OID 17801)
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
-- TOC entry 222 (class 1259 OID 17806)
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
-- TOC entry 3452 (class 0 OID 0)
-- Dependencies: 222
-- Name: TestamentName_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public."TestamentName_id_seq" OWNED BY public."TestamentName".id;


--
-- TOC entry 223 (class 1259 OID 17807)
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
-- TOC entry 224 (class 1259 OID 17812)
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
-- TOC entry 225 (class 1259 OID 17817)
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
-- TOC entry 3453 (class 0 OID 0)
-- Dependencies: 225
-- Name: TranslationBookName_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public."TranslationBookName_id_seq" OWNED BY public."TranslationBookName".id;


--
-- TOC entry 226 (class 1259 OID 17818)
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
-- TOC entry 3454 (class 0 OID 0)
-- Dependencies: 226
-- Name: Translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public."Translation_id_seq" OWNED BY public."Translation".id;


--
-- TOC entry 227 (class 1259 OID 17819)
-- Name: Verse; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public."Verse" (
    id integer NOT NULL,
    chapter_id integer NOT NULL,
    verse_number integer NOT NULL
);


ALTER TABLE public."Verse" OWNER TO pgadmin;

--
-- TOC entry 228 (class 1259 OID 17822)
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
-- TOC entry 229 (class 1259 OID 17827)
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
-- TOC entry 3455 (class 0 OID 0)
-- Dependencies: 229
-- Name: VerseText_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public."VerseText_id_seq" OWNED BY public."VerseText".id;


--
-- TOC entry 230 (class 1259 OID 17828)
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
-- TOC entry 3456 (class 0 OID 0)
-- Dependencies: 230
-- Name: Verse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pgadmin
--

ALTER SEQUENCE public."Verse_id_seq" OWNED BY public."Verse".id;


--
-- TOC entry 231 (class 1259 OID 17829)
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
-- TOC entry 232 (class 1259 OID 17835)
-- Name: fulltable; Type: TABLE; Schema: public; Owner: pgadmin
--

CREATE TABLE public.fulltable (
    id integer NOT NULL,
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
-- TOC entry 233 (class 1259 OID 17917)
-- Name: fulltable_id_seq; Type: SEQUENCE; Schema: public; Owner: pgadmin
--

ALTER TABLE public.fulltable ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.fulltable_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3253 (class 2604 OID 17840)
-- Name: Book id; Type: DEFAULT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Book" ALTER COLUMN id SET DEFAULT nextval('public."Book_id_seq"'::regclass);


--
-- TOC entry 3254 (class 2604 OID 17841)
-- Name: Chapter id; Type: DEFAULT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Chapter" ALTER COLUMN id SET DEFAULT nextval('public."Chapter_id_seq"'::regclass);


--
-- TOC entry 3255 (class 2604 OID 17842)
-- Name: Language id; Type: DEFAULT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Language" ALTER COLUMN id SET DEFAULT nextval('public."Language_id_seq"'::regclass);


--
-- TOC entry 3256 (class 2604 OID 17843)
-- Name: TestamentName id; Type: DEFAULT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."TestamentName" ALTER COLUMN id SET DEFAULT nextval('public."TestamentName_id_seq"'::regclass);


--
-- TOC entry 3257 (class 2604 OID 17844)
-- Name: Translation id; Type: DEFAULT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Translation" ALTER COLUMN id SET DEFAULT nextval('public."Translation_id_seq"'::regclass);


--
-- TOC entry 3258 (class 2604 OID 17845)
-- Name: TranslationBookName id; Type: DEFAULT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."TranslationBookName" ALTER COLUMN id SET DEFAULT nextval('public."TranslationBookName_id_seq"'::regclass);


--
-- TOC entry 3259 (class 2604 OID 17846)
-- Name: Verse id; Type: DEFAULT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Verse" ALTER COLUMN id SET DEFAULT nextval('public."Verse_id_seq"'::regclass);


--
-- TOC entry 3260 (class 2604 OID 17847)
-- Name: VerseText id; Type: DEFAULT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."VerseText" ALTER COLUMN id SET DEFAULT nextval('public."VerseText_id_seq"'::regclass);


--
-- TOC entry 3263 (class 2606 OID 17849)
-- Name: Book Book_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Book"
    ADD CONSTRAINT "Book_pkey" PRIMARY KEY (id);


--
-- TOC entry 3265 (class 2606 OID 17851)
-- Name: Chapter Chapter_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Chapter"
    ADD CONSTRAINT "Chapter_pkey" PRIMARY KEY (id);


--
-- TOC entry 3267 (class 2606 OID 17853)
-- Name: Language Language_name_key; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Language"
    ADD CONSTRAINT "Language_name_key" UNIQUE (name);


--
-- TOC entry 3269 (class 2606 OID 17855)
-- Name: Language Language_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Language"
    ADD CONSTRAINT "Language_pkey" PRIMARY KEY (id);


--
-- TOC entry 3271 (class 2606 OID 17857)
-- Name: TestamentName TestamentName_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."TestamentName"
    ADD CONSTRAINT "TestamentName_pkey" PRIMARY KEY (id);


--
-- TOC entry 3279 (class 2606 OID 17859)
-- Name: TranslationBookName TranslationBookName_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."TranslationBookName"
    ADD CONSTRAINT "TranslationBookName_pkey" PRIMARY KEY (id);


--
-- TOC entry 3273 (class 2606 OID 17861)
-- Name: Translation Translation_full_name_key; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Translation"
    ADD CONSTRAINT "Translation_full_name_key" UNIQUE (full_name);


--
-- TOC entry 3275 (class 2606 OID 17863)
-- Name: Translation Translation_name_key; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Translation"
    ADD CONSTRAINT "Translation_name_key" UNIQUE (name);


--
-- TOC entry 3277 (class 2606 OID 17865)
-- Name: Translation Translation_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Translation"
    ADD CONSTRAINT "Translation_pkey" PRIMARY KEY (id);


--
-- TOC entry 3283 (class 2606 OID 17867)
-- Name: VerseText VerseText_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."VerseText"
    ADD CONSTRAINT "VerseText_pkey" PRIMARY KEY (id);


--
-- TOC entry 3281 (class 2606 OID 17869)
-- Name: Verse Verse_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Verse"
    ADD CONSTRAINT "Verse_pkey" PRIMARY KEY (id);


--
-- TOC entry 3285 (class 2606 OID 17871)
-- Name: _sqlx_migrations _sqlx_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public._sqlx_migrations
    ADD CONSTRAINT _sqlx_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3290 (class 2606 OID 17919)
-- Name: fulltable fulltable_pkey; Type: CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public.fulltable
    ADD CONSTRAINT fulltable_pkey PRIMARY KEY (id);


--
-- TOC entry 3286 (class 1259 OID 17872)
-- Name: fulltable_book_idx; Type: INDEX; Schema: public; Owner: pgadmin
--

CREATE INDEX fulltable_book_idx ON public.fulltable USING btree (book);


--
-- TOC entry 3287 (class 1259 OID 17873)
-- Name: fulltable_book_name_idx; Type: INDEX; Schema: public; Owner: pgadmin
--

CREATE INDEX fulltable_book_name_idx ON public.fulltable USING btree (book_name);


--
-- TOC entry 3288 (class 1259 OID 17874)
-- Name: fulltable_chapter_idx; Type: INDEX; Schema: public; Owner: pgadmin
--

CREATE INDEX fulltable_chapter_idx ON public.fulltable USING btree (chapter);


--
-- TOC entry 3291 (class 1259 OID 17875)
-- Name: fulltable_translation_idx; Type: INDEX; Schema: public; Owner: pgadmin
--

CREATE INDEX fulltable_translation_idx ON public.fulltable USING btree (translation);


--
-- TOC entry 3292 (class 1259 OID 17876)
-- Name: fulltable_verse_number_idx; Type: INDEX; Schema: public; Owner: pgadmin
--

CREATE INDEX fulltable_verse_number_idx ON public.fulltable USING btree (verse_number);


--
-- TOC entry 3293 (class 2606 OID 17877)
-- Name: Chapter Chapter_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Chapter"
    ADD CONSTRAINT "Chapter_book_id_fkey" FOREIGN KEY (book_id) REFERENCES public."Book"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3294 (class 2606 OID 17882)
-- Name: TestamentName TestamentName_translation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."TestamentName"
    ADD CONSTRAINT "TestamentName_translation_id_fkey" FOREIGN KEY (translation_id) REFERENCES public."Translation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3296 (class 2606 OID 17887)
-- Name: TranslationBookName TranslationBookName_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."TranslationBookName"
    ADD CONSTRAINT "TranslationBookName_book_id_fkey" FOREIGN KEY (book_id) REFERENCES public."Book"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3297 (class 2606 OID 17892)
-- Name: TranslationBookName TranslationBookName_translation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."TranslationBookName"
    ADD CONSTRAINT "TranslationBookName_translation_id_fkey" FOREIGN KEY (translation_id) REFERENCES public."Translation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3295 (class 2606 OID 17897)
-- Name: Translation Translation_language_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Translation"
    ADD CONSTRAINT "Translation_language_id_fkey" FOREIGN KEY (language_id) REFERENCES public."Language"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3299 (class 2606 OID 17902)
-- Name: VerseText VerseText_translation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."VerseText"
    ADD CONSTRAINT "VerseText_translation_id_fkey" FOREIGN KEY (translation_id) REFERENCES public."Translation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3300 (class 2606 OID 17907)
-- Name: VerseText VerseText_verse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."VerseText"
    ADD CONSTRAINT "VerseText_verse_id_fkey" FOREIGN KEY (verse_id) REFERENCES public."Verse"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3298 (class 2606 OID 17912)
-- Name: Verse Verse_chapter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pgadmin
--

ALTER TABLE ONLY public."Verse"
    ADD CONSTRAINT "Verse_chapter_id_fkey" FOREIGN KEY (chapter_id) REFERENCES public."Chapter"(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2024-09-01 00:48:27 PST

--
-- PostgreSQL database dump complete
--

