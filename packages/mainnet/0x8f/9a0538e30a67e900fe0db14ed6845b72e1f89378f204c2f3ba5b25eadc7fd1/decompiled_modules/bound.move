module 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::bound {
    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : u64 {
        assert!(arg0 != 0, 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::errors::no_zero_coin());
        assert!(arg1 != 0, 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::errors::insufficient_liquidity());
        assert!(arg3 && ((arg1 + arg0) as u256) * 1000000000000000000 / 1000000 <= 900000000000000000000000000 || ((arg2 + arg0) as u256) * 1000000000000000000 / 1000000000 <= 30000000000000000000000, 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::errors::insufficient_liquidity());
        let v0 = if (arg3) {
            1000000
        } else {
            1000000000
        };
        let v1 = (arg1 as u256) * 1000000000000000000 / 1000000;
        let v2 = if (arg3) {
            (0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::math256::sqrt_down(v1 + (arg0 as u256) * 1000000000000000000 / v0) - 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::math256::sqrt_down(v1)) * 1000000000 / 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::math256::sqrt_down(1000000000000000000)
        } else {
            let v3 = 30000000000000000000000 - (arg2 as u256) * 1000000000000000000 / 1000000000;
            (0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::math::pow_2(v3) - 0x8f9a0538e30a67e900fe0db14ed6845b72e1f89378f204c2f3ba5b25eadc7fd1::math::pow_2(v3 - (arg0 as u256) * 1000000000000000000 / v0)) * 1000000 / 1000000000000000000 * 1000000000000000000
        };
        (v2 as u64)
    }

    public fun invariant_(arg0: u64, arg1: u64) : u256 {
        let v0 = 30000000000000000000000 - (arg1 as u256) * 1000000000000000000 / 1000000000;
        (((arg0 as u256) * 1000000000000000000 / 1000000) as u256) * 1000000000000000000 - v0 * v0
    }

    // decompiled from Move bytecode v6
}

