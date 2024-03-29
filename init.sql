--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

-- Dumped from database version 14.9 (Debian 14.9-1.pgdg120+1)
-- Dumped by pg_dump version 14.9 (Debian 14.9-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Roles
--

CREATE ROLE config_service;
ALTER ROLE config_service WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD '${CONFIG_SERVICE_DB_PASSWORD}';
CREATE ROLE payments_service;
ALTER ROLE payments_service WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD '${PAYMENTS_SERVICE_DB_PASSWORD}';
-- CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;
CREATE ROLE tokens_service;
ALTER ROLE tokens_service WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD '${TOKENS_SERVICE_DB_PASSWORD}';
CREATE ROLE user_service;
ALTER ROLE user_service WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD '${USER_SERVICE_DB_PASSWORD}';


--
-- Name: config_service; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE config_service WITH TEMPLATE = template0 ENCODING = 'SQL_ASCII' LOCALE = 'C';


ALTER DATABASE config_service OWNER TO postgres;

\connect config_service

--
-- Name: configtype; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.configtype AS ENUM (
    'NATIVE',
    'PRISM_THRIFT'
);


ALTER TYPE public.configtype OWNER TO postgres;

--
-- Name: CAST (public.configtype AS character varying); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (public.configtype AS character varying) WITH INOUT AS IMPLICIT;


--
-- Name: CAST (character varying AS public.configtype); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (character varying AS public.configtype) WITH INOUT AS IMPLICIT;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: configs; Type: TABLE; Schema: public; Owner: config_service
--

CREATE TABLE public.configs (
    id bigint NOT NULL,
    user_ref character varying(255),
    activated boolean,
    ref character varying(255),
    created_at timestamp without time zone,
    name character varying(255),
    config_type public.configtype
);


ALTER TABLE public.configs OWNER TO config_service;

--
-- Name: configs_id_seq; Type: SEQUENCE; Schema: public; Owner: config_service
--

CREATE SEQUENCE public.configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.configs_id_seq OWNER TO config_service;

--
-- Name: configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: config_service
--

ALTER SEQUENCE public.configs_id_seq OWNED BY public.configs.id;


--
-- Name: native_configs; Type: TABLE; Schema: public; Owner: config_service
--

CREATE TABLE public.native_configs (
    id bigint NOT NULL,
    base_date character varying(255),
    decoder_key_generation_algorithm character varying(255),
    encryption_algorithm character varying(255),
    issuer_identification_no character varying(255),
    key_expiry_no character varying(255),
    key_revision_no character varying(255),
    key_type character varying(255),
    supply_group_code character varying(255),
    tariff_index character varying(255),
    token_carrier_type character varying(255),
    vending_key character varying(255),
    config_id bigint
);


ALTER TABLE public.native_configs OWNER TO config_service;

--
-- Name: native_configs_id_seq; Type: SEQUENCE; Schema: public; Owner: config_service
--

CREATE SEQUENCE public.native_configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.native_configs_id_seq OWNER TO config_service;

--
-- Name: native_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: config_service
--

ALTER SEQUENCE public.native_configs_id_seq OWNED BY public.native_configs.id;


--
-- Name: pricing; Type: TABLE; Schema: public; Owner: config_service
--

CREATE TABLE public.pricing (
    id bigint NOT NULL,
    credits double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.pricing OWNER TO config_service;

--
-- Name: pricing_id_seq; Type: SEQUENCE; Schema: public; Owner: config_service
--

CREATE SEQUENCE public.pricing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pricing_id_seq OWNER TO config_service;

--
-- Name: pricing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: config_service
--

ALTER SEQUENCE public.pricing_id_seq OWNED BY public.pricing.id;


--
-- Name: prism_thrift_configs; Type: TABLE; Schema: public; Owner: config_service
--

CREATE TABLE public.prism_thrift_configs (
    id bigint NOT NULL,
    encryption_algorithm character varying(255),
    host character varying(255),
    key_expiry_no character varying(255),
    key_revision_no character varying(255),
    password character varying(255),
    port character varying(255),
    realm character varying(255),
    supply_group_code character varying(255),
    tariff_index character varying(255),
    token_carrier_type character varying(255),
    username character varying(255),
    config_id bigint
);


ALTER TABLE public.prism_thrift_configs OWNER TO config_service;

--
-- Name: prism_thrift_configs_id_seq; Type: SEQUENCE; Schema: public; Owner: config_service
--

CREATE SEQUENCE public.prism_thrift_configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prism_thrift_configs_id_seq OWNER TO config_service;

--
-- Name: prism_thrift_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: config_service
--

ALTER SEQUENCE public.prism_thrift_configs_id_seq OWNED BY public.prism_thrift_configs.id;


--
-- Name: public_keys; Type: TABLE; Schema: public; Owner: config_service
--

CREATE TABLE public.public_keys (
    id bigint NOT NULL,
    key text,
    user_ref character varying(255),
    activated boolean,
    ref character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255)
);


ALTER TABLE public.public_keys OWNER TO config_service;

--
-- Name: public_keys_id_seq; Type: SEQUENCE; Schema: public; Owner: config_service
--

CREATE SEQUENCE public.public_keys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.public_keys_id_seq OWNER TO config_service;

--
-- Name: public_keys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: config_service
--

ALTER SEQUENCE public.public_keys_id_seq OWNED BY public.public_keys.id;


--
-- Name: configs id; Type: DEFAULT; Schema: public; Owner: config_service
--

ALTER TABLE ONLY public.configs ALTER COLUMN id SET DEFAULT nextval('public.configs_id_seq'::regclass);


--
-- Name: native_configs id; Type: DEFAULT; Schema: public; Owner: config_service
--

ALTER TABLE ONLY public.native_configs ALTER COLUMN id SET DEFAULT nextval('public.native_configs_id_seq'::regclass);


--
-- Name: pricing id; Type: DEFAULT; Schema: public; Owner: config_service
--

ALTER TABLE ONLY public.pricing ALTER COLUMN id SET DEFAULT nextval('public.pricing_id_seq'::regclass);


--
-- Name: prism_thrift_configs id; Type: DEFAULT; Schema: public; Owner: config_service
--

ALTER TABLE ONLY public.prism_thrift_configs ALTER COLUMN id SET DEFAULT nextval('public.prism_thrift_configs_id_seq'::regclass);


--
-- Name: public_keys id; Type: DEFAULT; Schema: public; Owner: config_service
--

ALTER TABLE ONLY public.public_keys ALTER COLUMN id SET DEFAULT nextval('public.public_keys_id_seq'::regclass);


--
-- Name: configs configs_pkey; Type: CONSTRAINT; Schema: public; Owner: config_service
--

ALTER TABLE ONLY public.configs
    ADD CONSTRAINT configs_pkey PRIMARY KEY (id);


--
-- Name: native_configs native_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: config_service
--

ALTER TABLE ONLY public.native_configs
    ADD CONSTRAINT native_configs_pkey PRIMARY KEY (id);


--
-- Name: pricing pricing_pkey; Type: CONSTRAINT; Schema: public; Owner: config_service
--

ALTER TABLE ONLY public.pricing
    ADD CONSTRAINT pricing_pkey PRIMARY KEY (id);


--
-- Name: prism_thrift_configs prism_thrift_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: config_service
--

ALTER TABLE ONLY public.prism_thrift_configs
    ADD CONSTRAINT prism_thrift_configs_pkey PRIMARY KEY (id);


--
-- Name: public_keys public_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: config_service
--

ALTER TABLE ONLY public.public_keys
    ADD CONSTRAINT public_keys_pkey PRIMARY KEY (id);


--
-- Name: prism_thrift_configs fkau9qw4b20tdgfexfl1ge9d2b9; Type: FK CONSTRAINT; Schema: public; Owner: config_service
--

ALTER TABLE ONLY public.prism_thrift_configs
    ADD CONSTRAINT fkau9qw4b20tdgfexfl1ge9d2b9 FOREIGN KEY (config_id) REFERENCES public.configs(id);


--
-- Name: native_configs fkiybtacddtxw7hscbjcyqaf5rj; Type: FK CONSTRAINT; Schema: public; Owner: config_service
--

ALTER TABLE ONLY public.native_configs
    ADD CONSTRAINT fkiybtacddtxw7hscbjcyqaf5rj FOREIGN KEY (config_id) REFERENCES public.configs(id);


GRANT ALL ON DATABASE config_service TO config_service;


--
-- Name: payments_service; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE payments_service WITH TEMPLATE = template0 ENCODING = 'SQL_ASCII' LOCALE = 'C';


ALTER DATABASE payments_service OWNER TO postgres;

\connect payments_service

--
-- Name: credits; Type: TABLE; Schema: public; Owner: payments_service
--

CREATE TABLE public.credits (
    id integer NOT NULL,
    ref character varying(255),
    purchase_date timestamp without time zone,
    user_ref character varying(255),
    value numeric(100,2),
    currency character varying(255),
    units numeric(10,2),
    payment_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.credits OWNER TO payments_service;

--
-- Name: credits_consumption; Type: TABLE; Schema: public; Owner: payments_service
--

CREATE TABLE public.credits_consumption (
    id integer NOT NULL,
    ref character varying(255),
    consumption_date timestamp without time zone,
    user_ref character varying(255),
    units numeric(10,2),
    token_ref character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.credits_consumption OWNER TO payments_service;

--
-- Name: credits_consumption_id_seq; Type: SEQUENCE; Schema: public; Owner: payments_service
--

CREATE SEQUENCE public.credits_consumption_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.credits_consumption_id_seq OWNER TO payments_service;

--
-- Name: credits_consumption_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: payments_service
--

ALTER SEQUENCE public.credits_consumption_id_seq OWNED BY public.credits_consumption.id;


--
-- Name: credits_id_seq; Type: SEQUENCE; Schema: public; Owner: payments_service
--

CREATE SEQUENCE public.credits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.credits_id_seq OWNER TO payments_service;

--
-- Name: credits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: payments_service
--

ALTER SEQUENCE public.credits_id_seq OWNED BY public.credits.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: payments_service
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    ref character varying(255),
    scheduled timestamp without time zone,
    fulfilled timestamp without time zone,
    result_code character varying(255),
    result_desc character varying(255),
    type character varying(255),
    value numeric(8,2),
    user_ref character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.payments OWNER TO payments_service;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: payments_service
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_id_seq OWNER TO payments_service;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: payments_service
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: unit_currency_value; Type: TABLE; Schema: public; Owner: payments_service
--

CREATE TABLE public.unit_currency_value (
    id integer NOT NULL,
    currency character varying(255),
    value numeric(10,2),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.unit_currency_value OWNER TO payments_service;

--
-- Name: unit_currency_value_id_seq; Type: SEQUENCE; Schema: public; Owner: payments_service
--

CREATE SEQUENCE public.unit_currency_value_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.unit_currency_value_id_seq OWNER TO payments_service;

--
-- Name: unit_currency_value_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: payments_service
--

ALTER SEQUENCE public.unit_currency_value_id_seq OWNED BY public.unit_currency_value.id;


--
-- Name: credits id; Type: DEFAULT; Schema: public; Owner: payments_service
--

ALTER TABLE ONLY public.credits ALTER COLUMN id SET DEFAULT nextval('public.credits_id_seq'::regclass);


--
-- Name: credits_consumption id; Type: DEFAULT; Schema: public; Owner: payments_service
--

ALTER TABLE ONLY public.credits_consumption ALTER COLUMN id SET DEFAULT nextval('public.credits_consumption_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: payments_service
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: unit_currency_value id; Type: DEFAULT; Schema: public; Owner: payments_service
--

ALTER TABLE ONLY public.unit_currency_value ALTER COLUMN id SET DEFAULT nextval('public.unit_currency_value_id_seq'::regclass);


--
-- Name: credits_consumption credits_consumption_pkey; Type: CONSTRAINT; Schema: public; Owner: payments_service
--

ALTER TABLE ONLY public.credits_consumption
    ADD CONSTRAINT credits_consumption_pkey PRIMARY KEY (id);


--
-- Name: credits credits_pkey; Type: CONSTRAINT; Schema: public; Owner: payments_service
--

ALTER TABLE ONLY public.credits
    ADD CONSTRAINT credits_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: payments_service
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: unit_currency_value unit_currency_value_pkey; Type: CONSTRAINT; Schema: public; Owner: payments_service
--

ALTER TABLE ONLY public.unit_currency_value
    ADD CONSTRAINT unit_currency_value_pkey PRIMARY KEY (id);


--
-- Name: credits fk_credits_payment_id_id; Type: FK CONSTRAINT; Schema: public; Owner: payments_service
--

ALTER TABLE ONLY public.credits
    ADD CONSTRAINT fk_credits_payment_id_id FOREIGN KEY (payment_id) REFERENCES public.payments(id);

GRANT ALL ON DATABASE payments_service TO payments_service;

--
-- Name: tokens_service; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE tokens_service WITH TEMPLATE = template0 ENCODING = 'SQL_ASCII' LOCALE = 'C';


ALTER DATABASE tokens_service OWNER TO postgres;

\connect tokens_service

--
-- Name: tokens; Type: TABLE; Schema: public; Owner: tokens_service
--

CREATE TABLE public.tokens (
    id bigint NOT NULL,
    ref character varying(255),
    token_no character varying(255),
    user_ref character varying(255),
    token_type character varying(255),
    created_at timestamp without time zone,
    meter_no character varying(255),
    request_id character varying(255)
);


ALTER TABLE public.tokens OWNER TO tokens_service;

--
-- Name: tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: tokens_service
--

CREATE SEQUENCE public.tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tokens_id_seq OWNER TO tokens_service;

--
-- Name: tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tokens_service
--

ALTER SEQUENCE public.tokens_id_seq OWNED BY public.tokens.id;


--
-- Name: tokens id; Type: DEFAULT; Schema: public; Owner: tokens_service
--

ALTER TABLE ONLY public.tokens ALTER COLUMN id SET DEFAULT nextval('public.tokens_id_seq'::regclass);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: tokens_service
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);

GRANT ALL ON DATABASE tokens_service TO tokens_service;

CREATE DATABASE user_service WITH TEMPLATE = template0 ENCODING = 'SQL_ASCII' LOCALE = 'C';


ALTER DATABASE user_service OWNER TO postgres;

\connect user_service

--
-- Name: notification_type; Type: TYPE; Schema: public; Owner: user_service
--

CREATE TYPE public.notification_type AS ENUM (
    'INFO',
    'WARNING',
    'ERROR'
);


ALTER TYPE public.notification_type OWNER TO user_service;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bank_accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bank_accounts (
    id integer NOT NULL,
    utility_id integer NOT NULL,
    bank_id integer NOT NULL,
    account_no character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.bank_accounts OWNER TO postgres;

--
-- Name: bank_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bank_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bank_accounts_id_seq OWNER TO postgres;

--
-- Name: bank_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bank_accounts_id_seq OWNED BY public.bank_accounts.id;


--
-- Name: banks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.banks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.banks OWNER TO postgres;

--
-- Name: banks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.banks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.banks_id_seq OWNER TO postgres;

--
-- Name: banks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.banks_id_seq OWNED BY public.banks.id;


--
-- Name: configs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.configs (
    id bigint NOT NULL,
    activated boolean,
    config_type character varying(255),
    created_at timestamp without time zone,
    name character varying(255),
    ref character varying(255),
    user_ref character varying(255)
);


ALTER TABLE public.configs OWNER TO postgres;

--
-- Name: configs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.configs_id_seq OWNER TO postgres;

--
-- Name: configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.configs_id_seq OWNED BY public.configs.id;


--
-- Name: credentials; Type: TABLE; Schema: public; Owner: user_service
--

CREATE TABLE public.credentials (
    id integer NOT NULL,
    key character varying(255),
    secret character varying(255),
    ref character varying(255),
    user_id integer,
    activated boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.credentials OWNER TO user_service;

--
-- Name: users; Type: TABLE; Schema: public; Owner: user_service
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    username character varying(255),
    phone_no character varying(255),
    image_url character varying(255),
    ref character varying(255),
    email character varying(255),
    password character varying(255),
    email_verified_at timestamp without time zone,
    activated boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    remember_token character varying(255)
);


ALTER TABLE public.users OWNER TO user_service;

--
-- Name: credentials_id_seq; Type: SEQUENCE; Schema: public; Owner: user_service
--

CREATE SEQUENCE public.credentials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.credentials_id_seq OWNER TO user_service;

--
-- Name: credentials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user_service
--

ALTER SEQUENCE public.credentials_id_seq OWNED BY public.users.id;


--
-- Name: credentials_id_seq1; Type: SEQUENCE; Schema: public; Owner: user_service
--

CREATE SEQUENCE public.credentials_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.credentials_id_seq1 OWNER TO user_service;

--
-- Name: credentials_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: user_service
--

ALTER SEQUENCE public.credentials_id_seq1 OWNED BY public.credentials.id;


--
-- Name: credentials_permissions; Type: TABLE; Schema: public; Owner: user_service
--

CREATE TABLE public.credentials_permissions (
    id integer NOT NULL,
    credentials_id integer,
    permission_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.credentials_permissions OWNER TO user_service;

--
-- Name: credentials_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: user_service
--

CREATE SEQUENCE public.credentials_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.credentials_permissions_id_seq OWNER TO user_service;

--
-- Name: credentials_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user_service
--

ALTER SEQUENCE public.credentials_permissions_id_seq OWNED BY public.credentials_permissions.id;


--
-- Name: meter_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meter_types (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    ref character varying(255)
);


ALTER TABLE public.meter_types OWNER TO postgres;

--
-- Name: meter_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.meter_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.meter_types_id_seq OWNER TO postgres;

--
-- Name: meter_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.meter_types_id_seq OWNED BY public.meter_types.id;


--
-- Name: meters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meters (
    id integer NOT NULL,
    no bigint NOT NULL,
    type_id integer NOT NULL,
    activated boolean NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    ref character varying(255)
);


ALTER TABLE public.meters OWNER TO postgres;

--
-- Name: meters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.meters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.meters_id_seq OWNER TO postgres;

--
-- Name: meters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.meters_id_seq OWNED BY public.meters.id;


--
-- Name: native_configs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.native_configs (
    id bigint NOT NULL,
    base_date character varying(255),
    decoder_key_generation_algorithm character varying(255),
    encryption_algorithm character varying(255),
    issuer_identification_no character varying(255),
    key_expiry_no character varying(255),
    key_revision_no character varying(255),
    key_type character varying(255),
    supply_group_code character varying(255),
    tariff_index character varying(255),
    token_carrier_type character varying(255),
    vending_key character varying(255),
    config_id bigint
);


ALTER TABLE public.native_configs OWNER TO postgres;

--
-- Name: native_configs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.native_configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.native_configs_id_seq OWNER TO postgres;

--
-- Name: native_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.native_configs_id_seq OWNED BY public.native_configs.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: user_service
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    type public.notification_type,
    subject character varying(255),
    text character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    ref character varying(255),
    affected character varying(255)
);


ALTER TABLE public.notifications OWNER TO user_service;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: user_service
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO user_service;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user_service
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: notifications_users; Type: TABLE; Schema: public; Owner: user_service
--

CREATE TABLE public.notifications_users (
    id integer NOT NULL,
    notification_ref character varying(255),
    user_ref character varying(255),
    read boolean,
    read_date timestamp without time zone
);


ALTER TABLE public.notifications_users OWNER TO user_service;

--
-- Name: notifications_users_id_seq; Type: SEQUENCE; Schema: public; Owner: user_service
--

CREATE SEQUENCE public.notifications_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_users_id_seq OWNER TO user_service;

--
-- Name: notifications_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user_service
--

ALTER SEQUENCE public.notifications_users_id_seq OWNED BY public.notifications_users.id;


--
-- Name: password_resets; Type: TABLE; Schema: public; Owner: user_service
--

CREATE TABLE public.password_resets (
    id integer NOT NULL,
    email character varying(255),
    token character varying(255),
    created_at timestamp without time zone
);


ALTER TABLE public.password_resets OWNER TO user_service;

--
-- Name: password_resets_id_seq; Type: SEQUENCE; Schema: public; Owner: user_service
--

CREATE SEQUENCE public.password_resets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.password_resets_id_seq OWNER TO user_service;

--
-- Name: password_resets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user_service
--

ALTER SEQUENCE public.password_resets_id_seq OWNED BY public.password_resets.id;


--
-- Name: payment_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_types (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.payment_types OWNER TO postgres;

--
-- Name: payment_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_types_id_seq OWNER TO postgres;

--
-- Name: payment_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_types_id_seq OWNED BY public.payment_types.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    subscriber_id integer NOT NULL,
    meter_id integer NOT NULL,
    type_id integer NOT NULL,
    token_id integer,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_id_seq OWNER TO postgres;

--
-- Name: permissions; Type: TABLE; Schema: public; Owner: user_service
--

CREATE TABLE public.permissions (
    id integer NOT NULL,
    name character varying(255),
    identifier character varying(255),
    ref character varying(255),
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.permissions OWNER TO user_service;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: user_service
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permissions_id_seq OWNER TO user_service;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user_service
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: pricing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pricing (
    id bigint NOT NULL,
    created_at timestamp without time zone,
    credits double precision,
    updated_at timestamp without time zone
);


ALTER TABLE public.pricing OWNER TO postgres;

--
-- Name: pricing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pricing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pricing_id_seq OWNER TO postgres;

--
-- Name: pricing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pricing_id_seq OWNED BY public.pricing.id;


--
-- Name: prism_thrift_configs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prism_thrift_configs (
    id bigint NOT NULL,
    encryption_algorithm character varying(255),
    host character varying(255),
    key_expiry_no character varying(255),
    key_revision_no character varying(255),
    password character varying(255),
    port character varying(255),
    realm character varying(255),
    supply_group_code character varying(255),
    tariff_index character varying(255),
    token_carrier_type character varying(255),
    username character varying(255),
    config_id bigint
);


ALTER TABLE public.prism_thrift_configs OWNER TO postgres;

--
-- Name: prism_thrift_configs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prism_thrift_configs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prism_thrift_configs_id_seq OWNER TO postgres;

--
-- Name: prism_thrift_configs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prism_thrift_configs_id_seq OWNED BY public.prism_thrift_configs.id;


--
-- Name: public_keys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.public_keys (
    id bigint NOT NULL,
    activated boolean NOT NULL,
    created_at timestamp without time zone,
    key text,
    name character varying(255),
    ref character varying(255),
    updated_at timestamp without time zone,
    user_ref character varying(255)
);


ALTER TABLE public.public_keys OWNER TO postgres;

--
-- Name: public_keys_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.public_keys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.public_keys_id_seq OWNER TO postgres;

--
-- Name: public_keys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.public_keys_id_seq OWNED BY public.public_keys.id;


--
-- Name: subscriber_meters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscriber_meters (
    id integer NOT NULL,
    subscriber_id integer NOT NULL,
    meter_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.subscriber_meters OWNER TO postgres;

--
-- Name: subscriber_meters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscriber_meters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscriber_meters_id_seq OWNER TO postgres;

--
-- Name: subscriber_meters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscriber_meters_id_seq OWNED BY public.subscriber_meters.id;


--
-- Name: subscriber_utilities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscriber_utilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscriber_utilities_id_seq OWNER TO postgres;

--
-- Name: subscribers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscribers (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    ref character varying(255),
    activated boolean,
    phone_no character varying(255)
);


ALTER TABLE public.subscribers OWNER TO postgres;

--
-- Name: subscribers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscribers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscribers_id_seq OWNER TO postgres;

--
-- Name: subscribers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscribers_id_seq OWNED BY public.subscribers.id;


--
-- Name: tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tokens (
    id bigint NOT NULL,
    created_at timestamp without time zone,
    meter_no character varying(255),
    ref character varying(255),
    request_id character varying(255),
    token_no character varying(255),
    token_type character varying(255),
    user_ref character varying(255)
);


ALTER TABLE public.tokens OWNER TO postgres;

--
-- Name: tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tokens_id_seq OWNER TO postgres;

--
-- Name: tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tokens_id_seq OWNED BY public.tokens.id;


--
-- Name: users_activity_log; Type: TABLE; Schema: public; Owner: user_service
--

CREATE TABLE public.users_activity_log (
    id integer NOT NULL,
    user_id integer,
    category_id integer,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    ref character varying(255)
);


ALTER TABLE public.users_activity_log OWNER TO user_service;

--
-- Name: user_activity_log_id_seq; Type: SEQUENCE; Schema: public; Owner: user_service
--

CREATE SEQUENCE public.user_activity_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_activity_log_id_seq OWNER TO user_service;

--
-- Name: user_activity_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user_service
--

ALTER SEQUENCE public.user_activity_log_id_seq OWNED BY public.users_activity_log.id;


--
-- Name: users_activity_categories; Type: TABLE; Schema: public; Owner: user_service
--

CREATE TABLE public.users_activity_categories (
    id integer NOT NULL,
    name character varying(255),
    ref character varying(255),
    notes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.users_activity_categories OWNER TO user_service;

--
-- Name: users_activity_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: user_service
--

CREATE SEQUENCE public.users_activity_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_activity_categories_id_seq OWNER TO user_service;

--
-- Name: users_activity_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user_service
--

ALTER SEQUENCE public.users_activity_categories_id_seq OWNED BY public.users_activity_categories.id;


--
-- Name: users_utilities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_utilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_utilities_id_seq OWNER TO postgres;

--
-- Name: users_utilities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_utilities (
    id integer DEFAULT nextval('public.users_utilities_id_seq'::regclass) NOT NULL,
    user_id integer NOT NULL,
    utility_id integer NOT NULL,
    updated_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    ref character varying(255) DEFAULT 'ref'::character varying NOT NULL
);


ALTER TABLE public.users_utilities OWNER TO postgres;

--
-- Name: utilities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilities (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    contact_phone_no character varying(255) NOT NULL,
    activated boolean DEFAULT true NOT NULL,
    unit_charge numeric(8,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    config_ref character varying(255),
    ref character varying(255)
);


ALTER TABLE public.utilities OWNER TO postgres;

--
-- Name: utilities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.utilities_id_seq OWNER TO postgres;

--
-- Name: utilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilities_id_seq OWNED BY public.utilities.id;


--
-- Name: utility_meters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utility_meters (
    id integer NOT NULL,
    utility_id integer NOT NULL,
    meter_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.utility_meters OWNER TO postgres;

--
-- Name: utility_meters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utility_meters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.utility_meters_id_seq OWNER TO postgres;

--
-- Name: utility_meters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utility_meters_id_seq OWNED BY public.utility_meters.id;


--
-- Name: configs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configs ALTER COLUMN id SET DEFAULT nextval('public.configs_id_seq'::regclass);


--
-- Name: credentials id; Type: DEFAULT; Schema: public; Owner: user_service
--

ALTER TABLE ONLY public.credentials ALTER COLUMN id SET DEFAULT nextval('public.credentials_id_seq1'::regclass);


--
-- Name: credentials_permissions id; Type: DEFAULT; Schema: public; Owner: user_service
--

ALTER TABLE ONLY public.credentials_permissions ALTER COLUMN id SET DEFAULT nextval('public.credentials_permissions_id_seq'::regclass);


--
-- Name: meters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meters ALTER COLUMN id SET DEFAULT nextval('public.meters_id_seq'::regclass);


--
-- Name: native_configs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.native_configs ALTER COLUMN id SET DEFAULT nextval('public.native_configs_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: user_service
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: notifications_users id; Type: DEFAULT; Schema: public; Owner: user_service
--

ALTER TABLE ONLY public.notifications_users ALTER COLUMN id SET DEFAULT nextval('public.notifications_users_id_seq'::regclass);


--
-- Name: password_resets id; Type: DEFAULT; Schema: public; Owner: user_service
--

ALTER TABLE ONLY public.password_resets ALTER COLUMN id SET DEFAULT nextval('public.password_resets_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: user_service
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: pricing id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pricing ALTER COLUMN id SET DEFAULT nextval('public.pricing_id_seq'::regclass);


--
-- Name: prism_thrift_configs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prism_thrift_configs ALTER COLUMN id SET DEFAULT nextval('public.prism_thrift_configs_id_seq'::regclass);


--
-- Name: public_keys id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.public_keys ALTER COLUMN id SET DEFAULT nextval('public.public_keys_id_seq'::regclass);


--
-- Name: subscriber_meters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscriber_meters ALTER COLUMN id SET DEFAULT nextval('public.subscriber_meters_id_seq'::regclass);


--
-- Name: subscribers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscribers ALTER COLUMN id SET DEFAULT nextval('public.subscribers_id_seq'::regclass);


--
-- Name: tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tokens ALTER COLUMN id SET DEFAULT nextval('public.tokens_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: user_service
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.credentials_id_seq'::regclass);


--
-- Name: users_activity_categories id; Type: DEFAULT; Schema: public; Owner: user_service
--

ALTER TABLE ONLY public.users_activity_categories ALTER COLUMN id SET DEFAULT nextval('public.users_activity_categories_id_seq'::regclass);


--
-- Name: users_activity_log id; Type: DEFAULT; Schema: public; Owner: user_service
--

ALTER TABLE ONLY public.users_activity_log ALTER COLUMN id SET DEFAULT nextval('public.user_activity_log_id_seq'::regclass);


--
-- Name: utilities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilities ALTER COLUMN id SET DEFAULT nextval('public.utilities_id_seq'::regclass);


--
-- Name: utility_meters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utility_meters ALTER COLUMN id SET DEFAULT nextval('public.utility_meters_id_seq'::regclass);


--
-- Name: configs configs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configs
    ADD CONSTRAINT configs_pkey PRIMARY KEY (id);


--
-- Name: credentials_permissions credentials_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: user_service
--

ALTER TABLE ONLY public.credentials_permissions
    ADD CONSTRAINT credentials_permissions_pkey PRIMARY KEY (id);


--
-- Name: users credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: user_service
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT credentials_pkey PRIMARY KEY (id);


--
-- Name: credentials credentials_pkey1; Type: CONSTRAINT; Schema: public; Owner: user_service
--

ALTER TABLE ONLY public.credentials
    ADD CONSTRAINT credentials_pkey1 PRIMARY KEY (id);


--
-- Name: meters meters_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meters
    ADD CONSTRAINT meters_pk PRIMARY KEY (id);


--
-- Name: native_configs native_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.native_configs
    ADD CONSTRAINT native_configs_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: user_service
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: notifications_users notifications_users_pkey; Type: CONSTRAINT; Schema: public; Owner: user_service
--

ALTER TABLE ONLY public.notifications_users
    ADD CONSTRAINT notifications_users_pkey PRIMARY KEY (id);


--
-- Name: password_resets password_resets_pkey; Type: CONSTRAINT; Schema: public; Owner: user_service
--

ALTER TABLE ONLY public.password_resets
    ADD CONSTRAINT password_resets_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: user_service
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: pricing pricing_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pricing
    ADD CONSTRAINT pricing_pkey PRIMARY KEY (id);


--
-- Name: prism_thrift_configs prism_thrift_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prism_thrift_configs
    ADD CONSTRAINT prism_thrift_configs_pkey PRIMARY KEY (id);


--
-- Name: public_keys public_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.public_keys
    ADD CONSTRAINT public_keys_pkey PRIMARY KEY (id);


--
-- Name: subscriber_meters subscriber_meters_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscriber_meters
    ADD CONSTRAINT subscriber_meters_pk PRIMARY KEY (id);


--
-- Name: subscribers subscribers_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscribers
    ADD CONSTRAINT subscribers_pk PRIMARY KEY (id);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);


--
-- Name: users_activity_log user_activity_log_pkey; Type: CONSTRAINT; Schema: public; Owner: user_service
--

ALTER TABLE ONLY public.users_activity_log
    ADD CONSTRAINT user_activity_log_pkey PRIMARY KEY (id);


--
-- Name: users_utilities users_utilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_utilities
    ADD CONSTRAINT users_utilities_pkey PRIMARY KEY (id);


--
-- Name: utilities utilities_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilities
    ADD CONSTRAINT utilities_pk PRIMARY KEY (id);


--
-- Name: utility_meters utility_meters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utility_meters
    ADD CONSTRAINT utility_meters_pkey PRIMARY KEY (id);


--
-- Name: users_activity_log fk_users_activity_log_user_id; Type: FK CONSTRAINT; Schema: public; Owner: user_service
--

ALTER TABLE ONLY public.users_activity_log
    ADD CONSTRAINT fk_users_activity_log_user_id FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: prism_thrift_configs fkau9qw4b20tdgfexfl1ge9d2b9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prism_thrift_configs
    ADD CONSTRAINT fkau9qw4b20tdgfexfl1ge9d2b9 FOREIGN KEY (config_id) REFERENCES public.configs(id);


--
-- Name: native_configs fkiybtacddtxw7hscbjcyqaf5rj; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.native_configs
    ADD CONSTRAINT fkiybtacddtxw7hscbjcyqaf5rj FOREIGN KEY (config_id) REFERENCES public.configs(id);

GRANT ALL ON DATABASE user_service TO user_service;

--
-- PostgreSQL database dump complete
--



