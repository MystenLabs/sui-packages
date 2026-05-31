module 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge {
    struct ForgeRegistry has key {
        id: 0x2::object::UID,
        repo_count: u64,
        names: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct Repository has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        owner: address,
        default_branch: 0x1::string::String,
        current_snapshot: 0x1::string::String,
        ref_version: u64,
        latest_release: 0x1::option::Option<0x2::object::ID>,
        revoked_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
        min_approvals: u8,
    }

    struct RepoOwnerCap has store, key {
        id: 0x2::object::UID,
        repo_id: 0x2::object::ID,
    }

    struct AgentCap has store, key {
        id: 0x2::object::UID,
        repo_id: 0x2::object::ID,
        scopes: u8,
        expires_at_epoch: u64,
        label: 0x1::string::String,
    }

    struct RepoCreated has copy, drop {
        repo_id: 0x2::object::ID,
        name: 0x1::string::String,
        owner: address,
        snapshot: 0x1::string::String,
    }

    struct RefUpdated has copy, drop {
        repo_id: 0x2::object::ID,
        new_snapshot: 0x1::string::String,
        ref_version: u64,
    }

    struct AgentCapGranted has copy, drop {
        repo_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        recipient: address,
        scopes: u8,
        expires_at_epoch: u64,
    }

    struct AgentCapRevoked has copy, drop {
        repo_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    public fun agent_cap_id(arg0: &AgentCap) : 0x2::object::ID {
        0x2::object::id<AgentCap>(arg0)
    }

    public fun agent_cap_repo(arg0: &AgentCap) : 0x2::object::ID {
        arg0.repo_id
    }

    public fun agent_cap_scopes(arg0: &AgentCap) : u8 {
        arg0.scopes
    }

    public fun assert_agent_scope(arg0: &Repository, arg1: &AgentCap, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.repo_id == 0x2::object::id<Repository>(arg0), 2);
        let v0 = 0x2::object::id<AgentCap>(arg1);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked_caps, &v0), 6);
        assert!(arg1.scopes & arg2 == arg2, 3);
        assert!(arg1.expires_at_epoch == 0 || 0x2::tx_context::epoch(arg3) < arg1.expires_at_epoch, 4);
    }

    public fun assert_not_agent_merge(arg0: &AgentCap) {
        abort 1
    }

    public fun assert_owner(arg0: &Repository, arg1: &RepoOwnerCap) {
        assert!(arg1.repo_id == 0x2::object::id<Repository>(arg0), 0);
    }

    public fun create_repo(arg0: &mut ForgeRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.names, arg1), 5);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = Repository{
            id               : 0x2::object::new(arg4),
            name             : arg1,
            owner            : v0,
            default_branch   : arg2,
            current_snapshot : arg3,
            ref_version      : 0,
            latest_release   : 0x1::option::none<0x2::object::ID>(),
            revoked_caps     : 0x2::vec_set::empty<0x2::object::ID>(),
            min_approvals    : 0,
        };
        let v2 = 0x2::object::id<Repository>(&v1);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.names, v1.name, v2);
        arg0.repo_count = arg0.repo_count + 1;
        let v3 = RepoCreated{
            repo_id  : v2,
            name     : v1.name,
            owner    : v0,
            snapshot : v1.current_snapshot,
        };
        0x2::event::emit<RepoCreated>(v3);
        let v4 = RepoOwnerCap{
            id      : 0x2::object::new(arg4),
            repo_id : v2,
        };
        0x2::transfer::transfer<RepoOwnerCap>(v4, v0);
        0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::share_ledger(0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::new_ledger(v2, arg4));
        0x2::transfer::share_object<Repository>(v1);
    }

    public fun current_snapshot(arg0: &Repository) : 0x1::string::String {
        arg0.current_snapshot
    }

    public fun default_branch(arg0: &Repository) : 0x1::string::String {
        arg0.default_branch
    }

    public fun grant_agent_cap(arg0: &Repository, arg1: &RepoOwnerCap, arg2: address, arg3: u8, arg4: u64, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        let v0 = AgentCap{
            id               : 0x2::object::new(arg6),
            repo_id          : 0x2::object::id<Repository>(arg0),
            scopes           : arg3,
            expires_at_epoch : arg4,
            label            : arg5,
        };
        let v1 = AgentCapGranted{
            repo_id          : 0x2::object::id<Repository>(arg0),
            cap_id           : 0x2::object::id<AgentCap>(&v0),
            recipient        : arg2,
            scopes           : arg3,
            expires_at_epoch : arg4,
        };
        0x2::event::emit<AgentCapGranted>(v1);
        0x2::transfer::transfer<AgentCap>(v0, arg2);
    }

    fun id_in_repo(arg0: &Repository, arg1: &vector<u8>) : bool {
        let v0 = 0x2::object::id_bytes<Repository>(arg0);
        let v1 = 0x1::vector::length<u8>(&v0);
        if (0x1::vector::length<u8>(arg1) < v1) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            if (*0x1::vector::borrow<u8>(arg1, v2) != *0x1::vector::borrow<u8>(&v0, v2)) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ForgeRegistry{
            id         : 0x2::object::new(arg0),
            repo_count : 0,
            names      : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<ForgeRegistry>(v0);
    }

    public fun is_cap_revoked(arg0: &Repository, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked_caps, &arg1)
    }

    public fun latest_release(arg0: &Repository) : 0x1::option::Option<0x2::object::ID> {
        arg0.latest_release
    }

    public fun min_approvals(arg0: &Repository) : u8 {
        arg0.min_approvals
    }

    public fun owner_cap_repo(arg0: &RepoOwnerCap) : 0x2::object::ID {
        arg0.repo_id
    }

    public fun ref_version(arg0: &Repository) : u64 {
        arg0.ref_version
    }

    public fun repo_count(arg0: &ForgeRegistry) : u64 {
        arg0.repo_count
    }

    public fun repo_name(arg0: &Repository) : 0x1::string::String {
        arg0.name
    }

    public fun repo_owner(arg0: &Repository) : address {
        arg0.owner
    }

    public fun revoke_agent_cap(arg0: &mut Repository, arg1: &RepoOwnerCap, arg2: 0x2::object::ID) {
        assert_owner(arg0, arg1);
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.revoked_caps, &arg2)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.revoked_caps, arg2);
        };
        let v0 = AgentCapRevoked{
            repo_id : 0x2::object::id<Repository>(arg0),
            cap_id  : arg2,
        };
        0x2::event::emit<AgentCapRevoked>(v0);
    }

    public fun scope_open_pr() : u8 {
        1
    }

    public fun scope_review() : u8 {
        2
    }

    public fun scope_run_ci() : u8 {
        4
    }

    entry fun seal_approve_agent(arg0: vector<u8>, arg1: &Repository, arg2: &AgentCap, arg3: &0x2::tx_context::TxContext) {
        assert_agent_scope(arg1, arg2, 2, arg3);
        assert!(id_in_repo(arg1, &arg0), 7);
    }

    entry fun seal_approve_owner(arg0: vector<u8>, arg1: &Repository, arg2: &RepoOwnerCap) {
        assert_owner(arg1, arg2);
        assert!(id_in_repo(arg1, &arg0), 7);
    }

    public(friend) fun set_latest_release(arg0: &mut Repository, arg1: 0x2::object::ID) {
        arg0.latest_release = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public fun set_min_approvals(arg0: &mut Repository, arg1: &RepoOwnerCap, arg2: u8) {
        assert_owner(arg0, arg1);
        arg0.min_approvals = arg2;
    }

    public fun update_ref(arg0: &mut Repository, arg1: &RepoOwnerCap, arg2: 0x1::string::String) {
        assert_owner(arg0, arg1);
        arg0.current_snapshot = arg2;
        arg0.ref_version = arg0.ref_version + 1;
        let v0 = RefUpdated{
            repo_id      : 0x2::object::id<Repository>(arg0),
            new_snapshot : arg0.current_snapshot,
            ref_version  : arg0.ref_version,
        };
        0x2::event::emit<RefUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

