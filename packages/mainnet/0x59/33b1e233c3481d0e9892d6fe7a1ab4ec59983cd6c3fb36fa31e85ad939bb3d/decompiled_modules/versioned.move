module 0x5933b1e233c3481d0e9892d6fe7a1ab4ec59983cd6c3fb36fa31e85ad939bb3d::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct InitEvent has copy, drop {
        versioned: 0x2::object::ID,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version <= 1, 13906834324667301890);
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

    public fun upgrade(arg0: &mut Versioned, arg1: &0x5933b1e233c3481d0e9892d6fe7a1ab4ec59983cd6c3fb36fa31e85ad939bb3d::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 13906834341847302148);
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

