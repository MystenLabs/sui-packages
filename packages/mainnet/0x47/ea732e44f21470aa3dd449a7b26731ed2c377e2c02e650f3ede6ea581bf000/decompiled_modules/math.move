module 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math {
    public fun align_tick_bits(arg0: u32, arg1: u32) : u32 {
        assert!(arg1 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_denominator());
        let v0 = arg0 >> 31 == 1;
        let v1 = if (v0) {
            (arg0 ^ 4294967295) + 1
        } else {
            arg0
        };
        if (v0) {
            (v1 / arg1 * arg1 ^ 4294967295) + 1
        } else {
            v1 / arg1 * arg1
        }
    }

    public fun get_amount_in(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_in());
        assert!(arg1 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_denominator());
        assert!(arg2 > arg0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::insufficient_liquidity());
        let v0 = (arg0 as u128);
        let v1 = (arg2 as u128) - v0;
        assert!(v1 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_denominator());
        let v2 = ((arg1 as u128) * v0 + v1 - 1) / v1;
        assert!(v2 <= 18446744073709551615, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::overflow());
        (v2 as u64)
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_in());
        assert!(arg1 > 0 && arg2 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_denominator());
        let v0 = (arg0 as u128);
        let v1 = v0 * (arg2 as u128) / ((arg1 as u128) + v0);
        assert!(v1 <= 18446744073709551615, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::overflow());
        (v1 as u64)
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_denominator());
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::overflow());
        (v0 as u64)
    }

    public fun q64() : u128 {
        (18446744073709551616 as u128)
    }

    public fun sqrt_price_x64(arg0: u64, arg1: u64) : u128 {
        assert!(arg0 > 0 && arg1 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_denominator());
        let v0 = sqrt_u256(((arg1 as u256) << 128) / (arg0 as u256));
        assert!(v0 <= 340282366920938463463374607431768211455, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::overflow());
        (v0 as u128)
    }

    public fun sqrt_u256(arg0: u256) : u256 {
        if (arg0 == 0 || arg0 == 1) {
            return arg0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    // decompiled from Move bytecode v7
}

