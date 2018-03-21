-- This script is to clean up orphaned stuff in the 'delivery' database

-- We will start cleaning from pipelines down, as cleaning Enterprises
-- and Organisations has big impact if we get it wrong.

-- For now we dont touch the authz tables either

-- Clean up after missing PROJECTS
delete from project_user_roles         where project_id not in (select id from projects);
delete from notification_subscriptions where project_id not in (select id from projects);
delete from project_github_metadata    where project_id not in (select id from projects);
delete from project_bitbucket_metadata where project_id not in (select id from projects);
delete from project_commits            where project_id not in (select id from projects);
delete from pipelines                  where project_id not in (select id from projects);
delete from notification_config        where project_id not in (select id from projects);

-- Clean up after missing PIPELINES
delete from pipeline_user_roles        where pipeline_id not in (select id from pipelines);
delete from changes                    where pipeline_id not in (select id from pipelines);
delete from changesets                 where pipeline_id not in (select id from pipelines);
delete from dependency_failures        where pipeline_id not in (select id from pipelines);

-- Clean up after missing CHANGES
delete from patchsets                  where change_id not in (select id from changes);
delete from most_recent_patchsets      where change_id not in (select id from changes);
delete from stage_runs                 where change_id not in (select id from changes);
delete from scm_changes                where change_id not in (select id from changes);
delete from changesets                 where latest_change_id not in (select id from changes);


-- Clean up after missing CHANGESETS
delete from changes                    where changeset_id not in (select id from changesets);

-- Clean up after missing PATCHSETS
delete from reviews                    where patchset_id not in (select id from patchsets);
delete from comments                   where patchset_id not in (select id from patchsets);
delete from patchset_changed_files     where patchset_id not in (select id from patchsets);
delete from github_patchsets           where patchset_id not in (select id from patchsets);
delete from patchset_project_commits   where patchset_id not in (select id from patchsets);
delete from patchset_diffstats         where id not in (select id from patchsets);


-- Clean up after missing STAGERUNS
delete from phase_runs                 where stage_run_id not in (select id from stage_runs);

-- Clean up after missing PHASERUNS
delete from phase_run_logs             where run_id not in (select id from phase_runs);
