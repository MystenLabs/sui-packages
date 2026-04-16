module 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct InitEvent has copy, drop {
        versioned: 0x2::object::ID,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version <= 1, 13906834672559587329);
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

    public(friend) fun set_version(arg0: &mut Versioned, arg1: u64) {
        arg0.version = arg1;
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 13906834736984227843);
        arg0.version = 1;
    }

    public fun version(arg0: &Versioned) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

