create table entreprise
(
    siret        varchar(14) charset latin1  not null
        primary key,
    siren        varchar(9) charset latin1   not null,
    nom          varchar(128) charset latin1 null,
    representant varchar(128) charset latin1 null,
    description  varchar(256) charset latin1 null,
    telephone    varchar(16) charset latin1  null,
    email        varchar(128) charset latin1 null,
    ville        varchar(128) charset latin1 null,
    adresse      varchar(128)                null,
    code_postal  varchar(8) charset latin1   not null,
    url          varchar(128)                null
);

create table service_propose
(
    nom_service varchar(128) charset latin1 not null
        primary key
);

create table a_pour_service_entr
(
    nom   varchar(128) charset latin1 not null,
    siret varchar(14) charset latin1  not null,
    primary key (nom, siret),
    constraint FK_serv_entr
        foreign key (siret) references entreprise (siret),
    constraint FK_serv_serv
        foreign key (nom) references service_propose (nom_service)
);

create index FK_serv_entr_idx
    on a_pour_service_entr (siret);

create table service_web
(
    url_service  varchar(128) charset latin1 not null
        primary key,
    nom          varchar(128) charset latin1 not null,
    description  varchar(1000)               null,
    adresse      varchar(128)                null,
    telephone    varchar(128)                null,
    email        varchar(128)                null,
    num_registre varchar(128)                null,
    representant varchar(128)                null
);

create table a_pour_service_site
(
    nom varchar(128) charset latin1 not null,
    url varchar(128) charset latin1 not null,
    primary key (nom, url),
    constraint FK_serv_site
        foreign key (url) references service_web (url_service),
    constraint Fk_site
        foreign key (nom) references service_propose (nom_service)
);

create index FK_serv_site_idx
    on a_pour_service_site (url);

create table source
(
    url            varchar(128) charset latin1 not null
        primary key,
    nom            varchar(128) charset latin1 not null,
    respecte_afnor tinyint(1)                  not null
);

create table auteur
(
    nom        varchar(128) charset latin1 not null,
    url        varchar(128) charset latin1 not null,
    is_anonyme tinyint                     null,
    primary key (nom, url),
    constraint FK_auteur
        foreign key (url) references source (url)
);

create index FK_auteur_idx
    on auteur (url);

create table commentaire
(
    id          int auto_increment
        primary key,
    note        float                       not null,
    date        date                        not null,
    siret       varchar(14) charset latin1  null,
    source      varchar(128) charset latin1 not null,
    auteur      varchar(128) charset latin1 not null,
    url_service varchar(128) charset latin1 null,
    commentaire varchar(2000)               null,
    constraint FK_comm_entre
        foreign key (siret) references entreprise (siret),
    constraint FK_comm_serv
        foreign key (url_service) references service_web (url_service),
    constraint Fk_comm_aut
        foreign key (auteur, source) references auteur (nom, url)
);

create index FK_comm_entr_idx
    on commentaire (siret);

create index FK_comm_serv_idx
    on commentaire (url_service);

create index Fk_comm_aut_idx
    on commentaire (auteur, source);

create table zone_intervention
(
    nom_ville varchar(128) charset latin1 not null,
    siret     varchar(14) charset latin1  not null,
    primary key (nom_ville, siret),
    constraint FK_zone_interv
        foreign key (siret) references entreprise (siret)
);

create index FK_zone_interv_idx
    on zone_intervention (siret);


