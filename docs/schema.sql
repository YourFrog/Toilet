--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

-- Started on 2019-11-05 01:33:03

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
-- TOC entry 5 (class 2615 OID 17680)
-- Name: company; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA company;


ALTER SCHEMA company OWNER TO postgres;

--
-- TOC entry 7 (class 2615 OID 17681)
-- Name: device; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA device;


ALTER SCHEMA device OWNER TO postgres;

--
-- TOC entry 9 (class 2615 OID 17655)
-- Name: toilet; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA toilet;


ALTER SCHEMA toilet OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 199 (class 1259 OID 17682)
-- Name: common; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.common (
    added timestamp with time zone DEFAULT now() NOT NULL,
    adder bigint NOT NULL,
    modified timestamp with time zone,
    modifier bigint,
    ghost boolean DEFAULT false NOT NULL
);


ALTER TABLE public.common OWNER TO postgres;

--
-- TOC entry 2888 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN common.added; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.common.added IS 'data dodania wpisu';


--
-- TOC entry 2889 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN common.adder; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.common.adder IS 'Osoba która dodała wpis';


--
-- TOC entry 2890 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN common.modified; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.common.modified IS 'Data ostatniej modyfikacji';


--
-- TOC entry 2891 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN common.modifier; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.common.modifier IS 'Osoba która dokonała ostatniej modyfikacji';


--
-- TOC entry 2892 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN common.ghost; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.common.ghost IS 'Czy wiersz jest aktywny';


--
-- TOC entry 201 (class 1259 OID 17689)
-- Name: company; Type: TABLE; Schema: company; Owner: postgres
--

CREATE TABLE company.company (
    id_company integer NOT NULL,
    name character varying(32) NOT NULL,
    unique_token character varying(6) NOT NULL
)
INHERITS (public.common);


ALTER TABLE company.company OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 17687)
-- Name: company_id_company_seq; Type: SEQUENCE; Schema: company; Owner: postgres
--

CREATE SEQUENCE company.company_id_company_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE company.company_id_company_seq OWNER TO postgres;

--
-- TOC entry 2893 (class 0 OID 0)
-- Dependencies: 200
-- Name: company_id_company_seq; Type: SEQUENCE OWNED BY; Schema: company; Owner: postgres
--

ALTER SEQUENCE company.company_id_company_seq OWNED BY company.company.id_company;


--
-- TOC entry 204 (class 1259 OID 17712)
-- Name: device; Type: TABLE; Schema: company; Owner: postgres
--

CREATE TABLE company.device (
    id_device bigint NOT NULL,
    id_company bigint NOT NULL,
    active boolean DEFAULT false NOT NULL
)
INHERITS (public.common);


ALTER TABLE company.device OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 17732)
-- Name: space; Type: TABLE; Schema: company; Owner: postgres
--

CREATE TABLE company.space (
    id_space bigint NOT NULL,
    id_company bigint NOT NULL,
    name character varying(32) NOT NULL
)
INHERITS (public.common);


ALTER TABLE company.space OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 17702)
-- Name: device; Type: TABLE; Schema: device; Owner: postgres
--

CREATE TABLE device.device (
    id_device integer NOT NULL,
    unique_token character varying(32) NOT NULL,
    platform character varying(32) NOT NULL,
    push_token character varying(256)
)
INHERITS (public.common);


ALTER TABLE device.device OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 17700)
-- Name: device_id_device_seq; Type: SEQUENCE; Schema: device; Owner: postgres
--

CREATE SEQUENCE device.device_id_device_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE device.device_id_device_seq OWNER TO postgres;

--
-- TOC entry 2894 (class 0 OID 0)
-- Dependencies: 202
-- Name: device_id_device_seq; Type: SEQUENCE OWNED BY; Schema: device; Owner: postgres
--

ALTER SEQUENCE device.device_id_device_seq OWNED BY device.device.id_device;


--
-- TOC entry 208 (class 1259 OID 17762)
-- Name: reservation; Type: TABLE; Schema: toilet; Owner: postgres
--

CREATE TABLE toilet.reservation (
    id_reservation integer NOT NULL,
    id_toilet bigint NOT NULL,
    id_device bigint NOT NULL,
    target character varying(32) NOT NULL,
    decision_time timestamp with time zone
)
INHERITS (public.common);


ALTER TABLE toilet.reservation OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 17760)
-- Name: reservation_id_reservation_seq; Type: SEQUENCE; Schema: toilet; Owner: postgres
--

CREATE SEQUENCE toilet.reservation_id_reservation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE toilet.reservation_id_reservation_seq OWNER TO postgres;

--
-- TOC entry 2895 (class 0 OID 0)
-- Dependencies: 207
-- Name: reservation_id_reservation_seq; Type: SEQUENCE OWNED BY; Schema: toilet; Owner: postgres
--

ALTER SEQUENCE toilet.reservation_id_reservation_seq OWNED BY toilet.reservation.id_reservation;


--
-- TOC entry 206 (class 1259 OID 17746)
-- Name: toilet; Type: TABLE; Schema: toilet; Owner: postgres
--

