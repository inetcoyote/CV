CREATE TABLE "User"(
    "id" BIGINT NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "last_login" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "User" ADD PRIMARY KEY("id");
ALTER TABLE
    "User" ADD CONSTRAINT "user_email_unique" UNIQUE("email");
CREATE TABLE "Poll"(
    "id" BIGINT NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" TEXT NOT NULL,
    "start_time" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "end_time" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "allow_multiple_choices" BOOLEAN NOT NULL,
    "created_by" BIGINT NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "updated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "Poll" ADD PRIMARY KEY("id");
ALTER TABLE
    "Poll" ADD CONSTRAINT "poll_created_by_unique" UNIQUE("created_by");
CREATE TABLE "Option"(
    "id" BIGINT NOT NULL,
    "poll_id" BIGINT NOT NULL,
    "text" VARCHAR(255) NOT NULL,
    "order" INTEGER NOT NULL,
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "Option" ADD PRIMARY KEY("id");
ALTER TABLE
    "Option" ADD CONSTRAINT "option_poll_id_unique" UNIQUE("poll_id");
CREATE TABLE "Vote"(
    "id" BIGINT NOT NULL,
    "poll_id" BIGINT NOT NULL,
    "option_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "voted_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "client_ip" VARCHAR(255) NOT NULL,
    "new_column" BIGINT NOT NULL,
    "user_agent" TEXT NOT NULL,
    "auth_method" VARCHAR(255) CHECK
        ("auth_method" IN('')) NOT NULL
);
ALTER TABLE
    "Vote" ADD PRIMARY KEY("id");
ALTER TABLE
    "Vote" ADD CONSTRAINT "vote_poll_id_unique" UNIQUE("poll_id");
ALTER TABLE
    "Vote" ADD CONSTRAINT "vote_option_id_unique" UNIQUE("option_id");
ALTER TABLE
    "Vote" ADD CONSTRAINT "vote_user_id_unique" UNIQUE("user_id");
CREATE TABLE "PollResultCache"(
    "id" BIGINT NOT NULL,
    "poll_id" BIGINT NOT NULL,
    "option_id" BIGINT NOT NULL,
    "vote_count" BIGINT NOT NULL,
    "updated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
);
ALTER TABLE
    "PollResultCache" ADD PRIMARY KEY("id");
ALTER TABLE
    "PollResultCache" ADD CONSTRAINT "pollresultcache_poll_id_unique" UNIQUE("poll_id");
ALTER TABLE
    "PollResultCache" ADD CONSTRAINT "pollresultcache_option_id_unique" UNIQUE("option_id");
ALTER TABLE
    "Vote" ADD CONSTRAINT "vote_poll_id_foreign" FOREIGN KEY("poll_id") REFERENCES "Poll"("id");
ALTER TABLE
    "Poll" ADD CONSTRAINT "poll_created_by_foreign" FOREIGN KEY("created_by") REFERENCES "User"("id");
ALTER TABLE
    "PollResultCache" ADD CONSTRAINT "pollresultcache_option_id_foreign" FOREIGN KEY("option_id") REFERENCES "Option"("id");
ALTER TABLE
    "Vote" ADD CONSTRAINT "vote_option_id_foreign" FOREIGN KEY("option_id") REFERENCES "Option"("id");
ALTER TABLE
    "Option" ADD CONSTRAINT "option_poll_id_foreign" FOREIGN KEY("poll_id") REFERENCES "Poll"("id");
ALTER TABLE
    "Vote" ADD CONSTRAINT "vote_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "User"("id");
ALTER TABLE
    "PollResultCache" ADD CONSTRAINT "pollresultcache_poll_id_foreign" FOREIGN KEY("poll_id") REFERENCES "Poll"("id");