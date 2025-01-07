module 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::liquidity_layer {
    struct LIQUIDITY_LAYER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQUIDITY_LAYER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LIQUIDITY_LAYER>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

