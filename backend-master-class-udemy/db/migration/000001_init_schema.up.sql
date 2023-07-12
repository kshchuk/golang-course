-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;

CREATE SEQUENCE account_account_id_seq;
CREATE SEQUENCE entry_entry_id_seq;
CREATE SEQUENCE transfer_transfer_id_seq;
	
CREATE TABLE IF NOT EXISTS public.account
(
    account_id bigint NOT NULL DEFAULT nextval('account_account_id_seq'::regclass),
    owner character varying(50) COLLATE pg_catalog."default" NOT NULL,
    balance bigint NOT NULL,
    currency character varying(5) COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT account_pkey PRIMARY KEY (account_id)
);

CREATE TABLE IF NOT EXISTS public.entry
(
    entry_id bigint NOT NULL DEFAULT nextval('entry_entry_id_seq'::regclass),
    account_id bigint NOT NULL,
    amount bigint,
    created_at timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT entry_pkey PRIMARY KEY (entry_id)
);

CREATE TABLE IF NOT EXISTS public.transfer
(
    transfer_id bigint NOT NULL DEFAULT nextval('transfer_transfer_id_seq'::regclass),
    from_account_id bigint NOT NULL,
    to_account_id bigint NOT NULL,
    amount bigint,
    created_at timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT transfer_pkey PRIMARY KEY (transfer_id)
);

ALTER TABLE IF EXISTS public.entry
    ADD FOREIGN KEY (account_id)
    REFERENCES public.account (account_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.transfer
    ADD FOREIGN KEY (from_account_id) REFERENCES public.account (account_id) MATCH SIMPLE
	ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
	
ALTER TABLE IF EXISTS public.transfer
	ADD FOREIGN KEY (to_account_id) REFERENCES public.account (account_id) MATCH SIMPLE
	ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


END;