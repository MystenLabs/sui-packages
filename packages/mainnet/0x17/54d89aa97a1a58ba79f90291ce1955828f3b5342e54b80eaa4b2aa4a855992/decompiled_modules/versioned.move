module 0x1754d89aa97a1a58ba79f90291ce1955828f3b5342e54b80eaa4b2aa4a855992::versioned {
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

    public fun upgrade(arg0: &mut Versioned, arg1: &0x1754d89aa97a1a58ba79f90291ce1955828f3b5342e54b80eaa4b2aa4a855992::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 13906834341847302148);
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

