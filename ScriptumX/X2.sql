BEGIN TRANSACTION;
CREATE TABLE "django_site" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(50) NOT NULL, "domain" varchar(100) NOT NULL UNIQUE);
INSERT INTO `django_site` (id,name,domain) VALUES (1,'example.com','example.com');
CREATE TABLE "django_session" ("session_key" varchar(40) NOT NULL PRIMARY KEY, "session_data" text NOT NULL, "expire_date" datetime NOT NULL);
CREATE TABLE "django_migrations" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "app" varchar(255) NOT NULL, "name" varchar(255) NOT NULL, "applied" datetime NOT NULL);
INSERT INTO `django_migrations` (id,app,name,applied) VALUES (1,'contenttypes','0001_initial','2016-04-15 06:29:45.116010'),
 (2,'auth','0001_initial','2016-04-15 06:29:45.166011'),
 (3,'X','0001_JK','2016-04-15 06:29:46.096020'),
 (4,'X','0002_JK','2016-04-15 06:29:46.266022'),
 (5,'X','0003_JK','2016-04-15 06:29:46.316022'),
 (6,'admin','0001_initial','2016-04-15 06:29:46.386023'),
 (7,'admin','0002_logentry_remove_auto_add','2016-04-15 06:29:46.456024'),
 (8,'contenttypes','0002_remove_content_type_name','2016-04-15 06:29:46.606025'),
 (9,'auth','0002_alter_permission_name_max_length','2016-04-15 06:29:46.686026'),
 (10,'auth','0003_alter_user_email_max_length','2016-04-15 06:29:46.756027'),
 (11,'auth','0004_alter_user_username_opts','2016-04-15 06:29:46.806027'),
 (12,'auth','0005_alter_user_last_login_null','2016-04-15 06:29:46.866028'),
 (13,'auth','0006_require_contenttypes_0002','2016-04-15 06:29:46.876028'),
 (14,'auth','0007_alter_validators_add_error_messages','2016-04-15 06:29:46.936028'),
 (15,'sessions','0001_initial','2016-04-15 06:29:46.956029'),
 (16,'sites','0001_initial','2016-04-15 06:29:46.996029'),
 (17,'sites','0002_alter_domain_unique','2016-04-15 06:29:47.016029');
CREATE TABLE "django_content_type" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "app_label" varchar(100) NOT NULL, "model" varchar(100) NOT NULL);
INSERT INTO `django_content_type` (id,app_label,model) VALUES (1,'auth','permission'),
 (2,'auth','group'),
 (3,'auth','user'),
 (4,'contenttypes','contenttype'),
 (5,'sessions','session'),
 (6,'sites','site'),
 (7,'admin','logentry'),
 (8,'X','project'),
 (9,'X','note'),
 (10,'X','gadget'),
 (11,'X','audio'),
 (12,'X','sfx'),
 (13,'X','person'),
 (14,'X','role'),
 (15,'X','location'),
 (16,'X','script'),
 (17,'X','scene'),
 (18,'X','sceneitem'),
 (19,'X','appointment'),
 (20,'X','appointment2scene');
