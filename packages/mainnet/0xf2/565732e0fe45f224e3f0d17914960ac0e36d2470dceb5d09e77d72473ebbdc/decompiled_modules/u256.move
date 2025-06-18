module 0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::u256 {
    public fun sqrt(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let (v0, _) = 0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::bit_math::most_significant_bit(arg0);
        let v2 = 1 << v0 >> 1;
        let v3 = v2 + arg0 / v2 >> 1;
        let v4 = v3 + arg0 / v3 >> 1;
        let v5 = v4 + arg0 / v4 >> 1;
        let v6 = v5 + arg0 / v5 >> 1;
        let v7 = v6 + arg0 / v6 >> 1;
        let v8 = v7 + arg0 / v7 >> 1;
        let v9 = v8 + arg0 / v8 >> 1;
        let v10 = arg0 / v9;
        if (v9 < v10) {
            v9
        } else {
            v10
        }
    }

    // decompiled from Move bytecode v6
}

