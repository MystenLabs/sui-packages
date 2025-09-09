module 0x783ffffebe8f067da5455d5e93821012e844ca7a230b9d4b8e368fd1d64b3ef6::helpers {
    public fun calculate_bid_proximity_multiplier(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 1000
        };
        if (arg1 <= arg0) {
            1000 + (arg1 - arg0) * 1000 / arg1
        } else {
            1000 - (arg1 - arg0) * 1000 / arg1
        }
    }

    public fun calculate_listing_proximity_multiplier(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 1000
        };
        if (arg0 <= arg1) {
            1000 + (arg1 - arg0) * 1000 / arg1
        } else {
            let v1 = (arg0 - arg1) * 1000 / arg1;
            let v2 = v1;
            if (v1 > 100) {
                v2 = 100 * 1000 / 1000;
            };
            1000 - v2
        }
    }

    public fun integer_sqrt(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        if (arg0 < 4) {
            return 1
        };
        let v0 = if (arg0 == 18446744073709551615) {
            arg0 / 2
        } else {
            (arg0 + 1) / 2
        };
        let v1 = v0;
        while (v1 < arg0) {
            let v2 = v1 + arg0 / v1;
            v1 = v2 / 2;
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

