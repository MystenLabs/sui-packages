module 0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role {
    struct OSTR_MINTER_ROLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSTR_MINTER_ROLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::AdminCap<OSTR_MINTER_ROLE>>(0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::create_role<OSTR_MINTER_ROLE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

