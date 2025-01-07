module 0x7618e1b31e6f4b6a87ed9076d8b8c0a6ae22b074364fa5b9821b59a7456a2837::af_lp_whusd {
    struct AF_LP_WHUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP_WHUSD, arg1: &mut 0x2::tx_context::TxContext) {
        0xe69413529ab3644326061487489edc54e51ae060878c7f3a5d5526cdb7784fa1::amm_interface::create_lp_coin<AF_LP_WHUSD>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

