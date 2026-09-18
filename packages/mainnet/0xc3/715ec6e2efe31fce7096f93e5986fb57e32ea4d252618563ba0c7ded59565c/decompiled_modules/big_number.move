module 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::big_number {
    public fun coefficient_max() : u64 {
        34359738367
    }

    public fun coefficient_min() : u64 {
        17179869184
    }

    public fun create_big_number(arg0: u64, arg1: u64) : u64 {
        arg0 << 15 | arg1
    }

    public fun decimals_debt_factor() : u64 {
        16384
    }

    public fun div_big_number(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        assert!(arg1 != 0, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::division_by_zero());
        let v0 = arg1 >> 15;
        assert!(v0 != 0, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::division_by_zero());
        let v1 = (((arg0 >> 15) as u128) << 64) / (v0 as u128);
        let v2 = if (v1 >> 64 == 1) {
            ((64 + 1) as u64)
        } else {
            (64 as u64)
        };
        let v3 = v2 - (35 as u64);
        let v4 = (arg0 & 32767) + 16384 + v3;
        let v5 = (arg1 & 32767) + (64 as u64);
        assert!(v4 > v5, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::bn_error());
        let v6 = v4 - v5;
        assert!(v6 <= 32767, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::bn_error());
        ((v1 >> (v3 as u8)) as u64) << 15 | v6
    }

    public fun exponent_max_debt_factor() : u64 {
        32767
    }

    public fun extract_coefficient(arg0: u64) : u64 {
        arg0 >> 15
    }

    public fun extract_exponent(arg0: u64) : u64 {
        arg0 & 32767
    }

    fun leading_zeros(arg0: u128) : u8 {
        128 - most_significant_bit(arg0)
    }

    public fun max_mask_debt_factor() : u64 {
        1125899906842623
    }

    public fun most_significant_bit(arg0: u128) : u8 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = arg0;
        let v1 = 1;
        let v2 = v1;
        if (arg0 >= 18446744073709551616) {
            v0 = arg0 >> 64;
            v2 = v1 + 64;
        };
        if (v0 >= 4294967296) {
            v0 = v0 >> 32;
            v2 = v2 + 32;
        };
        if (v0 >= 65536) {
            v0 = v0 >> 16;
            v2 = v2 + 16;
        };
        if (v0 >= 256) {
            v0 = v0 >> 8;
            v2 = v2 + 8;
        };
        if (v0 >= 16) {
            v0 = v0 >> 4;
            v2 = v2 + 4;
        };
        if (v0 >= 4) {
            v0 = v0 >> 2;
            v2 = v2 + 2;
        };
        if (v0 >= 2) {
            v2 = v2 + 1;
        };
        v2
    }

    public fun mul_big_number(arg0: u64, arg1: u64) : u64 {
        let v0 = ((arg0 >> 15) as u128) * ((arg1 >> 15) as u128);
        let v1 = if (v0 > 590295810358705651711) {
            (35 as u64)
        } else {
            ((35 - 1) as u64)
        };
        let v2 = (arg0 & 32767) + (arg1 & 32767) + v1;
        assert!(v2 >= 16384, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::bn_error());
        let v3 = v2 - 16384;
        if (v3 > 32767) {
            return 1125899906842623
        };
        ((v0 >> (v1 as u8)) as u64) << 15 | v3
    }

    public fun mul_div_big_number(arg0: u64, arg1: u128) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = ((arg0 >> 15) as u128) * arg1;
        let v1 = if (v0 > 316912650057057350374175801343) {
            99
        } else if (v0 > 158456325028528675187087900671) {
            98
        } else {
            most_significant_bit(v0)
        };
        let v2 = if (v1 > 35) {
            v1 - 35
        } else {
            0
        };
        let v3 = (arg0 & 32767) + (v2 as u64);
        assert!(v3 > (64 as u64), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::bn_error());
        let v4 = v3 - (64 as u64);
        assert!(v4 <= 32767, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::bn_error());
        ((v0 >> v2) as u64) << 15 | v4
    }

    public fun mul_div_normal(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0 || arg2 == 0) {
            return 0
        };
        let v0 = arg1 & 32767;
        let v1 = arg2 & 32767;
        assert!(v1 >= v0, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::bn_error());
        let v2 = v1 - v0;
        if (v2 >= 129) {
            return 0
        };
        let v3 = ((arg2 >> 15) as u128);
        if ((v2 as u8) > leading_zeros(v3)) {
            return 0
        };
        let v4 = if (v3 == 0) {
            0
        } else {
            v3 << (v2 as u8)
        };
        assert!(v4 != 0, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::division_by_zero());
        let v5 = (arg0 as u128) * ((arg1 >> 15) as u128) / v4;
        assert!(v5 <= 18446744073709551615, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::bn_error());
        (v5 as u64)
    }

    public fun precision() : u8 {
        64
    }

    public fun two_power_64() : u128 {
        18446744073709551616
    }

    // decompiled from Move bytecode v7
}

