module 0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct InitEvent has copy, drop {
        versioned: 0x2::object::ID,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version <= 1, 13906834659674750978);
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

    public fun upgrade(arg0: &mut Versioned, arg1: &0xd7a64d5acff2dc5b5f1a24469169165e7fa1c359d02e8d9a2919205dcb5a4297::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 13906834724099391492);
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

