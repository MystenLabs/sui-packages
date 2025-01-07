module 0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::liquidity_layer {
    struct LIQUIDITY_LAYER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQUIDITY_LAYER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LIQUIDITY_LAYER>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

