module 0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_autonomy {
    entry fun append_thread_entry(arg0: u64, arg1: u64, arg2: u64) {
        assert_thread_write(arg0, arg1, arg2);
    }

    entry fun archive_project(arg0: u64, arg1: u64, arg2: u64) {
        assert_project_write_transition(arg0, arg1, arg2);
    }

    fun assert_board_read(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = grant(arg0, arg1, arg2);
        0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_authority::assert_grant_board_read_authority(&v0);
    }

    fun assert_board_write(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = grant(arg0, arg1, arg2);
        0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_authority::assert_grant_board_write_authority(&v0);
    }

    fun assert_project_read(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = grant(arg0, arg1, arg2);
        0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_authority::assert_grant_project_read_authority(&v0);
    }

    fun assert_project_write(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = grant(arg0, arg1, arg2);
        0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_authority::assert_grant_project_write_authority(&v0);
    }

    fun assert_project_write_assign(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = grant(arg0, arg1, arg2);
        0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_authority::assert_grant_project_write_assign_authority(&v0);
    }

    fun assert_project_write_share(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = grant(arg0, arg1, arg2);
        0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_authority::assert_grant_project_write_share_authority(&v0);
    }

    fun assert_project_write_transition(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = grant(arg0, arg1, arg2);
        0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_authority::assert_grant_project_write_transition_authority(&v0);
    }

    fun assert_task_read(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = grant(arg0, arg1, arg2);
        0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_authority::assert_grant_task_read_authority(&v0);
    }

    fun assert_task_write(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = grant(arg0, arg1, arg2);
        0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_authority::assert_grant_task_write_authority(&v0);
    }

    fun assert_task_write_assign(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = grant(arg0, arg1, arg2);
        0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_authority::assert_grant_task_write_assign_authority(&v0);
    }

    fun assert_task_write_share(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = grant(arg0, arg1, arg2);
        0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_authority::assert_grant_task_write_share_authority(&v0);
    }

    fun assert_task_write_transition(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = grant(arg0, arg1, arg2);
        0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_authority::assert_grant_task_write_transition_authority(&v0);
    }

    fun assert_thread_read(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = grant(arg0, arg1, arg2);
        0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_authority::assert_grant_thread_read_authority(&v0);
    }

    fun assert_thread_write(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = grant(arg0, arg1, arg2);
        0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_authority::assert_grant_thread_write_authority(&v0);
    }

    fun assert_thread_write_share(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = grant(arg0, arg1, arg2);
        0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_authority::assert_grant_thread_write_share_authority(&v0);
    }

    entry fun attach_project_artifact(arg0: u64, arg1: u64, arg2: u64) {
        assert_project_write_share(arg0, arg1, arg2);
    }

    entry fun attach_task_artifact(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_write_share(arg0, arg1, arg2);
    }

    entry fun bind_project_thread(arg0: u64, arg1: u64, arg2: u64) {
        assert_project_write(arg0, arg1, arg2);
    }

    entry fun block_task(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_write_transition(arg0, arg1, arg2);
    }

    entry fun cancel_task(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_write_transition(arg0, arg1, arg2);
    }

    entry fun checkpoint_task_progress(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_write(arg0, arg1, arg2);
    }

    entry fun claim_task(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_write_assign(arg0, arg1, arg2);
    }

    entry fun complete_task(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_write_transition(arg0, arg1, arg2);
    }

    entry fun create_project(arg0: u64, arg1: u64, arg2: u64) {
        assert_project_write_assign(arg0, arg1, arg2);
    }

    entry fun create_task(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_write_assign(arg0, arg1, arg2);
    }

    entry fun create_triage_project(arg0: u64, arg1: u64, arg2: u64) {
        assert_project_write_assign(arg0, arg1, arg2);
    }

    entry fun create_workspace_board(arg0: u64, arg1: u64, arg2: u64) {
        assert_board_write(arg0, arg1, arg2);
    }

    entry fun delegate_task(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_write_assign(arg0, arg1, arg2);
    }

    entry fun fail_task(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_write_transition(arg0, arg1, arg2);
    }

    fun grant(arg0: u64, arg1: u64, arg2: u64) : 0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_authority::AuthorityGrant {
        0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_authority::new_authority_grant(arg0, arg1, arg2)
    }

    entry fun link_thread_bundle(arg0: u64, arg1: u64, arg2: u64) {
        assert_thread_write_share(arg0, arg1, arg2);
    }

    entry fun open_thread_for_project(arg0: u64, arg1: u64, arg2: u64) {
        assert_thread_write(arg0, arg1, arg2);
    }

    entry fun open_thread_for_task(arg0: u64, arg1: u64, arg2: u64) {
        assert_thread_write(arg0, arg1, arg2);
    }

    entry fun read_project_projection(arg0: u64, arg1: u64, arg2: u64) {
        assert_project_read(arg0, arg1, arg2);
    }

    entry fun read_selector_snapshot(arg0: u64, arg1: u64, arg2: u64) {
        assert_board_read(arg0, arg1, arg2);
    }

    entry fun read_task_projection(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_read(arg0, arg1, arg2);
    }

    entry fun read_thread_projection(arg0: u64, arg1: u64, arg2: u64) {
        assert_thread_read(arg0, arg1, arg2);
    }

    entry fun read_workspace_board_projection(arg0: u64, arg1: u64, arg2: u64) {
        assert_board_read(arg0, arg1, arg2);
    }

    entry fun record_delegation_update(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_write(arg0, arg1, arg2);
    }

    entry fun renew_task_lease(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_write_transition(arg0, arg1, arg2);
    }

    entry fun reorder_projects(arg0: u64, arg1: u64, arg2: u64) {
        assert_board_write(arg0, arg1, arg2);
    }

    entry fun resolve_delegation(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_write_transition(arg0, arg1, arg2);
    }

    entry fun resolve_thread(arg0: u64, arg1: u64, arg2: u64) {
        assert_thread_write(arg0, arg1, arg2);
    }

    entry fun resume_task(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_write_transition(arg0, arg1, arg2);
    }

    entry fun set_next_up_project(arg0: u64, arg1: u64, arg2: u64) {
        assert_board_write(arg0, arg1, arg2);
    }

    entry fun set_project_blocker(arg0: u64, arg1: u64, arg2: u64) {
        assert_project_write(arg0, arg1, arg2);
    }

    entry fun set_project_next_move(arg0: u64, arg1: u64, arg2: u64) {
        assert_project_write(arg0, arg1, arg2);
    }

    entry fun set_project_priority_weight(arg0: u64, arg1: u64, arg2: u64) {
        assert_project_write(arg0, arg1, arg2);
    }

    entry fun set_project_queue_state(arg0: u64, arg1: u64, arg2: u64) {
        assert_project_write_transition(arg0, arg1, arg2);
    }

    entry fun set_project_status(arg0: u64, arg1: u64, arg2: u64) {
        assert_project_write_transition(arg0, arg1, arg2);
    }

    entry fun set_thread_attention_state(arg0: u64, arg1: u64, arg2: u64) {
        assert_thread_write(arg0, arg1, arg2);
    }

    entry fun start_task(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_write_transition(arg0, arg1, arg2);
    }

    entry fun start_task_run(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_write_transition(arg0, arg1, arg2);
    }

    entry fun update_project_summary(arg0: u64, arg1: u64, arg2: u64) {
        assert_project_write(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

