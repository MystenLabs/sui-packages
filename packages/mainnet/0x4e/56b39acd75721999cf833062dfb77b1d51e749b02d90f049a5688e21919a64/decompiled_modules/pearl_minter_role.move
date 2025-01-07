module 0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role {
    struct PEARL_MINTER_ROLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEARL_MINTER_ROLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::AdminCap<PEARL_MINTER_ROLE>>(0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::create_role<PEARL_MINTER_ROLE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

