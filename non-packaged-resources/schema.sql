create table facet_base(
	id serial,
	slot0 text,
	slot1 text,
	slot2 text,
	slot3 text,
	slot4 text
	);
	
create view facet as select
	id,
	regexp_replace(slot0||'/'||coalesce(slot1,'')||'/'||coalesce(slot2,'')||'/'||coalesce(slot3,'')||'/'||coalesce(slot4,''), '/+$','') as path,
	slot0,
	slot1,
	slot2,
	slot3,
	slot4
from facet_base;
	
insert into facet(slot0) values('Entity');
insert into facet(slot0,slot1) values('Entity','Person');
insert into facet(slot0,slot1) values('Entity','Educational Resource');
insert into facet(slot0,slot1,slot2) values('Entity','Person','Clinician');
insert into facet(slot0,slot1,slot2) values('Entity','Person','Basic Scientist');
