module 0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::engram_authority {
    struct AuthorityGrant has drop, store {
        registry_version: u64,
        registry_digest: vector<u8>,
        resource: u64,
        parent_resource: u64,
        action_mask: u64,
    }

    public fun action_assign() : u64 {
        4
    }

    public fun action_mask_read() : u64 {
        1
    }

    public fun action_mask_write() : u64 {
        2
    }

    public fun action_mask_write_assign() : u64 {
        2 | 4
    }

    public fun action_mask_write_share() : u64 {
        2 | 16
    }

    public fun action_mask_write_transition() : u64 {
        2 | 8
    }

    public fun action_read() : u64 {
        1
    }

    public fun action_share() : u64 {
        16
    }

    public fun action_transition() : u64 {
        8
    }

    public fun action_write() : u64 {
        2
    }

    public fun assert_actions(arg0: u64, arg1: u64) {
        assert!(has_actions(arg0, arg1), 0);
    }

    public fun assert_board_read_authority(arg0: u64, arg1: u64) {
        assert_target_authority(arg0, arg1, 1, action_mask_read());
    }

    public fun assert_board_write_authority(arg0: u64, arg1: u64) {
        assert_target_authority(arg0, arg1, 1, action_mask_write());
    }

    public fun assert_child_authority(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert_target_authority(arg0, arg2, arg3, arg5);
        assert_parent_resource(arg1, arg4);
    }

    public fun assert_child_authority_any(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert_target_authority(arg0, arg2, arg3, arg6);
        assert_parent_resource_any(arg1, arg4, arg5);
    }

    public fun assert_grant_board_read_authority(arg0: &AuthorityGrant) {
        assert_grant_target_authority(arg0, 1, action_mask_read());
    }

    public fun assert_grant_board_write_authority(arg0: &AuthorityGrant) {
        assert_grant_target_authority(arg0, 1, action_mask_write());
    }

    public fun assert_grant_child_authority(arg0: &AuthorityGrant, arg1: u64, arg2: u64, arg3: u64) {
        assert_grant_registry_version(arg0);
        assert_child_authority(arg0.resource, arg0.parent_resource, arg0.action_mask, arg1, arg2, arg3);
    }

    public fun assert_grant_child_authority_any(arg0: &AuthorityGrant, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert_grant_registry_version(arg0);
        assert_child_authority_any(arg0.resource, arg0.parent_resource, arg0.action_mask, arg1, arg2, arg3, arg4);
    }

    public fun assert_grant_project_read_authority(arg0: &AuthorityGrant) {
        assert_grant_child_authority(arg0, 2, 1, action_mask_read());
    }

    public fun assert_grant_project_write_assign_authority(arg0: &AuthorityGrant) {
        assert_grant_child_authority(arg0, 2, 1, action_mask_write_assign());
    }

    public fun assert_grant_project_write_authority(arg0: &AuthorityGrant) {
        assert_grant_child_authority(arg0, 2, 1, action_mask_write());
    }

    public fun assert_grant_project_write_share_authority(arg0: &AuthorityGrant) {
        assert_grant_child_authority(arg0, 2, 1, action_mask_write_share());
    }

    public fun assert_grant_project_write_transition_authority(arg0: &AuthorityGrant) {
        assert_grant_child_authority(arg0, 2, 1, action_mask_write_transition());
    }

    public fun assert_grant_registry_version(arg0: &AuthorityGrant) {
        assert!(arg0.registry_version == 5, 3);
        assert!(arg0.registry_digest == registry_digest(), 4);
    }

    public fun assert_grant_target_authority(arg0: &AuthorityGrant, arg1: u64, arg2: u64) {
        assert_grant_registry_version(arg0);
        assert_target_authority(arg0.resource, arg0.action_mask, arg1, arg2);
    }

    public fun assert_grant_task_read_authority(arg0: &AuthorityGrant) {
        assert_grant_child_authority(arg0, 3, 2, action_mask_read());
    }

    public fun assert_grant_task_write_assign_authority(arg0: &AuthorityGrant) {
        assert_grant_child_authority(arg0, 3, 2, action_mask_write_assign());
    }

    public fun assert_grant_task_write_authority(arg0: &AuthorityGrant) {
        assert_grant_child_authority(arg0, 3, 2, action_mask_write());
    }

    public fun assert_grant_task_write_share_authority(arg0: &AuthorityGrant) {
        assert_grant_child_authority(arg0, 3, 2, action_mask_write_share());
    }

    public fun assert_grant_task_write_transition_authority(arg0: &AuthorityGrant) {
        assert_grant_child_authority(arg0, 3, 2, action_mask_write_transition());
    }

    public fun assert_grant_thread_read_authority(arg0: &AuthorityGrant) {
        assert_grant_child_authority_any(arg0, 4, 2, 3, action_mask_read());
    }

    public fun assert_grant_thread_write_authority(arg0: &AuthorityGrant) {
        assert_grant_child_authority_any(arg0, 4, 2, 3, action_mask_write());
    }

    public fun assert_grant_thread_write_share_authority(arg0: &AuthorityGrant) {
        assert_grant_child_authority_any(arg0, 4, 2, 3, action_mask_write_share());
    }

    public fun assert_parent_resource(arg0: u64, arg1: u64) {
        assert!(arg0 == arg1, 2);
    }

    public fun assert_parent_resource_any(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 == arg1 || arg0 == arg2, 2);
    }

    fun assert_project_authority(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert_child_authority(arg0, arg1, arg2, 2, 1, arg3);
    }

    public fun assert_project_parent_board(arg0: u64) {
        assert_parent_resource(arg0, 1);
    }

    public fun assert_project_read_authority(arg0: u64, arg1: u64, arg2: u64) {
        assert_project_authority(arg0, arg1, arg2, action_mask_read());
    }

    public fun assert_project_write_assign_authority(arg0: u64, arg1: u64, arg2: u64) {
        assert_project_authority(arg0, arg1, arg2, action_mask_write_assign());
    }

    public fun assert_project_write_authority(arg0: u64, arg1: u64, arg2: u64) {
        assert_project_authority(arg0, arg1, arg2, action_mask_write());
    }

    public fun assert_project_write_share_authority(arg0: u64, arg1: u64, arg2: u64) {
        assert_project_authority(arg0, arg1, arg2, action_mask_write_share());
    }

    public fun assert_project_write_transition_authority(arg0: u64, arg1: u64, arg2: u64) {
        assert_project_authority(arg0, arg1, arg2, action_mask_write_transition());
    }

    public fun assert_resource(arg0: u64, arg1: u64) {
        assert!(arg0 == arg1, 1);
    }

    public fun assert_target_authority(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert_resource(arg0, arg2);
        assert_actions(arg1, arg3);
    }

    fun assert_task_authority(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert_child_authority(arg0, arg1, arg2, 3, 2, arg3);
    }

    public fun assert_task_parent_project(arg0: u64) {
        assert_parent_resource(arg0, 2);
    }

    public fun assert_task_read_authority(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_authority(arg0, arg1, arg2, action_mask_read());
    }

    public fun assert_task_write_assign_authority(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_authority(arg0, arg1, arg2, action_mask_write_assign());
    }

    public fun assert_task_write_authority(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_authority(arg0, arg1, arg2, action_mask_write());
    }

    public fun assert_task_write_share_authority(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_authority(arg0, arg1, arg2, action_mask_write_share());
    }

    public fun assert_task_write_transition_authority(arg0: u64, arg1: u64, arg2: u64) {
        assert_task_authority(arg0, arg1, arg2, action_mask_write_transition());
    }

    fun assert_thread_authority(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert_child_authority_any(arg0, arg1, arg2, 4, 2, 3, arg3);
    }

    public fun assert_thread_parent_project_or_task(arg0: u64) {
        assert_parent_resource_any(arg0, 2, 3);
    }

    public fun assert_thread_read_authority(arg0: u64, arg1: u64, arg2: u64) {
        assert_thread_authority(arg0, arg1, arg2, action_mask_read());
    }

    public fun assert_thread_write_authority(arg0: u64, arg1: u64, arg2: u64) {
        assert_thread_authority(arg0, arg1, arg2, action_mask_write());
    }

    public fun assert_thread_write_share_authority(arg0: u64, arg1: u64, arg2: u64) {
        assert_thread_authority(arg0, arg1, arg2, action_mask_write_share());
    }

    public fun grant_action_mask(arg0: &AuthorityGrant) : u64 {
        arg0.action_mask
    }

    public fun grant_parent_resource(arg0: &AuthorityGrant) : u64 {
        arg0.parent_resource
    }

    public fun grant_registry_digest(arg0: &AuthorityGrant) : vector<u8> {
        arg0.registry_digest
    }

    public fun grant_registry_version(arg0: &AuthorityGrant) : u64 {
        arg0.registry_version
    }

    public fun grant_resource(arg0: &AuthorityGrant) : u64 {
        arg0.resource
    }

    public fun has_actions(arg0: u64, arg1: u64) : bool {
        arg0 & arg1 == arg1
    }

    public(friend) fun new_authority_grant(arg0: u64, arg1: u64, arg2: u64) : AuthorityGrant {
        AuthorityGrant{
            registry_version : 5,
            registry_digest  : registry_digest(),
            resource         : arg0,
            parent_resource  : arg1,
            action_mask      : arg2,
        }
    }

    public fun registry_digest() : vector<u8> {
        b"0fcce41d82171e0a188b23509a62bd4808c4f1f0e925c102f3be5eb211ce9fb8"
    }

    public fun registry_version() : u64 {
        5
    }

    public fun resource_board() : u64 {
        1
    }

    public fun resource_project() : u64 {
        2
    }

    public fun resource_task() : u64 {
        3
    }

    public fun resource_thread() : u64 {
        4
    }

    // decompiled from Move bytecode v7
}

