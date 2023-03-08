CREATE TABLE IF NOT EXISTS public.audio
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    user_id integer NOT NULL,
    path character varying(256) COLLATE pg_catalog."default" NOT NULL,
    type character varying(8) COLLATE pg_catalog."default" NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    description text COLLATE pg_catalog."default",
    CONSTRAINT audio_pkey PRIMARY KEY (id),
    CONSTRAINT user_pkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS public.audio_per_media
(
    audio_id integer NOT NULL,
    media_id integer NOT NULL,
    CONSTRAINT audio_ref_pkey PRIMARY KEY (audio_id, media_id),
    CONSTRAINT audio_pkey FOREIGN KEY (audio_id)
        REFERENCES public.audio (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT media_pkey FOREIGN KEY (media_id)
        REFERENCES public.media (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS public.channel
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    type_id integer NOT NULL,
    name character varying(32) COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    "timestamp" timestamp with time zone NOT NULL,
    CONSTRAINT channel_pkey PRIMARY KEY (id),
    CONSTRAINT type_pkey FOREIGN KEY (type_id)
        REFERENCES public.channel_type (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS public.channel_type
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    type character varying(8) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT channel_type_pkey PRIMARY KEY (id)
)

CREATE TABLE IF NOT EXISTS public.comment
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    other_comment_id integer,
    "timestamp" timestamp with time zone NOT NULL,
    CONSTRAINT comment_pkey PRIMARY KEY (id),
    CONSTRAINT other_comment_pkey FOREIGN KEY (other_comment_id)
        REFERENCES public.comment (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT post_pkey FOREIGN KEY (post_id)
        REFERENCES public.post (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT user_pkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.community
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    CONSTRAINT community_pkey PRIMARY KEY (id),
    CONSTRAINT post_pkey FOREIGN KEY (post_id)
        REFERENCES public.post (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT user_pkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS public.contact
(
    user_1_id integer NOT NULL,
    user_2_id integer NOT NULL,
    status integer NOT NULL,
    CONSTRAINT contact_pkey PRIMARY KEY (user_1_id, user_2_id),
    CONSTRAINT status_pkey FOREIGN KEY (status)
        REFERENCES public.contact_status (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT user_1_pkey FOREIGN KEY (user_1_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT user_2_pkey FOREIGN KEY (user_2_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS public.contact_status
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    status character varying(12) COLLATE pg_catalog."default",
    CONSTRAINT contact_status_pkey PRIMARY KEY (id)
)

CREATE TABLE IF NOT EXISTS public.last_message
(
    channel_id integer NOT NULL,
    message_id integer NOT NULL,
    CONSTRAINT last_message_pkey PRIMARY KEY (channel_id, message_id),
    CONSTRAINT channel_pkey FOREIGN KEY (channel_id)
        REFERENCES public.channel (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT message_pkey FOREIGN KEY (message_id)
        REFERENCES public.message (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS public.last_seen
(
    user_id integer NOT NULL,
    channel_id integer NOT NULL,
    message_id integer NOT NULL,
    CONSTRAINT last_seen_pkey PRIMARY KEY (user_id, channel_id, message_id),
    CONSTRAINT channel_pkey FOREIGN KEY (channel_id)
        REFERENCES public.channel (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT message_pkey FOREIGN KEY (message_id)
        REFERENCES public.message (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT user_pkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public."like"
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    CONSTRAINT like_pkey PRIMARY KEY (id),
    CONSTRAINT post_pkey FOREIGN KEY (post_id)
        REFERENCES public.post (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT user_pkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.media
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    type_id integer NOT NULL,
    CONSTRAINT media_pkey PRIMARY KEY (id),
    CONSTRAINT type_pkey FOREIGN KEY (type_id)
        REFERENCES public.media_type (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS public.media_type
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    type character(5) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT media_type_pkey PRIMARY KEY (id)
)

REATE TABLE IF NOT EXISTS public.message
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    user_id integer NOT NULL,
    channel_id integer NOT NULL,
    text text COLLATE pg_catalog."default" NOT NULL,
    "timestamp" time with time zone NOT NULL,
    CONSTRAINT message_pkey PRIMARY KEY (id),
    CONSTRAINT channel_pkey FOREIGN KEY (channel_id)
        REFERENCES public.channel (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT user_pkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS public.photo
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    user_id integer NOT NULL,
    path character varying(256) COLLATE pg_catalog."default" NOT NULL,
    type character varying(8) COLLATE pg_catalog."default" NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    description text COLLATE pg_catalog."default",
    CONSTRAINT photo_pkey PRIMARY KEY (id),
    CONSTRAINT user_pkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS public.photo_per_media
(
    photo_id integer NOT NULL,
    media_id integer NOT NULL,
    CONSTRAINT photo_ref_pkey PRIMARY KEY (photo_id, media_id),
    CONSTRAINT media_pkey FOREIGN KEY (media_id)
        REFERENCES public.media (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT photo_pkey FOREIGN KEY (photo_id)
        REFERENCES public.media (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.post
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(64) COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    CONSTRAINT post_pkey PRIMARY KEY (id)
)

CREATE TABLE IF NOT EXISTS public.post_views
(
    post_id integer NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT post_views_pkey PRIMARY KEY (post_id, user_id),
    CONSTRAINT post_pkey FOREIGN KEY (post_id)
        REFERENCES public.post (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.profile
(
    id integer NOT NULL,
    photo_id integer,
    city character varying(64) COLLATE pg_catalog."default",
    interests text COLLATE pg_catalog."default",
    description text COLLATE pg_catalog."default",
    "timestamp" timestamp with time zone NOT NULL,
    CONSTRAINT profile_pkey PRIMARY KEY (id),
    CONSTRAINT photo_pkey FOREIGN KEY (photo_id)
        REFERENCES public.photo (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public."user"
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(32) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT user_pkey PRIMARY KEY (id)
)

CREATE TABLE IF NOT EXISTS public.user_per_channel
(
    user_id integer NOT NULL,
    channel_id integer NOT NULL,
    CONSTRAINT user_per_channel_pkey PRIMARY KEY (user_id, channel_id),
    CONSTRAINT channel_pkey FOREIGN KEY (channel_id)
        REFERENCES public.channel (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT user_pkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS public.video
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    user_id integer NOT NULL,
    path character varying(256) COLLATE pg_catalog."default" NOT NULL,
    type character varying(8) COLLATE pg_catalog."default" NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    description text COLLATE pg_catalog."default",
    CONSTRAINT video_pkey PRIMARY KEY (id),
    CONSTRAINT user_pkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS public.video_per_media
(
    video_id integer NOT NULL,
    media_id integer NOT NULL,
    CONSTRAINT video_ref_pkey PRIMARY KEY (video_id, media_id),
    CONSTRAINT media_pkey FOREIGN KEY (media_id)
        REFERENCES public.media (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT video_pkey FOREIGN KEY (video_id)
        REFERENCES public.video (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
