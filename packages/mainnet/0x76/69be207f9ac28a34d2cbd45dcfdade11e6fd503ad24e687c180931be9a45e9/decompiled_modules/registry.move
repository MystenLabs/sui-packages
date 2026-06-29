module 0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        agents: 0x2::table::Table<address, AgentRecord>,
        next_id: u64,
    }

    struct AgentRecord has store {
        agent: address,
        numeric_id: u64,
        owner: 0x1::option::Option<address>,
        pending_owner: 0x1::option::Option<address>,
        mcp_endpoint: 0x1::option::Option<0x1::string::String>,
        payment_methods: vector<0x1::string::String>,
        did: 0x1::option::Option<0x1::string::String>,
        metadata_uri: 0x1::option::Option<0x1::string::String>,
        active: bool,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct AgentRegistered has copy, drop {
        agent: address,
        numeric_id: u64,
        timestamp_ms: u64,
    }

    struct AgentUpdated has copy, drop {
        agent: address,
        timestamp_ms: u64,
    }

    struct PendingOwnerSet has copy, drop {
        agent: address,
        pending_owner: address,
        timestamp_ms: u64,
    }

    struct OwnerLinked has copy, drop {
        agent: address,
        owner: address,
        timestamp_ms: u64,
    }

    struct AgentActiveSet has copy, drop {
        agent: address,
        active: bool,
        timestamp_ms: u64,
    }

    fun assert_version(arg0: &Registry) {
        assert!(arg0.version == 1, 4);
    }

    public fun borrow_record(arg0: &Registry, arg1: address) : &AgentRecord {
        0x2::table::borrow<address, AgentRecord>(&arg0.agents, arg1)
    }

    public fun confirm_ownership(arg0: &mut Registry, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::table::contains<address, AgentRecord>(&arg0.agents, arg1), 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::table::borrow_mut<address, AgentRecord>(&mut arg0.agents, arg1);
        assert!(0x1::option::is_some<address>(&v1.pending_owner), 3);
        let v2 = *0x1::option::borrow<address>(&v1.pending_owner);
        assert!(v2 == 0x2::tx_context::sender(arg3), 2);
        v1.owner = 0x1::option::some<address>(v2);
        v1.pending_owner = 0x1::option::none<address>();
        v1.updated_at_ms = v0;
        let v3 = OwnerLinked{
            agent        : arg1,
            owner        : v2,
            timestamp_ms : v0,
        };
        0x2::event::emit<OwnerLinked>(v3);
    }

    public fun did(arg0: &AgentRecord) : 0x1::option::Option<0x1::string::String> {
        arg0.did
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id      : 0x2::object::new(arg0),
            version : 1,
            agents  : 0x2::table::new<address, AgentRecord>(arg0),
            next_id : 1,
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_active(arg0: &AgentRecord) : bool {
        arg0.active
    }

    public fun is_registered(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, AgentRecord>(&arg0.agents, arg1)
    }

    public fun mcp_endpoint(arg0: &AgentRecord) : 0x1::option::Option<0x1::string::String> {
        arg0.mcp_endpoint
    }

    public fun migrate(arg0: &mut Registry, arg1: &AdminCap) {
        assert!(arg0.version < 1, 4);
        arg0.version = 1;
    }

    public fun numeric_id(arg0: &AgentRecord) : u64 {
        arg0.numeric_id
    }

    public fun owner(arg0: &AgentRecord) : 0x1::option::Option<address> {
        arg0.owner
    }

    public fun register(arg0: &mut Registry, arg1: 0x1::option::Option<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!0x2::table::contains<address, AgentRecord>(&arg0.agents, v0), 0);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = arg0.next_id;
        arg0.next_id = v2 + 1;
        let v3 = AgentRecord{
            agent           : v0,
            numeric_id      : v2,
            owner           : 0x1::option::none<address>(),
            pending_owner   : 0x1::option::none<address>(),
            mcp_endpoint    : arg1,
            payment_methods : arg2,
            did             : arg3,
            metadata_uri    : arg4,
            active          : true,
            created_at_ms   : v1,
            updated_at_ms   : v1,
        };
        0x2::table::add<address, AgentRecord>(&mut arg0.agents, v0, v3);
        let v4 = AgentRegistered{
            agent        : v0,
            numeric_id   : v2,
            timestamp_ms : v1,
        };
        0x2::event::emit<AgentRegistered>(v4);
    }

    public fun set_active(arg0: &mut Registry, arg1: address, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::table::contains<address, AgentRecord>(&arg0.agents, arg1), 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::table::borrow_mut<address, AgentRecord>(&mut arg0.agents, arg1);
        assert!(v0 == arg1 || 0x1::option::contains<address>(&v2.owner, &v0), 2);
        v2.active = arg2;
        v2.updated_at_ms = v1;
        let v3 = AgentActiveSet{
            agent        : arg1,
            active       : arg2,
            timestamp_ms : v1,
        };
        0x2::event::emit<AgentActiveSet>(v3);
    }

    public fun set_pending_owner(arg0: &mut Registry, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, AgentRecord>(&arg0.agents, v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::table::borrow_mut<address, AgentRecord>(&mut arg0.agents, v0);
        v2.pending_owner = 0x1::option::some<address>(arg1);
        v2.updated_at_ms = v1;
        let v3 = PendingOwnerSet{
            agent         : v0,
            pending_owner : arg1,
            timestamp_ms  : v1,
        };
        0x2::event::emit<PendingOwnerSet>(v3);
    }

    public fun update(arg0: &mut Registry, arg1: 0x1::option::Option<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<address, AgentRecord>(&arg0.agents, v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x2::table::borrow_mut<address, AgentRecord>(&mut arg0.agents, v0);
        v2.mcp_endpoint = arg1;
        v2.payment_methods = arg2;
        v2.did = arg3;
        v2.metadata_uri = arg4;
        v2.updated_at_ms = v1;
        let v3 = AgentUpdated{
            agent        : v0,
            timestamp_ms : v1,
        };
        0x2::event::emit<AgentUpdated>(v3);
    }

    // decompiled from Move bytecode v6
}

