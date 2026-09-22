module 0x6fd74ee27fc97dcb0f22bf943f8fcc7638535a3d16d95e6d31d00ad2480f1f54::math {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 2000);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 2001);
        (v0 as u128)
    }

    // decompiled from Move bytecode v7
}

