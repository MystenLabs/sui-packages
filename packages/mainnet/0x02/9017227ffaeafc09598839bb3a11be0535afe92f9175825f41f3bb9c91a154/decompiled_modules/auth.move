module 0x29017227ffaeafc09598839bb3a11be0535afe92f9175825f41f3bb9c91a154::auth {
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

