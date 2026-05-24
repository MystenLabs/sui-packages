module 0xbd6b57f594ec4d6378644f0a48654f0eb57ab287d825d5ef6c0f210ae3b7fd22::workspace {
    struct Workspace has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        owner: address,
        access: u8,
        delegates: 0x2::vec_set::VecSet<address>,
        memwal_namespace: 0x1::string::String,
        memory_count: u64,
        artifact_count: u64,
        frozen: bool,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct WorkspaceCap has store, key {
        id: 0x2::object::UID,
        workspace: 0x2::object::ID,
    }

    struct WorkspaceCreated has copy, drop {
        workspace: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        access: u8,
        memwal_namespace: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct MemoryAdded has copy, drop {
        workspace: 0x2::object::ID,
        memwal_blob_id: 0x1::string::String,
        memwal_id: 0x1::string::String,
        agent: 0x1::string::String,
        sender: address,
        timestamp_ms: u64,
    }

    struct MemoryTombstoned has copy, drop {
        workspace: 0x2::object::ID,
        memwal_id: 0x1::string::String,
        sender: address,
        timestamp_ms: u64,
    }

    struct ArtifactPublished has copy, drop {
        artifact: 0x2::object::ID,
        workspace: 0x2::object::ID,
        walrus_blob_id: 0x1::string::String,
        kind: 0x1::string::String,
        name: 0x1::string::String,
        sender: address,
        timestamp_ms: u64,
    }

    struct DelegateAdded has copy, drop {
        workspace: 0x2::object::ID,
        delegate: address,
        timestamp_ms: u64,
    }

    struct DelegateRemoved has copy, drop {
        workspace: 0x2::object::ID,
        delegate: address,
        timestamp_ms: u64,
    }

    struct Artifact has key {
        id: 0x2::object::UID,
        workspace: 0x2::object::ID,
        walrus_blob_id: 0x1::string::String,
        seal_id: vector<u8>,
        kind: 0x1::string::String,
        name: 0x1::string::String,
        schema_version: u32,
        parent: 0x1::option::Option<0x2::object::ID>,
        created_by_agent: 0x1::string::String,
        created_by: address,
        timestamp_ms: u64,
    }

    public fun access(arg0: &Workspace) : u8 {
        arg0.access
    }

    public fun access_delegated() : u8 {
        2
    }

    public fun access_owner_only() : u8 {
        1
    }

    public fun access_public() : u8 {
        0
    }

    public entry fun add_delegate(arg0: &mut Workspace, arg1: &WorkspaceCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_cap(arg1, arg0);
        if (0x2::vec_set::contains<address>(&arg0.delegates, &arg2)) {
            return
        };
        0x2::vec_set::insert<address>(&mut arg0.delegates, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.updated_at_ms = v0;
        let v1 = DelegateAdded{
            workspace    : 0x2::object::id<Workspace>(arg0),
            delegate     : arg2,
            timestamp_ms : v0,
        };
        0x2::event::emit<DelegateAdded>(v1);
    }

    public fun artifact_count(arg0: &Workspace) : u64 {
        arg0.artifact_count
    }

    public fun artifact_created_by(arg0: &Artifact) : address {
        arg0.created_by
    }

    public fun artifact_created_by_agent(arg0: &Artifact) : 0x1::string::String {
        arg0.created_by_agent
    }

    public fun artifact_kind(arg0: &Artifact) : 0x1::string::String {
        arg0.kind
    }

    public fun artifact_name(arg0: &Artifact) : 0x1::string::String {
        arg0.name
    }

    public fun artifact_parent(arg0: &Artifact) : 0x1::option::Option<0x2::object::ID> {
        arg0.parent
    }

    public fun artifact_seal_id(arg0: &Artifact) : vector<u8> {
        arg0.seal_id
    }

    public fun artifact_walrus_blob_id(arg0: &Artifact) : 0x1::string::String {
        arg0.walrus_blob_id
    }

    public fun artifact_workspace(arg0: &Artifact) : 0x2::object::ID {
        arg0.workspace
    }

    fun assert_cap(arg0: &WorkspaceCap, arg1: &Workspace) {
        assert!(arg0.workspace == 0x2::object::id<Workspace>(arg1), 1);
    }

    public fun cap_workspace(arg0: &WorkspaceCap) : 0x2::object::ID {
        arg0.workspace
    }

    public entry fun create(arg0: vector<u8>, arg1: vector<u8>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 2, 0);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::object::new(arg4);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = Workspace{
            id               : v1,
            name             : 0x1::string::utf8(arg0),
            owner            : v3,
            access           : arg2,
            delegates        : 0x2::vec_set::empty<address>(),
            memwal_namespace : 0x1::string::utf8(arg1),
            memory_count     : 0,
            artifact_count   : 0,
            frozen           : false,
            created_at_ms    : v0,
            updated_at_ms    : v0,
        };
        let v5 = WorkspaceCap{
            id        : 0x2::object::new(arg4),
            workspace : v2,
        };
        let v6 = WorkspaceCreated{
            workspace        : v2,
            owner            : v3,
            name             : v4.name,
            access           : arg2,
            memwal_namespace : v4.memwal_namespace,
            timestamp_ms     : v0,
        };
        0x2::event::emit<WorkspaceCreated>(v6);
        0x2::transfer::share_object<Workspace>(v4);
        0x2::transfer::transfer<WorkspaceCap>(v5, v3);
    }

    public entry fun freeze_workspace(arg0: &mut Workspace, arg1: &WorkspaceCap) {
        assert_cap(arg1, arg0);
        arg0.frozen = true;
    }

    public fun frozen(arg0: &Workspace) : bool {
        arg0.frozen
    }

    public fun is_delegate(arg0: &Workspace, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.delegates, &arg1)
    }

    public fun memory_count(arg0: &Workspace) : u64 {
        arg0.memory_count
    }

    public fun memwal_namespace(arg0: &Workspace) : 0x1::string::String {
        arg0.memwal_namespace
    }

    public fun name(arg0: &Workspace) : 0x1::string::String {
        arg0.name
    }

    public fun owner(arg0: &Workspace) : address {
        arg0.owner
    }

    public entry fun publish_artifact(arg0: &mut Workspace, arg1: &WorkspaceCap, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x1::option::Option<0x2::object::ID>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_cap(arg1, arg0);
        assert!(!arg0.frozen, 2);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = 0x2::object::new(arg9);
        let v3 = Artifact{
            id               : v2,
            workspace        : 0x2::object::id<Workspace>(arg0),
            walrus_blob_id   : 0x1::string::utf8(arg2),
            seal_id          : arg3,
            kind             : 0x1::string::utf8(arg4),
            name             : 0x1::string::utf8(arg5),
            schema_version   : 1,
            parent           : arg7,
            created_by_agent : 0x1::string::utf8(arg6),
            created_by       : v1,
            timestamp_ms     : v0,
        };
        arg0.artifact_count = arg0.artifact_count + 1;
        arg0.updated_at_ms = v0;
        let v4 = ArtifactPublished{
            artifact       : 0x2::object::uid_to_inner(&v2),
            workspace      : 0x2::object::id<Workspace>(arg0),
            walrus_blob_id : v3.walrus_blob_id,
            kind           : v3.kind,
            name           : v3.name,
            sender         : v1,
            timestamp_ms   : v0,
        };
        0x2::event::emit<ArtifactPublished>(v4);
        0x2::transfer::share_object<Artifact>(v3);
    }

    public entry fun record_memory_added(arg0: &mut Workspace, arg1: &WorkspaceCap, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_cap(arg1, arg0);
        assert!(!arg0.frozen, 2);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        arg0.memory_count = arg0.memory_count + 1;
        arg0.updated_at_ms = v0;
        let v1 = MemoryAdded{
            workspace      : 0x2::object::id<Workspace>(arg0),
            memwal_blob_id : 0x1::string::utf8(arg2),
            memwal_id      : 0x1::string::utf8(arg3),
            agent          : 0x1::string::utf8(arg4),
            sender         : 0x2::tx_context::sender(arg6),
            timestamp_ms   : v0,
        };
        0x2::event::emit<MemoryAdded>(v1);
    }

    public entry fun remove_delegate(arg0: &mut Workspace, arg1: &WorkspaceCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_cap(arg1, arg0);
        if (!0x2::vec_set::contains<address>(&arg0.delegates, &arg2)) {
            return
        };
        0x2::vec_set::remove<address>(&mut arg0.delegates, &arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.updated_at_ms = v0;
        let v1 = DelegateRemoved{
            workspace    : 0x2::object::id<Workspace>(arg0),
            delegate     : arg2,
            timestamp_ms : v0,
        };
        0x2::event::emit<DelegateRemoved>(v1);
    }

    public entry fun tombstone_memory(arg0: &mut Workspace, arg1: &WorkspaceCap, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_cap(arg1, arg0);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.updated_at_ms = v0;
        let v1 = MemoryTombstoned{
            workspace    : 0x2::object::id<Workspace>(arg0),
            memwal_id    : 0x1::string::utf8(arg2),
            sender       : 0x2::tx_context::sender(arg4),
            timestamp_ms : v0,
        };
        0x2::event::emit<MemoryTombstoned>(v1);
    }

    // decompiled from Move bytecode v7
}