CREATE TABLE toilet.toilet (
    id_toilet bigint NOT NULL,
    id_space bigint NOT NULL,
    name character varying(32) NOT NULL,
    cabine_size integer NOT NULL,
    urinal_size integer NOT NULL,
    cabine_time integer NOT NULL,
    urinal_time integer NOT NULL
)
INHERITS (public.common);


ALTER TABLE toilet.toilet OWNER TO postgres;

--
-- TOC entry 2718 (class 2604 OID 17692)
-- Name: company added; Type: DEFAULT; Schema: company; Owner: postgres
--

ALTER TABLE ONLY company.company ALTER COLUMN added SET DEFAULT now();


--
-- TOC entry 2719 (class 2604 OID 17693)
-- Name: company ghost; Type: DEFAULT; Schema: company; Owner: postgres
--

ALTER TABLE ONLY company.company ALTER COLUMN ghost SET DEFAULT false;


--
-- TOC entry 2720 (class 2604 OID 17694)
-- Name: company id_company; Type: DEFAULT; Schema: company; Owner: postgres
--

ALTER TABLE ONLY company.company ALTER COLUMN id_company SET DEFAULT nextval('company.company_id_company_seq'::regclass);


--
-- TOC entry 2724 (class 2604 OID 17715)
-- Name: device added; Type: DEFAULT; Schema: company; Owner: postgres
--

ALTER TABLE ONLY company.device ALTER COLUMN added SET DEFAULT now();


--
-- TOC entry 2725 (class 2604 OID 17716)
-- Name: device ghost; Type: DEFAULT; Schema: company; Owner: postgres
--

ALTER TABLE ONLY company.device ALTER COLUMN ghost SET DEFAULT false;


--
-- TOC entry 2727 (class 2604 OID 17735)
-- Name: space added; Type: DEFAULT; Schema: company; Owner: postgres
--

ALTER TABLE ONLY company.space ALTER COLUMN added SET DEFAULT now();


--
-- TOC entry 2728 (class 2604 OID 17736)
-- Name: space ghost; Type: DEFAULT; Schema: company; Owner: postgres
--

ALTER TABLE ONLY company.space ALTER COLUMN ghost SET DEFAULT false;


--
-- TOC entry 2721 (class 2604 OID 17705)
-- Name: device added; Type: DEFAULT; Schema: device; Owner: postgres
--

ALTER TABLE ONLY device.device ALTER COLUMN added SET DEFAULT now();


--
-- TOC entry 2722 (class 2604 OID 17706)
-- Name: device ghost; Type: DEFAULT; Schema: device; Owner: postgres
--

ALTER TABLE ONLY device.device ALTER COLUMN ghost SET DEFAULT false;


--
-- TOC entry 2723 (class 2604 OID 17707)
-- Name: device id_device; Type: DEFAULT; Schema: device; Owner: postgres
--

ALTER TABLE ONLY device.device ALTER COLUMN id_device SET DEFAULT nextval('device.device_id_device_seq'::regclass);


--
-- TOC entry 2731 (class 2604 OID 17765)
-- Name: reservation added; Type: DEFAULT; Schema: toilet; Owner: postgres
--

ALTER TABLE ONLY toilet.reservation ALTER COLUMN added SET DEFAULT now();


--
-- TOC entry 2732 (class 2604 OID 17766)
-- Name: reservation ghost; Type: DEFAULT; Schema: toilet; Owner: postgres
--

ALTER TABLE ONLY toilet.reservation ALTER COLUMN ghost SET DEFAULT false;


--
-- TOC entry 2733 (class 2604 OID 17767)
-- Name: reservation id_reservation; Type: DEFAULT; Schema: toilet; Owner: postgres
--

ALTER TABLE ONLY toilet.reservation ALTER COLUMN id_reservation SET DEFAULT nextval('toilet.reservation_id_reservation_seq'::regclass);


--
-- TOC entry 2729 (class 2604 OID 17749)
-- Name: toilet added; Type: DEFAULT; Schema: toilet; Owner: postgres
--

ALTER TABLE ONLY toilet.toilet ALTER COLUMN added SET DEFAULT now();


--
-- TOC entry 2730 (class 2604 OID 17750)
-- Name: toilet ghost; Type: DEFAULT; Schema: toilet; Owner: postgres
--

ALTER TABLE ONLY toilet.toilet ALTER COLUMN ghost SET DEFAULT false;


--
-- TOC entry 2735 (class 2606 OID 17699)
-- Name: company company_name_key; Type: CONSTRAINT; Schema: company; Owner: postgres
--

ALTER TABLE ONLY company.company
    ADD CONSTRAINT company_name_key UNIQUE (name);


--
-- TOC entry 2737 (class 2606 OID 17696)
-- Name: company company_pkey; Type: CONSTRAINT; Schema: company; Owner: postgres
--

ALTER TABLE ONLY company.company
    ADD CONSTRAINT company_pkey PRIMARY KEY (id_company);


