module 0x3af385a04e03432e91e6e7bee4132269887f1a9826a0c96cfbabbf4747ebcbe2::liquidity_layer {
    struct LIQUIDITY_LAYER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQUIDITY_LAYER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LIQUIDITY_LAYER>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

