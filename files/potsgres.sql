CREATE TABLE IF NOT EXISTS public.channel
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    type_id channel_type NOT NULL,
    name character varying(32) COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    "timestamp" timestamp with time zone NOT NULL,
    CONSTRAINT channel_pkey PRIMARY KEY (id)
)

CREATE TABLE IF NOT EXISTS public.channel_users
(
    user_id integer NOT NULL,
    channel_id integer NOT NULL,
    CONSTRAINT channel_users_pkey PRIMARY KEY (user_id, channel_id),
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

CREATE TABLE IF NOT EXISTS public.community
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    user_id integer NOT NULL,
    name character varying(64) COLLATE pg_catalog."default",
    description text COLLATE pg_catalog."default",
    users_count integer,
    "timestamp" time with time zone NOT NULL,
    CONSTRAINT community_pkey PRIMARY KEY (id),
    CONSTRAINT user_pkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS public.community_users
(
    user_id integer NOT NULL,
    community_id integer NOT NULL,
    role community_role NOT NULL,
    CONSTRAINT community_users_pkey PRIMARY KEY (user_id, community_id),
    CONSTRAINT community_pkey FOREIGN KEY (community_id)
        REFERENCES public.community (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT user_pkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS public.hashtag
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    text character varying(32) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT hashtag_pkey PRIMARY KEY (id)
)

CREATE TABLE IF NOT EXISTS public.media
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    user_id integer NOT NULL,
    type media_type NOT NULL,
    url character varying(128) COLLATE pg_catalog."default" NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    CONSTRAINT media_pkey PRIMARY KEY (id),
    CONSTRAINT user_pkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS public.message
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    user_id integer NOT NULL,
    channel_id integer NOT NULL,
    text text COLLATE pg_catalog."default" NOT NULL,
    mentions_count integer,
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

CREATE TABLE IF NOT EXISTS public.message_last
(
    channel_id integer NOT NULL,
    message_id integer NOT NULL,
    CONSTRAINT message_last_pkey PRIMARY KEY (channel_id, message_id),
    CONSTRAINT channel_pkey FOREIGN KEY (channel_id)
        REFERENCES public.channel (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT message_pkey FOREIGN KEY (message_id)
        REFERENCES public.message (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS public.message_last_seen
(
    user_id integer NOT NULL,
    channel_id integer NOT NULL,
    message_id integer NOT NULL,
    CONSTRAINT message_last_seen_pkey PRIMARY KEY (user_id, channel_id, message_id),
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

CREATE TABLE IF NOT EXISTS public.message_mention
(
    user_id integer NOT NULL,
    channel_id integer NOT NULL,
    count integer NOT NULL,
    CONSTRAINT channel_pkey FOREIGN KEY (channel_id)
        REFERENCES public.channel (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT user_pkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.post
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    user_id integer NOT NULL,
    name character varying(64) COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    "timestamp" time with time zone NOT NULL,
    CONSTRAINT post_pkey PRIMARY KEY (id),
    CONSTRAINT user_pkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS public.post_audio
(
    post_id integer NOT NULL,
    media_id integer NOT NULL,
    CONSTRAINT post_audio_pkey PRIMARY KEY (post_id, media_id),
    CONSTRAINT media_pkey FOREIGN KEY (media_id)
        REFERENCES public.media (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT post_pkey FOREIGN KEY (post_id)
        REFERENCES public.post (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.post_cache
(
    post_id integer NOT NULL,
    likes_count integer,
    views_count integer,
    comments_count integer,
    CONSTRAINT post_cache_pkey PRIMARY KEY (post_id),
    CONSTRAINT post_pkey FOREIGN KEY (post_id)
        REFERENCES public.post (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.post_comment
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    reply_comment_id integer,
    text text COLLATE pg_catalog."default" NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    CONSTRAINT post_comment_pkey PRIMARY KEY (id),
    CONSTRAINT post_pkey FOREIGN KEY (post_id)
        REFERENCES public.post (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT reply_comment_pkey FOREIGN KEY (reply_comment_id)
        REFERENCES public.post_comment (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT user_pkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.post_hashtags
(
    post_id integer NOT NULL,
    hashtag_id integer NOT NULL,
    CONSTRAINT post_hashtags_pkey PRIMARY KEY (post_id, hashtag_id),
    CONSTRAINT hashtag_pkey FOREIGN KEY (hashtag_id)
        REFERENCES public.hashtag (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT post_pkey FOREIGN KEY (post_id)
        REFERENCES public.post (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.post_like
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    user_id integer NOT NULL,
    post_id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    CONSTRAINT post_like_pkey PRIMARY KEY (id),
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

CREATE TABLE IF NOT EXISTS public.post_photos
(
    post_id integer NOT NULL,
    media_id integer NOT NULL,
    CONSTRAINT post_photos_pkey PRIMARY KEY (post_id, media_id),
    CONSTRAINT media_pkey FOREIGN KEY (media_id)
        REFERENCES public.media (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT post_pkey FOREIGN KEY (post_id)
        REFERENCES public.post (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.post_video
(
    post_id integer NOT NULL,
    media_id integer NOT NULL,
    CONSTRAINT post_video_pkey PRIMARY KEY (post_id, media_id),
    CONSTRAINT media_pkey FOREIGN KEY (media_id)
        REFERENCES public.media (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT post_pkey FOREIGN KEY (post_id)
        REFERENCES public.post (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
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
    user_id integer NOT NULL,
    description text COLLATE pg_catalog."default",
    "timestamp" time with time zone NOT NULL,
    CONSTRAINT profile_pkey PRIMARY KEY (user_id),
    CONSTRAINT user_pkey FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS public.profile_photos
(
    profile_id integer NOT NULL,
    media_id integer NOT NULL,
    CONSTRAINT profile_photos_pkey PRIMARY KEY (profile_id, media_id),
    CONSTRAINT media_pkey FOREIGN KEY (media_id)
        REFERENCES public.media (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT profile_pkey FOREIGN KEY (profile_id)
        REFERENCES public.profile (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

CREATE TABLE IF NOT EXISTS public."user"
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(32) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT user_pkey PRIMARY KEY (id)
)
