module 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::emitter {
    struct EmitterCreated has copy, drop {
        emitter_cap: 0x2::object::ID,
    }

    struct EmitterDestroyed has copy, drop {
        emitter_cap: 0x2::object::ID,
    }

    struct EmitterCap has store, key {
        id: 0x2::object::UID,
        sequence: u64,
    }

    public fun new(arg0: &0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::State, arg1: &mut 0x2::tx_context::TxContext) : EmitterCap {
        0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::assert_latest_only(arg0);
        let v0 = EmitterCap{
            id       : 0x2::object::new(arg1),
            sequence : 0,
        };
        let v1 = EmitterCreated{emitter_cap: 0x2::object::id<EmitterCap>(&v0)};
        0x2::event::emit<EmitterCreated>(v1);
        v0
    }

    public fun destroy(arg0: &0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::State, arg1: EmitterCap) {
        0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::assert_latest_only(arg0);
        let v0 = EmitterDestroyed{emitter_cap: 0x2::object::id<EmitterCap>(&arg1)};
        0x2::event::emit<EmitterDestroyed>(v0);
        let EmitterCap {
            id       : v1,
            sequence : _,
        } = arg1;
        0x2::object::delete(v1);
    }

    public fun sequence(arg0: &EmitterCap) : u64 {
        arg0.sequence
    }

    public(friend) fun use_sequence(arg0: &mut EmitterCap) : u64 {
        let v0 = arg0.sequence;
        arg0.sequence = v0 + 1;
        v0
    }

    // decompiled from Move bytecode v6
}

