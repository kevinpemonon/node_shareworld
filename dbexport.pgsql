--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2 (Debian 13.2-1.pgdg100+1)
-- Dumped by pg_dump version 13.2 (Debian 13.2-1.pgdg100+1)

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
-- Name: enum_offers_state; Type: TYPE; Schema: public; Owner: elyrsjaurycqki
--

CREATE TYPE public.enum_offers_state AS ENUM (
    'Comme neuf',
    'Bon état',
    'État Moyen',
    'À bricoler'
);


ALTER TYPE public.enum_offers_state OWNER TO elyrsjaurycqki;

--
-- Name: enum_offers_status; Type: TYPE; Schema: public; Owner: elyrsjaurycqki
--

CREATE TYPE public.enum_offers_status AS ENUM (
    'En cours(ouverte)',
    'Donné(fermée)',
    'Bannie(fermée)'
);


ALTER TYPE public.enum_offers_status OWNER TO elyrsjaurycqki;

--
-- Name: enum_users_status; Type: TYPE; Schema: public; Owner: elyrsjaurycqki
--

CREATE TYPE public.enum_users_status AS ENUM (
    'active',
    'inactive',
    'banned'
);


ALTER TYPE public.enum_users_status OWNER TO elyrsjaurycqki;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: elyrsjaurycqki
--

CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);


ALTER TABLE public."SequelizeMeta" OWNER TO elyrsjaurycqki;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: elyrsjaurycqki
--

CREATE TABLE public.addresses (
    id integer NOT NULL,
    street character varying(50) NOT NULL,
    city character varying(45) NOT NULL,
    zipcode character varying(20),
    complement text,
    number integer NOT NULL,
    latitude numeric(14,11),
    longitude numeric(14,11),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.addresses OWNER TO elyrsjaurycqki;

--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: elyrsjaurycqki
--

CREATE SEQUENCE public.addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.addresses_id_seq OWNER TO elyrsjaurycqki;

--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: elyrsjaurycqki
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: elyrsjaurycqki
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    label character varying(45) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    image_url character varying(255)
);


ALTER TABLE public.categories OWNER TO elyrsjaurycqki;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: elyrsjaurycqki
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO elyrsjaurycqki;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: elyrsjaurycqki
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: offers; Type: TABLE; Schema: public; Owner: elyrsjaurycqki
--

CREATE TABLE public.offers (
    id integer NOT NULL,
    label character varying(45) NOT NULL,
    description text NOT NULL,
    display_phone boolean,
    display_mail boolean,
    state public.enum_offers_state,
    status public.enum_offers_status,
    owner_id integer NOT NULL,
    exchange_address_id integer NOT NULL,
    category_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    is_owner_address boolean DEFAULT false NOT NULL
);


ALTER TABLE public.offers OWNER TO elyrsjaurycqki;

--
-- Name: offers_id_seq; Type: SEQUENCE; Schema: public; Owner: elyrsjaurycqki
--

CREATE SEQUENCE public.offers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offers_id_seq OWNER TO elyrsjaurycqki;

--
-- Name: offers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: elyrsjaurycqki
--

ALTER SEQUENCE public.offers_id_seq OWNED BY public.offers.id;


--
-- Name: pictures_offer; Type: TABLE; Schema: public; Owner: elyrsjaurycqki
--

