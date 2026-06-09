module 0x56df399524433211da28dac6e57dd42bc98ed75d327f3f4dde016e0192d8e6e0::predictions {
    struct Registry has key {
        id: 0x2::object::UID,
        agent: address,
        total: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PredictionCommitted has copy, drop {
        seq: u64,
        match_id: u64,
        home: 0x1::string::String,
        away: 0x1::string::String,
        predicted_winner: 0x1::string::String,
        scoreline: 0x1::string::String,
        confidence: u8,
        kickoff_ms: u64,
        committed_at_ms: u64,
        agent: address,
    }

    public fun agent(arg0: &Registry) : address {
        arg0.agent
    }

    public fun commit(arg0: &mut Registry, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == arg0.agent, 0);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg7 > v0, 1);
        arg0.total = arg0.total + 1;
        let v1 = PredictionCommitted{
            seq              : arg0.total,
            match_id         : arg1,
            home             : arg2,
            away             : arg3,
            predicted_winner : arg4,
            scoreline        : arg5,
            confidence       : arg6,
            kickoff_ms       : arg7,
            committed_at_ms  : v0,
            agent            : arg0.agent,
        };
        0x2::event::emit<PredictionCommitted>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id    : 0x2::object::new(arg0),
            agent : 0x2::tx_context::sender(arg0),
            total : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun set_agent(arg0: &AdminCap, arg1: &mut Registry, arg2: address) {
        arg1.agent = arg2;
    }

    public fun total(arg0: &Registry) : u64 {
        arg0.total
    }

    // decompiled from Move bytecode v7
}

