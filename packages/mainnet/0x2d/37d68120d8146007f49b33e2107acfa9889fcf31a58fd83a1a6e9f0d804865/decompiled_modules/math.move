module 0x2d37d68120d8146007f49b33e2107acfa9889fcf31a58fd83a1a6e9f0d804865::math {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 2000);
        arg0 * arg1 / arg2
    }

    // decompiled from Move bytecode v6
}

