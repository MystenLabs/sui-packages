module 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::math {
    public fun count_leading_zeros(arg0: u128) : u8 {
        if (arg0 == 0) {
            128
        } else {
            let v1 = 0;
            let v2 = v1;
            if (arg0 & 340282366920938463444927863358058659840 == 0) {
                arg0 = arg0 << 64;
                v2 = v1 + 64;
            };
            if (arg0 & 340282366841710300949110269838224261120 == 0) {
                arg0 = arg0 << 32;
                v2 = v2 + 32;
            };
            if (arg0 & 340277174624079928635746076935438991360 == 0) {
                arg0 = arg0 << 16;
                v2 = v2 + 16;
            };
            if (arg0 & 338953138925153547590470800371487866880 == 0) {
                arg0 = arg0 << 8;
                v2 = v2 + 8;
            };
            if (arg0 & 319014718988379809496913694467282698240 == 0) {
                arg0 = arg0 << 4;
                v2 = v2 + 4;
            };
            if (arg0 & 255211775190703847597530955573826158592 == 0) {
                arg0 = arg0 << 2;
                v2 = v2 + 2;
            };
            if (arg0 & 170141183460469231731687303715884105728 == 0) {
                v2 = v2 + 1;
            };
            v2
        }
    }

    public fun div_round(arg0: u64, arg1: u64) : (bool, u64) {
        let (v0, v1) = unsafe_div_round(arg0, arg1);
        assert!(v1 > 0, 1);
        (v0, v1)
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        let (_, v1) = unsafe_mul_round(arg0, arg1);
        assert!(v1 > 0, 1);
        v1
    }

    public fun mul_round(arg0: u64, arg1: u64) : (bool, u64) {
        let (v0, v1) = unsafe_mul_round(arg0, arg1);
        assert!(v1 > 0, 1);
        (v0, v1)
    }

    public fun scale_fp(arg0: u64, arg1: u64) : u64 {
        let (_, v1) = unsafe_mul_round(arg0 * 1000000000, arg1);
        v1 / 1000000000
    }

    public(friend) fun unsafe_div(arg0: u64, arg1: u64) : u64 {
        let (_, v1) = unsafe_div_round(arg0, arg1);
        v1
    }

    public(friend) fun unsafe_div_round(arg0: u64, arg1: u64) : (bool, u64) {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        let v2 = true;
        if (v0 * (1000000000 as u128) % v1 == 0) {
            v2 = false;
        };
        (v2, ((v0 * (1000000000 as u128) / v1) as u64))
    }

    public fun unsafe_mul(arg0: u64, arg1: u64) : u64 {
        let (_, v1) = unsafe_mul_round(arg0, arg1);
        v1
    }

    public fun unsafe_mul_round(arg0: u64, arg1: u64) : (bool, u64) {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        let v2 = true;
        if (v0 * v1 % 1000000000 == 0) {
            v2 = false;
        };
        (v2, ((v0 * v1 / 1000000000) as u64))
    }

    // decompiled from Move bytecode v6
}

