module 0x381bc6b9fd89d748226db81e98e6c22c6246c37d4a13acefc862e4a70c73a788::liquidity_layer {
    struct LIQUIDITY_LAYER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQUIDITY_LAYER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LIQUIDITY_LAYER>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

