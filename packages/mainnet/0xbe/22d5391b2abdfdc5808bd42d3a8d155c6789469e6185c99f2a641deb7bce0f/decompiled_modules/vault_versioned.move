module 0xbe22d5391b2abdfdc5808bd42d3a8d155c6789469e6185c99f2a641deb7bce0f::vault_versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct InitEvent has copy, drop {
        versioned: 0x2::object::ID,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version <= 1, 13906834474991157250);
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

    public fun upgrade(arg0: &mut Versioned, arg1: &0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 13906834539415797764);
        arg0.version = 1;
    }

    public fun version(arg0: &Versioned) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

