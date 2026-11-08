module 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::protocol_gate {
    struct ProtocolGate has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
    }

    struct ProtocolGateCap has store, key {
        id: 0x2::object::UID,
        gate_id: 0x2::object::ID,
    }

    struct ProtocolGateCreated has copy, drop {
        gate_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        version: u64,
    }

    struct ProtocolGatePausedUpdated has copy, drop {
        gate_id: 0x2::object::ID,
        paused: bool,
    }

    struct ProtocolGateMigrated has copy, drop {
        gate_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
    }

    public fun assert_live(arg0: &ProtocolGate) {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.paused, 1);
    }

    public fun cap_gate_id(arg0: &ProtocolGateCap) : 0x2::object::ID {
        arg0.gate_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolGate{
            id      : 0x2::object::new(arg0),
            version : 1,
            paused  : false,
        };
        let v1 = ProtocolGateCap{
            id      : 0x2::object::new(arg0),
            gate_id : 0x2::object::id<ProtocolGate>(&v0),
        };
        let v2 = ProtocolGateCreated{
            gate_id : 0x2::object::id<ProtocolGate>(&v0),
            cap_id  : 0x2::object::id<ProtocolGateCap>(&v1),
            version : 1,
        };
        0x2::event::emit<ProtocolGateCreated>(v2);
        0x2::transfer::share_object<ProtocolGate>(v0);
        0x2::transfer::transfer<ProtocolGateCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused(arg0: &ProtocolGate) : bool {
        arg0.paused
    }

    public fun migrate(arg0: &mut ProtocolGate, arg1: &ProtocolGateCap) {
        assert!(arg1.gate_id == 0x2::object::id<ProtocolGate>(arg0), 2);
        assert!(arg0.version < 1, 3);
        arg0.version = 1;
        let v0 = ProtocolGateMigrated{
            gate_id     : 0x2::object::id<ProtocolGate>(arg0),
            old_version : arg0.version,
            new_version : 1,
        };
        0x2::event::emit<ProtocolGateMigrated>(v0);
    }

    public fun protocol_version() : u64 {
        1
    }

    public fun set_paused(arg0: &mut ProtocolGate, arg1: &ProtocolGateCap, arg2: bool) {
        assert!(arg1.gate_id == 0x2::object::id<ProtocolGate>(arg0), 2);
        arg0.paused = arg2;
        let v0 = ProtocolGatePausedUpdated{
            gate_id : 0x2::object::id<ProtocolGate>(arg0),
            paused  : arg2,
        };
        0x2::event::emit<ProtocolGatePausedUpdated>(v0);
    }

    public fun version(arg0: &ProtocolGate) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

