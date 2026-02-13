module 0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::action {
    struct AgentAction has store, key {
        id: 0x2::object::UID,
        agent_id: 0x2::object::ID,
        created_by: address,
        expires_at: u64,
        label: 0x1::string::String,
        created_at: u64,
    }

    struct AgentActionCreated has copy, drop {
        action_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        created_by: address,
        expires_at: u64,
        label: 0x1::string::String,
    }

    struct AgentActionDelegated has copy, drop {
        original_action_id: 0x2::object::ID,
        new_action_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        delegated_by: address,
        expires_at: u64,
        label: 0x1::string::String,
    }

    struct AgentActionDestroyed has copy, drop {
        action_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        destroyed_by: address,
    }

    public fun agent_id(arg0: &AgentAction) : 0x2::object::ID {
        arg0.agent_id
    }

    public fun create_action(arg0: &0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::identity::AgentIdentity, arg1: &0x2::clock::Clock, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : AgentAction {
        let v0 = 0x2::object::id<0x59880bce8832b20b8486ad26f834ea271f3f4a0f41acb47332a3341c24a1fdfc::identity::AgentIdentity>(arg0);
        let v1 = AgentAction{
            id         : 0x2::object::new(arg4),
            agent_id   : v0,
            created_by : 0x2::tx_context::sender(arg4),
            expires_at : arg2,
            label      : arg3,
            created_at : 0x2::clock::timestamp_ms(arg1),
        };
        let v2 = AgentActionCreated{
            action_id  : 0x2::object::id<AgentAction>(&v1),
            agent_id   : v0,
            created_by : 0x2::tx_context::sender(arg4),
            expires_at : arg2,
            label      : v1.label,
        };
        0x2::event::emit<AgentActionCreated>(v2);
        v1
    }

    public fun created_at(arg0: &AgentAction) : u64 {
        arg0.created_at
    }

    public fun created_by(arg0: &AgentAction) : address {
        arg0.created_by
    }

    public fun delegate(arg0: &AgentAction, arg1: &0x2::clock::Clock, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : AgentAction {
        if (arg0.expires_at != 0) {
            assert!(arg2 != 0 && arg2 <= arg0.expires_at, 0);
        };
        let v0 = AgentAction{
            id         : 0x2::object::new(arg4),
            agent_id   : arg0.agent_id,
            created_by : 0x2::tx_context::sender(arg4),
            expires_at : arg2,
            label      : arg3,
            created_at : 0x2::clock::timestamp_ms(arg1),
        };
        let v1 = AgentActionDelegated{
            original_action_id : 0x2::object::id<AgentAction>(arg0),
            new_action_id      : 0x2::object::id<AgentAction>(&v0),
            agent_id           : arg0.agent_id,
            delegated_by       : 0x2::tx_context::sender(arg4),
            expires_at         : arg2,
            label              : v0.label,
        };
        0x2::event::emit<AgentActionDelegated>(v1);
        v0
    }

    public fun destroy(arg0: AgentAction, arg1: &0x2::tx_context::TxContext) {
        let AgentAction {
            id         : v0,
            agent_id   : v1,
            created_by : _,
            expires_at : _,
            label      : _,
            created_at : _,
        } = arg0;
        let v6 = v0;
        let v7 = AgentActionDestroyed{
            action_id    : 0x2::object::uid_to_inner(&v6),
            agent_id     : v1,
            destroyed_by : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<AgentActionDestroyed>(v7);
        0x2::object::delete(v6);
    }

    public fun expires_at(arg0: &AgentAction) : u64 {
        arg0.expires_at
    }

    public fun is_expired(arg0: &AgentAction, arg1: &0x2::clock::Clock) : bool {
        arg0.expires_at != 0 && 0x2::clock::timestamp_ms(arg1) > arg0.expires_at
    }

    public fun label(arg0: &AgentAction) : &0x1::string::String {
        &arg0.label
    }

    // decompiled from Move bytecode v6
}