CREATE TABLE "django_admin_log" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "object_id" text NULL, "object_repr" varchar(200) NOT NULL, "action_flag" smallint unsigned NOT NULL, "change_message" text NOT NULL, "content_type_id" integer NULL REFERENCES "django_content_type" ("id"), "user_id" integer NOT NULL REFERENCES "auth_user" ("id"), "action_time" datetime NOT NULL);
CREATE TABLE "auth_user_user_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" integer NOT NULL REFERENCES "auth_user" ("id"), "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id"));
CREATE TABLE "auth_user_groups" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" integer NOT NULL REFERENCES "auth_user" ("id"), "group_id" integer NOT NULL REFERENCES "auth_group" ("id"));
CREATE TABLE "auth_user" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "password" varchar(128) NOT NULL, "last_login" datetime NULL, "is_superuser" bool NOT NULL, "first_name" varchar(30) NOT NULL, "last_name" varchar(30) NOT NULL, "email" varchar(254) NOT NULL, "is_staff" bool NOT NULL, "is_active" bool NOT NULL, "date_joined" datetime NOT NULL, "username" varchar(30) NOT NULL UNIQUE);
CREATE TABLE "auth_permission" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "content_type_id" integer NOT NULL REFERENCES "django_content_type" ("id"), "codename" varchar(100) NOT NULL, "name" varchar(255) NOT NULL);
INSERT INTO `auth_permission` (id,content_type_id,codename,name) VALUES (1,1,'add_permission','Can add permission'),
 (2,1,'change_permission','Can change permission'),
 (3,1,'delete_permission','Can delete permission'),
 (4,2,'add_group','Can add group'),
 (5,2,'change_group','Can change group'),
 (6,2,'delete_group','Can delete group'),
 (7,3,'add_user','Can add user'),
 (8,3,'change_user','Can change user'),
 (9,3,'delete_user','Can delete user'),
 (10,4,'add_contenttype','Can add content type'),
 (11,4,'change_contenttype','Can change content type'),
 (12,4,'delete_contenttype','Can delete content type'),
 (13,5,'add_session','Can add session'),
 (14,5,'change_session','Can change session'),
 (15,5,'delete_session','Can delete session'),
 (16,6,'add_site','Can add site'),
 (17,6,'change_site','Can change site'),
 (18,6,'delete_site','Can delete site'),
 (19,7,'add_logentry','Can add log entry'),
 (20,7,'change_logentry','Can change log entry'),
 (21,7,'delete_logentry','Can delete log entry'),
 (22,8,'add_project','Can add project'),
 (23,8,'change_project','Can change project'),
 (24,8,'delete_project','Can delete project'),
 (25,9,'add_note','Can add note'),
 (26,9,'change_note','Can change note'),
 (27,9,'delete_note','Can delete note'),
 (28,10,'add_gadget','Can add gadget'),
 (29,10,'change_gadget','Can change gadget'),
 (30,10,'delete_gadget','Can delete gadget'),
 (31,11,'add_audio','Can add audio'),
 (32,11,'change_audio','Can change audio'),
 (33,11,'delete_audio','Can delete audio'),
 (34,12,'add_sfx','Can add sfx'),
 (35,12,'change_sfx','Can change sfx'),
 (36,12,'delete_sfx','Can delete sfx'),
 (37,13,'add_person','Can add person'),
 (38,13,'change_person','Can change person'),
 (39,13,'delete_person','Can delete person'),
 (40,14,'add_role','Can add role'),
 (41,14,'change_role','Can change role'),
 (42,14,'delete_role','Can delete role'),
 (43,15,'add_location','Can add location'),
 (44,15,'change_location','Can change location'),
 (45,15,'delete_location','Can delete location'),
 (46,16,'add_script','Can add script'),
 (47,16,'change_script','Can change script'),
 (48,16,'delete_script','Can delete script'),
 (49,17,'add_scene','Can add scene'),
 (50,17,'change_scene','Can change scene'),
 (51,17,'delete_scene','Can delete scene'),
 (52,18,'add_sceneitem','Can add scene item'),
 (53,18,'change_sceneitem','Can change scene item'),
 (54,18,'delete_sceneitem','Can delete scene item'),
 (55,19,'add_appointment','Can add appointment'),
 (56,19,'change_appointment','Can change appointment'),
 (57,19,'delete_appointment','Can delete appointment'),
 (58,20,'add_appointment2scene','Can add appointment2 scene'),
 (59,20,'change_appointment2scene','Can change appointment2 scene'),
 (60,20,'delete_appointment2scene','Can delete appointment2 scene');
