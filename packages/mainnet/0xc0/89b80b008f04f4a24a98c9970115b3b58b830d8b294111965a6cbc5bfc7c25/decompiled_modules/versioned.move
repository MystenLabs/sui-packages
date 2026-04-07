module 0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct InitEvent has copy, drop {
        versioned: 0x2::object::ID,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version <= 1, 13906834479286124546);
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

    public fun set_protocol_version(arg0: &mut Versioned, arg1: &0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::global_config::AdminCap, arg2: u64) {
        arg0.version = arg2;
    }

    public(friend) fun set_version(arg0: &mut Versioned, arg1: u64) {
        arg0.version = arg1;
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::global_config::AdminCap) {
        assert!(arg0.version < 1, 13906834500761092100);
        arg0.version = 1;
    }

    public fun version(arg0: &Versioned) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

