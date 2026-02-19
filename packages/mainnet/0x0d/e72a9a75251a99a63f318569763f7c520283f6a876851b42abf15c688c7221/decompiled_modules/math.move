module 0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::math {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 2000);
        arg0 * arg1 / arg2
    }

    // decompiled from Move bytecode v6
}