CREATE TABLE public.pictures_offer (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    offer_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.pictures_offer OWNER TO elyrsjaurycqki;

--
-- Name: pictures_offer_id_seq; Type: SEQUENCE; Schema: public; Owner: elyrsjaurycqki
--

CREATE SEQUENCE public.pictures_offer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pictures_offer_id_seq OWNER TO elyrsjaurycqki;

--
-- Name: pictures_offer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: elyrsjaurycqki
--

ALTER SEQUENCE public.pictures_offer_id_seq OWNED BY public.pictures_offer.id;


--
-- Name: user_has_favorites; Type: TABLE; Schema: public; Owner: elyrsjaurycqki
--

CREATE TABLE public.user_has_favorites (
    user_id integer,
    offer_id integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.user_has_favorites OWNER TO elyrsjaurycqki;

--
-- Name: user_want_offers; Type: TABLE; Schema: public; Owner: elyrsjaurycqki
--

CREATE TABLE public.user_want_offers (
    user_id integer,
    offer_id integer,
    validate_by_owner boolean,
    validate_by_aquirer boolean,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.user_want_offers OWNER TO elyrsjaurycqki;

--
-- Name: users; Type: TABLE; Schema: public; Owner: elyrsjaurycqki
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    phone character varying(20),
    url_avatar character varying(255),
    credit integer NOT NULL,
    mail character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    status public.enum_users_status,
    note numeric(2,1),
    number_notes integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    address_id integer NOT NULL
);


ALTER TABLE public.users OWNER TO elyrsjaurycqki;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: elyrsjaurycqki
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO elyrsjaurycqki;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: elyrsjaurycqki
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: offers id; Type: DEFAULT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.offers ALTER COLUMN id SET DEFAULT nextval('public.offers_id_seq'::regclass);


--
-- Name: pictures_offer id; Type: DEFAULT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.pictures_offer ALTER COLUMN id SET DEFAULT nextval('public.pictures_offer_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: elyrsjaurycqki
--

COPY public."SequelizeMeta" (name) FROM stdin;
20210212235839-create-users.js
20210213140157-create-adresses.js
20210213143552-add-adress-field-to-users.js
20210213145044-create-categories.js
20210213150937-create-offers.js
20210213173025-create-pictures-offer.js
20210309124033-create-user-want-offer.js
20210309131601-create-user-has-favorites.js
20210311222612-change-address-latitude.js
20210311222907-change-address-longitude.js
20210327154611-add-category-field-url.js
20210404122322-add-is-owner-address-to-offers.js
20210409095839-change-offers-cascade-address.js
\.


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: elyrsjaurycqki
--

COPY public.addresses (id, street, city, zipcode, complement, number, latitude, longitude, created_at, updated_at) FROM stdin;
1	Rue Condorcet	Villejuif	94800		5	48.79830169678	2.36831855774	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02
2	Rue du moulin de la pointe	Paris	75013	Batiment A	38	48.82277679443	2.35656380653	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02
3	Rue des Archives	Paris	75004		43	48.86013486502	2.35690712929	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02
4	Rue Auguste Dorchain	Paris	75015		1	48.84501799151	2.29785561562	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02
5	Rue Oberkampf	Paris	75011		62	48.86694819925	2.38265633583	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: elyrsjaurycqki
--

COPY public.categories (id, label, created_at, updated_at, image_url) FROM stdin;
1	Autre	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02	\N
2	DVD et Blu-Ray	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02	\N
3	Informatique	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02	\N
4	Jeux-vidéo	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02	\N
5	Jouets	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02	\N
6	Meubles	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02	\N
7	Musique	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02	\N
8	Sports et loisirs	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02	\N
9	Vêtements et chaussures	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02	\N
\.


--
-- Data for Name: offers; Type: TABLE DATA; Schema: public; Owner: elyrsjaurycqki
--

COPY public.offers (id, label, description, display_phone, display_mail, state, status, owner_id, exchange_address_id, category_id, created_at, updated_at, is_owner_address) FROM stdin;
1	Guitare Folk	Il manque les cordes	t	t	Bon état	En cours(ouverte)	1	1	7	2021-03-10 01:00:00+01	2021-03-10 01:00:00+01	t
2	Guitare Acoustique		t	f	À bricoler	Donné(fermée)	1	5	7	2021-03-10 01:00:00+01	2021-03-10 01:00:00+01	f
3	Ballon de football		t	f	Comme neuf	En cours(ouverte)	1	1	8	2021-03-10 01:00:00+01	2021-03-10 01:00:00+01	t
4	Chaussures de randonnées		f	f	État Moyen	En cours(ouverte)	2	2	9	2021-03-10 01:00:00+01	2021-03-10 01:00:00+01	t
5	Souris d'ordinateur		t	t	État Moyen	En cours(ouverte)	2	2	3	2021-03-10 01:00:00+01	2021-03-10 01:00:00+01	t
6	DVD		t	t	Bon état	En cours(ouverte)	3	3	2	2021-03-10 01:00:00+01	2021-03-10 01:00:00+01	t
7	Pantalon en lin	Taille 40	t	t	État Moyen	En cours(ouverte)	3	4	9	2021-03-10 01:00:00+01	2021-03-10 01:00:00+01	f
\.


--
-- Data for Name: pictures_offer; Type: TABLE DATA; Schema: public; Owner: elyrsjaurycqki
--

COPY public.pictures_offer (id, name, url, offer_id, created_at, updated_at) FROM stdin;
1	guitare1	offers/guitare1.jpg	1	2021-03-10 01:00:00+01	2021-03-10 01:00:00+01
2	guitare2	offers/guitare2.jpg	1	2021-03-10 01:00:00+01	2021-03-10 01:00:00+01
3	guitare3	offers/guitare3.jpg	2	2021-03-10 01:00:00+01	2021-03-10 01:00:00+01
\.


--
-- Data for Name: user_has_favorites; Type: TABLE DATA; Schema: public; Owner: elyrsjaurycqki
--

COPY public.user_has_favorites (user_id, offer_id, created_at, updated_at) FROM stdin;
1	5	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02
2	1	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02
2	2	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02
\.


--
-- Data for Name: user_want_offers; Type: TABLE DATA; Schema: public; Owner: elyrsjaurycqki
--

COPY public.user_want_offers (user_id, offer_id, validate_by_owner, validate_by_aquirer, created_at, updated_at) FROM stdin;
2	1	f	f	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02
3	1	t	f	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02
2	2	f	f	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02
3	2	f	f	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02
3	3	f	f	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: elyrsjaurycqki
--

COPY public.users (id, first_name, last_name, phone, url_avatar, credit, mail, password_hash, status, note, number_notes, created_at, updated_at, address_id) FROM stdin;
1	John	Lennon	0645983236		10	john.lennon@gmail.com	rfhqozhfoqzehfoZFE	active	4.7	11	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02	1
2	Mathias	Dugamin	0725285454		50	mathias.dugamin@gmail.com	rfhqozhfoqzehfoZFE	banned	2.1	25	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02	2
3	Bob	Marley	0645983236		2	bob.marley@gmail.com	rfhqozhfoqzehfoZFE	active	4.9	56	2021-10-03 02:00:00+02	2021-10-03 02:00:00+02	3
\.


--
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: elyrsjaurycqki
--

SELECT pg_catalog.setval('public.addresses_id_seq', 5, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: elyrsjaurycqki
--

SELECT pg_catalog.setval('public.categories_id_seq', 9, true);


--
-- Name: offers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: elyrsjaurycqki
--

SELECT pg_catalog.setval('public.offers_id_seq', 7, true);


--
-- Name: pictures_offer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: elyrsjaurycqki
--

SELECT pg_catalog.setval('public.pictures_offer_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: elyrsjaurycqki
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: offers offers_pkey; Type: CONSTRAINT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_pkey PRIMARY KEY (id);


--
-- Name: pictures_offer pictures_offer_pkey; Type: CONSTRAINT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.pictures_offer
    ADD CONSTRAINT pictures_offer_pkey PRIMARY KEY (id);


--
-- Name: users users_mail_key; Type: CONSTRAINT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_mail_key UNIQUE (mail);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: offers offers_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: offers offers_exchange_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_exchange_address_id_fkey FOREIGN KEY (exchange_address_id) REFERENCES public.addresses(id);


--
-- Name: offers offers_exchange_address_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_exchange_address_id_fkey1 FOREIGN KEY (exchange_address_id) REFERENCES public.addresses(id);


--
-- Name: offers offers_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pictures_offer pictures_offer_offer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.pictures_offer
    ADD CONSTRAINT pictures_offer_offer_id_fkey FOREIGN KEY (offer_id) REFERENCES public.offers(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_has_favorites user_has_favorites_offer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.user_has_favorites
    ADD CONSTRAINT user_has_favorites_offer_id_fkey FOREIGN KEY (offer_id) REFERENCES public.offers(id) ON DELETE CASCADE;


--
-- Name: user_has_favorites user_has_favorites_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.user_has_favorites
    ADD CONSTRAINT user_has_favorites_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_want_offers user_want_offers_offer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.user_want_offers
    ADD CONSTRAINT user_want_offers_offer_id_fkey FOREIGN KEY (offer_id) REFERENCES public.offers(id) ON DELETE CASCADE;


--
-- Name: user_want_offers user_want_offers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.user_want_offers
    ADD CONSTRAINT user_want_offers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users users_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: elyrsjaurycqki
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.addresses(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- elyrsjaurycqkiQL database dump complete
--

