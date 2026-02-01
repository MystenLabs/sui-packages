module 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::agent {
    struct AgentCreated has copy, drop {
        agent_id: 0x2::object::ID,
        owner: address,
        metadata_uri: 0x1::string::String,
        created_at: u64,
    }

    struct AgentUpdated has copy, drop {
        agent_id: 0x2::object::ID,
        metadata_uri: 0x1::string::String,
        updated_at: u64,
    }

    struct AgentTransferred has copy, drop {
        agent_id: 0x2::object::ID,
        from: address,
        to: address,
        transferred_at: u64,
    }

    struct Agent has store, key {
        id: 0x2::object::UID,
        owner: address,
        metadata_uri: 0x1::string::String,
        created_at: u64,
    }

    public fun id(arg0: &Agent) : 0x2::object::ID {
        0x2::object::id<Agent>(arg0)
    }

    public fun create(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Agent {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg1);
        let v2 = Agent{
            id           : 0x2::object::new(arg1),
            owner        : v0,
            metadata_uri : arg0,
            created_at   : v1,
        };
        let v3 = AgentCreated{
            agent_id     : 0x2::object::id<Agent>(&v2),
            owner        : v0,
            metadata_uri : v2.metadata_uri,
            created_at   : v1,
        };
        0x2::event::emit<AgentCreated>(v3);
        v2
    }

    public fun create_and_transfer(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create(arg0, arg1);
        0x2::transfer::transfer<Agent>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun create_for(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v1 = Agent{
            id           : 0x2::object::new(arg2),
            owner        : arg1,
            metadata_uri : arg0,
            created_at   : v0,
        };
        let v2 = AgentCreated{
            agent_id     : 0x2::object::id<Agent>(&v1),
            owner        : arg1,
            metadata_uri : v1.metadata_uri,
            created_at   : v0,
        };
        0x2::event::emit<AgentCreated>(v2);
        0x2::transfer::transfer<Agent>(v1, arg1);
    }

    public fun created_at(arg0: &Agent) : u64 {
        arg0.created_at
    }

    public fun destroy(arg0: Agent, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        let Agent {
            id           : v0,
            owner        : _,
            metadata_uri : _,
            created_at   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun metadata_uri(arg0: &Agent) : 0x1::string::String {
        arg0.metadata_uri
    }

    public fun owner(arg0: &Agent) : address {
        arg0.owner
    }

    public fun transfer_ownership(arg0: &mut Agent, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.owner;
        assert!(v0 == 0x2::tx_context::sender(arg2), 0);
        arg0.owner = arg1;
        let v1 = AgentTransferred{
            agent_id       : 0x2::object::id<Agent>(arg0),
            from           : v0,
            to             : arg1,
            transferred_at : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<AgentTransferred>(v1);
    }

    public fun update_metadata(arg0: &mut Agent, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.metadata_uri = arg1;
        let v0 = AgentUpdated{
            agent_id     : 0x2::object::id<Agent>(arg0),
            metadata_uri : arg1,
            updated_at   : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<AgentUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