--
-- TOC entry 2739 (class 2606 OID 17731)
-- Name: company company_unique_token_key; Type: CONSTRAINT; Schema: company; Owner: postgres
--

ALTER TABLE ONLY company.company
    ADD CONSTRAINT company_unique_token_key UNIQUE (unique_token);


--
-- TOC entry 2745 (class 2606 OID 17719)
-- Name: device device_pkey; Type: CONSTRAINT; Schema: company; Owner: postgres
--

ALTER TABLE ONLY company.device
    ADD CONSTRAINT device_pkey PRIMARY KEY (id_device, id_company);


--
-- TOC entry 2747 (class 2606 OID 17745)
-- Name: space space_id_company_name_key; Type: CONSTRAINT; Schema: company; Owner: postgres
--

ALTER TABLE ONLY company.space
    ADD CONSTRAINT space_id_company_name_key UNIQUE (id_company, name);


--
-- TOC entry 2749 (class 2606 OID 17738)
-- Name: space space_pkey; Type: CONSTRAINT; Schema: company; Owner: postgres
--

ALTER TABLE ONLY company.space
    ADD CONSTRAINT space_pkey PRIMARY KEY (id_space);


--
-- TOC entry 2741 (class 2606 OID 17709)
-- Name: device device_pkey; Type: CONSTRAINT; Schema: device; Owner: postgres
--

ALTER TABLE ONLY device.device
    ADD CONSTRAINT device_pkey PRIMARY KEY (id_device);


--
-- TOC entry 2743 (class 2606 OID 17711)
-- Name: device device_unique_token_key; Type: CONSTRAINT; Schema: device; Owner: postgres
--

ALTER TABLE ONLY device.device
    ADD CONSTRAINT device_unique_token_key UNIQUE (unique_token);


--
-- TOC entry 2755 (class 2606 OID 17769)
-- Name: reservation reservation_pkey; Type: CONSTRAINT; Schema: toilet; Owner: postgres
--

ALTER TABLE ONLY toilet.reservation
    ADD CONSTRAINT reservation_pkey PRIMARY KEY (id_reservation);


--
-- TOC entry 2751 (class 2606 OID 17754)
-- Name: toilet toilet_id_space_name_key; Type: CONSTRAINT; Schema: toilet; Owner: postgres
--

ALTER TABLE ONLY toilet.toilet
    ADD CONSTRAINT toilet_id_space_name_key UNIQUE (id_space, name);


--
-- TOC entry 2753 (class 2606 OID 17752)
-- Name: toilet toilet_pkey; Type: CONSTRAINT; Schema: toilet; Owner: postgres
--

ALTER TABLE ONLY toilet.toilet
    ADD CONSTRAINT toilet_pkey PRIMARY KEY (id_toilet);


--
-- TOC entry 2756 (class 2606 OID 17720)
-- Name: device device_id_company_fkey; Type: FK CONSTRAINT; Schema: company; Owner: postgres
--

ALTER TABLE ONLY company.device
    ADD CONSTRAINT device_id_company_fkey FOREIGN KEY (id_company) REFERENCES company.company(id_company);


--
-- TOC entry 2757 (class 2606 OID 17725)
-- Name: device device_id_device_fkey; Type: FK CONSTRAINT; Schema: company; Owner: postgres
--

ALTER TABLE ONLY company.device
    ADD CONSTRAINT device_id_device_fkey FOREIGN KEY (id_device) REFERENCES device.device(id_device);


--
-- TOC entry 2758 (class 2606 OID 17739)
-- Name: space space_id_company_fkey; Type: FK CONSTRAINT; Schema: company; Owner: postgres
--

ALTER TABLE ONLY company.space
    ADD CONSTRAINT space_id_company_fkey FOREIGN KEY (id_company) REFERENCES company.company(id_company);


--
-- TOC entry 2761 (class 2606 OID 17775)
-- Name: reservation reservation_id_device_fkey; Type: FK CONSTRAINT; Schema: toilet; Owner: postgres
--

ALTER TABLE ONLY toilet.reservation
    ADD CONSTRAINT reservation_id_device_fkey FOREIGN KEY (id_device) REFERENCES device.device(id_device);


--
-- TOC entry 2760 (class 2606 OID 17770)
-- Name: reservation reservation_id_toilet_fkey; Type: FK CONSTRAINT; Schema: toilet; Owner: postgres
--

ALTER TABLE ONLY toilet.reservation
    ADD CONSTRAINT reservation_id_toilet_fkey FOREIGN KEY (id_toilet) REFERENCES toilet.toilet(id_toilet);


--
-- TOC entry 2759 (class 2606 OID 17755)
-- Name: toilet toilet_id_space_fkey; Type: FK CONSTRAINT; Schema: toilet; Owner: postgres
--

ALTER TABLE ONLY toilet.toilet
    ADD CONSTRAINT toilet_id_space_fkey FOREIGN KEY (id_space) REFERENCES company.space(id_space);


-- Completed on 2019-11-05 01:33:03

--
-- PostgreSQL database dump complete
--

