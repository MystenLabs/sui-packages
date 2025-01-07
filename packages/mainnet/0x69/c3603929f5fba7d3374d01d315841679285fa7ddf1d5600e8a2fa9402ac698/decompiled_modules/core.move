module 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<CORE>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

