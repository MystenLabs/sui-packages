module 0x5fd064cde86c675c3f98207be658a3861d7aba861359c8f3822c8308813f2391::agent {
    struct Agent has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        personality: 0x1::string::String,
        owner: address,
        created_ms: u64,
    }

    struct AgentMinted has copy, drop {
        agent_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        created_ms: u64,
    }

    public fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Agent {
        assert!(0x1::string::length(&arg0) > 0, 0);
        assert!(0x1::string::length(&arg0) <= 64, 1);
        assert!(0x1::string::length(&arg1) <= 512, 2);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = Agent{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            personality : arg1,
            owner       : v0,
            created_ms  : v1,
        };
        let v3 = AgentMinted{
            agent_id   : 0x2::object::id<Agent>(&v2),
            owner      : v0,
            name       : v2.name,
            created_ms : v1,
        };
        0x2::event::emit<AgentMinted>(v3);
        v2
    }

    public fun burn(arg0: Agent) {
        let Agent {
            id          : v0,
            name        : _,
            personality : _,
            owner       : _,
            created_ms  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun created_ms(arg0: &Agent) : u64 {
        arg0.created_ms
    }

    entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<Agent>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun name(arg0: &Agent) : &0x1::string::String {
        &arg0.name
    }

    public fun owner(arg0: &Agent) : address {
        arg0.owner
    }

    public fun personality(arg0: &Agent) : &0x1::string::String {
        &arg0.personality
    }

    // decompiled from Move bytecode v7
}

