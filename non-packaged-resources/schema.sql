create table facet_base(
	fid serial,
	slot0 text,
	slot1 text,
	slot2 text,
	slot3 text,
	slot4 text
	);
	
create view facet as select
	fid,
	regexp_replace(slot0||'/'||coalesce(slot1,'')||'/'||coalesce(slot2,'')||'/'||coalesce(slot3,'')||'/'||coalesce(slot4,''), '/+$','') as path,
	slot0,
	slot1,
	slot2,
	slot3,
	slot4
from facet_base;

create table entity(
    eid serial,
    database_name text,
    schema_name text,
    table_name text,
    attribute_name text,
    value text
    );

create table mapping(
    fid int,
    eid int
    );
    
insert into facet(slot0) values('Entity');
insert into facet(slot0,slot1) values('Entity','Person');
insert into facet(slot0,slot1) values('Entity','Educational Resource');
insert into facet(slot0,slot1,slot2) values('Entity','Person','Clinician');
insert into facet(slot0,slot1,slot2) values('Entity','Person','Basic Scientist');
