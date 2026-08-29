module 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math {
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

    // decompiled from Move bytecode v7
}

