module 0xfc7121c63e4c670a3dd7dcfbe166bb85f3c37427b40e0783d2bd1dca9174f75::auth {
    struct AUTH has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: AUTH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun witness() : Witness {
        Witness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

