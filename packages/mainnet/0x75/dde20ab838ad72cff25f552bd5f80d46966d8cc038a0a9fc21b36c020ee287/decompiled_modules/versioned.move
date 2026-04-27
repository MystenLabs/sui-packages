module 0x75dde20ab838ad72cff25f552bd5f80d46966d8cc038a0a9fc21b36c020ee287::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct InitEvent has copy, drop {
        versioned: 0x2::object::ID,
    }

    struct ProtocolVersionChanged has copy, drop {
        versioned_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
        timestamp_ms: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version <= 1, 13906834522235797506);
    }

    public fun current_version() : u64 {
        1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        let v1 = InitEvent{versioned: 0x2::object::id<Versioned>(&v0)};
        0x2::event::emit<InitEvent>(v1);
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public fun set_protocol_version(arg0: &mut Versioned, arg1: &0x75dde20ab838ad72cff25f552bd5f80d46966d8cc038a0a9fc21b36c020ee287::global_config::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        arg0.version = arg2;
        let v0 = ProtocolVersionChanged{
            versioned_id : 0x2::object::id<Versioned>(arg0),
            old_version  : arg0.version,
            new_version  : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ProtocolVersionChanged>(v0);
    }

    public(friend) fun set_version(arg0: &mut Versioned, arg1: u64) {
        arg0.version = arg1;
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0x75dde20ab838ad72cff25f552bd5f80d46966d8cc038a0a9fc21b36c020ee287::global_config::AdminCap) {
        assert!(arg0.version < 1, 13906834543710765060);
        arg0.version = 1;
    }

    public fun version(arg0: &Versioned) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

