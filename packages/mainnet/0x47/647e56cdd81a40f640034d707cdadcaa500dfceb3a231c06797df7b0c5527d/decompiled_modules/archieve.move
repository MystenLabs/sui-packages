module 0x22ef99c6b2630e85bdcd600909a531874417123eec41abfbce2086a58467513e::archieve {
    struct ARCHIEVE has drop {
        dummy_field: bool,
    }

    struct NUserArchieve has store, key {
        id: 0x2::object::UID,
    }

    struct NUserReg has store, key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, bool>,
    }

    struct Owner {
        dummy_field: bool,
    }

    fun init(arg0: ARCHIEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NUserReg{
            id    : 0x2::object::new(arg1),
            users : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::public_share_object<NUserReg>(v0);
    }

    public entry fun register(arg0: &mut NUserReg, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, bool>(&arg0.users, v0), 8003);
        let v1 = NUserArchieve{id: 0x2::object::new(arg1)};
        0x2::table::add<address, bool>(&mut arg0.users, v0, true);
        0x2::dynamic_field::add<u64, address>(&mut v1.id, 0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<NUserArchieve>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun verify(arg0: &mut NUserArchieve) {
    }

    public fun verify2(arg0: &mut NUserArchieve, arg1: address) {
        assert!(*0x2::dynamic_field::borrow<u64, address>(&mut arg0.id, 0) == arg1, 100);
    }

    // decompiled from Move bytecode v6
}

