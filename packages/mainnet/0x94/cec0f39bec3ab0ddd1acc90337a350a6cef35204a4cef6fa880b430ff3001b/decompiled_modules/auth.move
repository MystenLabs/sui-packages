module 0x443dbe9b345621dcedb5eabd6a44f23878e2aa0df9ba296f511ae259c6d8e4a8::auth {
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

