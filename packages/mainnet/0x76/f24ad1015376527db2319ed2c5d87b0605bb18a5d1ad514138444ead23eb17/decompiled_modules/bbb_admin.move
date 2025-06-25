module 0x76f24ad1015376527db2319ed2c5d87b0605bb18a5d1ad514138444ead23eb17::bbb_admin {
    struct BBBAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BBB_ADMIN has drop {
        dummy_field: bool,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : BBBAdminCap {
        BBBAdminCap{id: 0x2::object::new(arg0)}
    }

    public fun id(arg0: &BBBAdminCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: BBB_ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg1);
        0x2::transfer::transfer<BBBAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

