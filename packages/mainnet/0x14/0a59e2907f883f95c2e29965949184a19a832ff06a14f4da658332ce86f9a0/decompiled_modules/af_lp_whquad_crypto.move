module 0x140a59e2907f883f95c2e29965949184a19a832ff06a14f4da658332ce86f9a0::af_lp_whquad_crypto {
    struct AF_LP_WHQUAD_CRYPTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP_WHQUAD_CRYPTO, arg1: &mut 0x2::tx_context::TxContext) {
        0xe69413529ab3644326061487489edc54e51ae060878c7f3a5d5526cdb7784fa1::amm_interface::create_lp_coin<AF_LP_WHQUAD_CRYPTO>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