CREATE TABLE "auth_group_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "group_id" integer NOT NULL REFERENCES "auth_group" ("id"), "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id"));
CREATE TABLE "auth_group" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(80) NOT NULL UNIQUE);
CREATE TABLE "X_sfx" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(50) NOT NULL, "description" text NOT NULL, "tag1" bool NOT NULL, "tag2" bool NOT NULL, "tag3" bool NOT NULL, "tag4" bool NOT NULL, "tag5" bool NOT NULL, "tag6" bool NOT NULL, "tag7" bool NOT NULL, "tag8" bool NOT NULL, "tag9" bool NOT NULL, "tag10" bool NOT NULL, "tag11" bool NOT NULL, "tag12" bool NOT NULL, "progress" smallint unsigned NOT NULL, "note_id" integer NULL REFERENCES "X_note" ("id"), "project_id" integer NOT NULL REFERENCES "X_project" ("id"));
CREATE TABLE "X_script_persons" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "script_id" integer NOT NULL REFERENCES "X_script" ("id"), "person_id" integer NOT NULL REFERENCES "X_person" ("id"));
CREATE TABLE "X_script" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "abstract" text NOT NULL, "description" text NOT NULL, "author" varchar(300) NOT NULL, "version" varchar(50) NOT NULL, "copyright" varchar(300) NOT NULL, "project_id" integer NOT NULL REFERENCES "X_project" ("id"), "name" varchar(50) NOT NULL);
CREATE TABLE "X_sceneitem" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "order" integer unsigned NOT NULL, "type" varchar(1) NOT NULL, "parenthetical" varchar(100) NOT NULL, "text" text NOT NULL, "role_id" integer NULL REFERENCES "X_role" ("id"), "scene_id" integer NULL REFERENCES "X_scene" ("id"));
CREATE TABLE "X_scene_sfxs" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "scene_id" integer NOT NULL REFERENCES "X_scene" ("id"), "sfx_id" integer NOT NULL REFERENCES "X_sfx" ("id"));
CREATE TABLE "X_scene_persons" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "scene_id" integer NOT NULL REFERENCES "X_scene" ("id"), "person_id" integer NOT NULL REFERENCES "X_person" ("id"));
CREATE TABLE "X_scene_gadgets" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "scene_id" integer NOT NULL REFERENCES "X_scene" ("id"), "gadget_id" integer NOT NULL REFERENCES "X_gadget" ("id"));
CREATE TABLE "X_scene_audios" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "scene_id" integer NOT NULL REFERENCES "X_scene" ("id"), "audio_id" integer NOT NULL REFERENCES "X_audio" ("id"));
CREATE TABLE "X_scene" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(50) NOT NULL, "description" text NOT NULL, "tag1" bool NOT NULL, "tag2" bool NOT NULL, "tag3" bool NOT NULL, "tag4" bool NOT NULL, "tag5" bool NOT NULL, "tag6" bool NOT NULL, "tag7" bool NOT NULL, "tag8" bool NOT NULL, "tag9" bool NOT NULL, "tag10" bool NOT NULL, "tag11" bool NOT NULL, "tag12" bool NOT NULL, "order" integer unsigned NOT NULL, "short" varchar(5) NOT NULL, "abstract" text NOT NULL, "indentation" integer unsigned NOT NULL, "color" varchar(10) NULL, "duration" bigint NULL, "progress_script" smallint unsigned NOT NULL, "progress_pre" smallint unsigned NOT NULL, "progress_shot" smallint unsigned NOT NULL, "progress_post" smallint unsigned NOT NULL, "note_id" integer NULL REFERENCES "X_note" ("id"), "project_id" integer NOT NULL REFERENCES "X_project" ("id"), "script_id" integer NOT NULL REFERENCES "X_script" ("id"), "set_location_id" integer NULL REFERENCES "X_location" ("id"));
CREATE TABLE "X_role_gadgets" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "role_id" integer NOT NULL REFERENCES "X_role" ("id"), "gadget_id" integer NOT NULL REFERENCES "X_gadget" ("id"));
CREATE TABLE "X_role" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(50) NOT NULL, "description" text NOT NULL, "tag1" bool NOT NULL, "tag2" bool NOT NULL, "tag3" bool NOT NULL, "tag4" bool NOT NULL, "tag5" bool NOT NULL, "tag6" bool NOT NULL, "tag7" bool NOT NULL, "tag8" bool NOT NULL, "tag9" bool NOT NULL, "tag10" bool NOT NULL, "tag11" bool NOT NULL, "tag12" bool NOT NULL, "color" varchar(10) NOT NULL, "actor_id" integer NULL REFERENCES "X_person" ("id"), "note_id" integer NULL REFERENCES "X_note" ("id"), "project_id" integer NOT NULL REFERENCES "X_project" ("id"));
CREATE TABLE "X_project_users" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "project_id" integer NOT NULL REFERENCES "X_project" ("id"), "user_id" integer NOT NULL REFERENCES "auth_user" ("id"));
CREATE TABLE "X_project_guests" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "project_id" integer NOT NULL REFERENCES "X_project" ("id"), "user_id" integer NOT NULL REFERENCES "auth_user" ("id"));
CREATE TABLE "X_project" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(50) NOT NULL, "owner_id" integer NOT NULL REFERENCES "auth_user" ("id"));
CREATE TABLE "X_person" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(50) NOT NULL, "description" text NOT NULL, "tag1" bool NOT NULL, "tag2" bool NOT NULL, "tag3" bool NOT NULL, "tag4" bool NOT NULL, "tag5" bool NOT NULL, "tag6" bool NOT NULL, "tag7" bool NOT NULL, "tag8" bool NOT NULL, "tag9" bool NOT NULL, "tag10" bool NOT NULL, "tag11" bool NOT NULL, "tag12" bool NOT NULL, "contact" text NOT NULL, "email" varchar(254) NOT NULL, "note_id" integer NULL REFERENCES "X_note" ("id"), "project_id" integer NOT NULL REFERENCES "X_project" ("id"));
CREATE TABLE "X_note" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "text" text NOT NULL, "created" datetime NOT NULL, "author_id" integer NULL REFERENCES "auth_user" ("id"), "project_id" integer NOT NULL REFERENCES "X_project" ("id"));
CREATE TABLE "X_location_persons" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "location_id" integer NOT NULL REFERENCES "X_location" ("id"), "person_id" integer NOT NULL REFERENCES "X_person" ("id"));
CREATE TABLE "X_location_gadgets" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "location_id" integer NOT NULL REFERENCES "X_location" ("id"), "gadget_id" integer NOT NULL REFERENCES "X_gadget" ("id"));
CREATE TABLE "X_location" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(50) NOT NULL, "description" text NOT NULL, "tag1" bool NOT NULL, "tag2" bool NOT NULL, "tag3" bool NOT NULL, "tag4" bool NOT NULL, "tag5" bool NOT NULL, "tag6" bool NOT NULL, "tag7" bool NOT NULL, "tag8" bool NOT NULL, "tag9" bool NOT NULL, "tag10" bool NOT NULL, "tag11" bool NOT NULL, "tag12" bool NOT NULL, "note_id" integer NULL REFERENCES "X_note" ("id"), "project_id" integer NOT NULL REFERENCES "X_project" ("id"));
CREATE TABLE "X_gadget" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(50) NOT NULL, "description" text NOT NULL, "tag1" bool NOT NULL, "tag2" bool NOT NULL, "tag3" bool NOT NULL, "tag4" bool NOT NULL, "tag5" bool NOT NULL, "tag6" bool NOT NULL, "tag7" bool NOT NULL, "tag8" bool NOT NULL, "tag9" bool NOT NULL, "tag10" bool NOT NULL, "tag11" bool NOT NULL, "tag12" bool NOT NULL, "progress" smallint unsigned NOT NULL, "note_id" integer NULL REFERENCES "X_note" ("id"), "project_id" integer NOT NULL REFERENCES "X_project" ("id"));
CREATE TABLE "X_audio" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(50) NOT NULL, "description" text NOT NULL, "tag1" bool NOT NULL, "tag2" bool NOT NULL, "tag3" bool NOT NULL, "tag4" bool NOT NULL, "tag5" bool NOT NULL, "tag6" bool NOT NULL, "tag7" bool NOT NULL, "tag8" bool NOT NULL, "tag9" bool NOT NULL, "tag10" bool NOT NULL, "tag11" bool NOT NULL, "tag12" bool NOT NULL, "progress" smallint unsigned NOT NULL, "note_id" integer NULL REFERENCES "X_note" ("id"), "project_id" integer NOT NULL REFERENCES "X_project" ("id"));
CREATE TABLE "X_appointment_persons" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "appointment_id" integer NOT NULL REFERENCES "X_appointment" ("id"), "person_id" integer NOT NULL REFERENCES "X_person" ("id"));
CREATE TABLE "X_appointment_gadgets" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "appointment_id" integer NOT NULL REFERENCES "X_appointment" ("id"), "gadget_id" integer NOT NULL REFERENCES "X_gadget" ("id"));
CREATE TABLE "X_appointment2scene" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "time" time NULL, "duration" bigint NULL, "appointment_id" integer NOT NULL REFERENCES "X_appointment" ("id"), "scene_id" integer NOT NULL REFERENCES "X_scene" ("id"));
CREATE TABLE "X_appointment" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(50) NOT NULL, "description" text NOT NULL, "tag1" bool NOT NULL, "tag2" bool NOT NULL, "tag3" bool NOT NULL, "tag4" bool NOT NULL, "tag5" bool NOT NULL, "tag6" bool NOT NULL, "tag7" bool NOT NULL, "tag8" bool NOT NULL, "tag9" bool NOT NULL, "tag10" bool NOT NULL, "tag11" bool NOT NULL, "tag12" bool NOT NULL, "time_all" datetime NULL, "duration_all" bigint NULL, "meeting_point_id" integer NULL REFERENCES "X_location" ("id"), "note_id" integer NULL REFERENCES "X_note" ("id"), "project_id" integer NOT NULL REFERENCES "X_project" ("id"));
CREATE INDEX "django_session_de54fa62" ON "django_session" ("expire_date");
CREATE UNIQUE INDEX "django_content_type_app_label_76bd3d3b_uniq" ON "django_content_type" ("app_label", "model");
CREATE INDEX "django_admin_log_e8701ad4" ON "django_admin_log" ("user_id");
CREATE INDEX "django_admin_log_417f1b1c" ON "django_admin_log" ("content_type_id");
CREATE UNIQUE INDEX "auth_user_user_permissions_user_id_14a6b632_uniq" ON "auth_user_user_permissions" ("user_id", "permission_id");
CREATE INDEX "auth_user_user_permissions_e8701ad4" ON "auth_user_user_permissions" ("user_id");
CREATE INDEX "auth_user_user_permissions_8373b171" ON "auth_user_user_permissions" ("permission_id");
CREATE UNIQUE INDEX "auth_user_groups_user_id_94350c0c_uniq" ON "auth_user_groups" ("user_id", "group_id");
CREATE INDEX "auth_user_groups_e8701ad4" ON "auth_user_groups" ("user_id");
CREATE INDEX "auth_user_groups_0e939a4f" ON "auth_user_groups" ("group_id");
CREATE UNIQUE INDEX "auth_permission_content_type_id_01ab375a_uniq" ON "auth_permission" ("content_type_id", "codename");
CREATE INDEX "auth_permission_417f1b1c" ON "auth_permission" ("content_type_id");
CREATE UNIQUE INDEX "auth_group_permissions_group_id_0cd325b0_uniq" ON "auth_group_permissions" ("group_id", "permission_id");
CREATE INDEX "auth_group_permissions_8373b171" ON "auth_group_permissions" ("permission_id");
CREATE INDEX "auth_group_permissions_0e939a4f" ON "auth_group_permissions" ("group_id");
CREATE INDEX "X_sfx_b098ad43" ON "X_sfx" ("project_id");
CREATE INDEX "X_sfx_2115813b" ON "X_sfx" ("note_id");
CREATE UNIQUE INDEX "X_script_persons_script_id_aef98ab2_uniq" ON "X_script_persons" ("script_id", "person_id");
CREATE INDEX "X_script_persons_a8452ca7" ON "X_script_persons" ("person_id");
CREATE INDEX "X_script_persons_a19ff0c0" ON "X_script_persons" ("script_id");
CREATE INDEX "X_script_b098ad43" ON "X_script" ("project_id");
CREATE UNIQUE INDEX "X_scene_sfxs_scene_id_a0c3fb4b_uniq" ON "X_scene_sfxs" ("scene_id", "sfx_id");
CREATE INDEX "X_scene_sfxs_c34350a7" ON "X_scene_sfxs" ("scene_id");
CREATE INDEX "X_scene_sfxs_5f8ea551" ON "X_scene_sfxs" ("sfx_id");
CREATE INDEX "X_scene_c9c59f98" ON "X_scene" ("set_location_id");
CREATE INDEX "X_scene_b098ad43" ON "X_scene" ("project_id");
CREATE INDEX "X_scene_a19ff0c0" ON "X_scene" ("script_id");
CREATE INDEX "X_scene_2115813b" ON "X_scene" ("note_id");
CREATE UNIQUE INDEX "X_role_gadgets_role_id_ba7d19cc_uniq" ON "X_role_gadgets" ("role_id", "gadget_id");
CREATE INDEX "X_role_gadgets_84566833" ON "X_role_gadgets" ("role_id");
CREATE INDEX "X_role_gadgets_6b81b94a" ON "X_role_gadgets" ("gadget_id");
CREATE INDEX "X_role_b39fef6a" ON "X_role" ("actor_id");
CREATE INDEX "X_role_b098ad43" ON "X_role" ("project_id");
CREATE INDEX "X_role_2115813b" ON "X_role" ("note_id");
CREATE UNIQUE INDEX "X_project_users_project_id_f1d8e575_uniq" ON "X_project_users" ("project_id", "user_id");
CREATE INDEX "X_project_users_e8701ad4" ON "X_project_users" ("user_id");
CREATE INDEX "X_project_users_b098ad43" ON "X_project_users" ("project_id");
CREATE UNIQUE INDEX "X_project_guests_project_id_e6430c8a_uniq" ON "X_project_guests" ("project_id", "user_id");
CREATE INDEX "X_project_guests_e8701ad4" ON "X_project_guests" ("user_id");
CREATE INDEX "X_project_guests_b098ad43" ON "X_project_guests" ("project_id");
CREATE INDEX "X_project_5e7b1936" ON "X_project" ("owner_id");
CREATE INDEX "X_person_b098ad43" ON "X_person" ("project_id");
CREATE INDEX "X_person_2115813b" ON "X_person" ("note_id");
CREATE INDEX "X_note_b098ad43" ON "X_note" ("project_id");
CREATE INDEX "X_note_4f331e2f" ON "X_note" ("author_id");
CREATE UNIQUE INDEX "X_location_gadgets_location_id_b3505d27_uniq" ON "X_location_gadgets" ("location_id", "gadget_id");
CREATE INDEX "X_location_gadgets_e274a5da" ON "X_location_gadgets" ("location_id");
CREATE INDEX "X_location_gadgets_6b81b94a" ON "X_location_gadgets" ("gadget_id");
CREATE INDEX "X_location_b098ad43" ON "X_location" ("project_id");
CREATE INDEX "X_location_2115813b" ON "X_location" ("note_id");
CREATE INDEX "X_gadget_b098ad43" ON "X_gadget" ("project_id");
CREATE INDEX "X_gadget_2115813b" ON "X_gadget" ("note_id");
CREATE INDEX "X_audio_b098ad43" ON "X_audio" ("project_id");
CREATE INDEX "X_audio_2115813b" ON "X_audio" ("note_id");
CREATE INDEX "X_appointment_cbaff9c2" ON "X_appointment" ("meeting_point_id");
CREATE INDEX "X_appointment_b098ad43" ON "X_appointment" ("project_id");
CREATE INDEX "X_appointment_2115813b" ON "X_appointment" ("note_id");
CREATE INDEX "X_appointment2scene_c34350a7" ON "X_appointment2scene" ("scene_id");
CREATE INDEX "X_appointment2scene_54c91d3b" ON "X_appointment2scene" ("appointment_id");
COMMIT;
