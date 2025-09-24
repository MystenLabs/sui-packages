module 0x6fab8419b14cc402e6b8006ec8bd55a4a4cf5e16363b3d62eae7b697d556cf48::versioned {
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

    public fun upgrade(arg0: &mut Versioned, arg1: &0x6fab8419b14cc402e6b8006ec8bd55a4a4cf5e16363b3d62eae7b697d556cf48::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 13906834724099391492);
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

