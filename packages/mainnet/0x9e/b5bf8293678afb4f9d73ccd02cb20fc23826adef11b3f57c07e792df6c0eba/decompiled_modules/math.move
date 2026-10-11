module 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math {
    public fun assert_decimals(arg0: u8, arg1: u8) {
        assert!(arg0 <= 9 && arg1 <= 9, 2);
    }

    public fun assert_price(arg0: u256) {
        assert!(arg0 > 0 && arg0 < 340282366920938463463374607431768211456, 3);
    }

    public fun bps() : u64 {
        10000
    }

    public fun coins_down(arg0: u64, arg1: u256, arg2: u8, arg3: u8) : u64 {
        to_u64((arg0 as u256) * pow10(arg2) * 1000000000 / arg1 * pow10(arg3))
    }

    public fun covers(arg0: u64, arg1: u64, arg2: u64) : bool {
        (arg0 as u256) * (10000 as u256) >= (arg1 as u256) * (arg2 as u256)
    }

    fun div_up(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    public fun max_decimals() : u8 {
        9
    }

    public fun mul_div_down(arg0: u64, arg1: u64, arg2: u64) : u64 {
        to_u64((arg0 as u256) * (arg1 as u256) / (arg2 as u256))
    }

    public fun pow10(arg0: u8) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun price_move(arg0: u64, arg1: u256, arg2: u256, arg3: u8, arg4: u8) : (bool, u64) {
        if (arg2 >= arg1) {
            (true, value_down(arg0, arg2 - arg1, arg3, arg4))
        } else {
            (false, value_up(arg0, arg1 - arg2, arg3, arg4))
        }
    }

    public fun price_scale() : u256 {
        1000000000
    }

    public fun sat_sub(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public fun share_down(arg0: u64, arg1: u64) : u64 {
        to_u64((arg0 as u256) * (arg1 as u256) / (10000 as u256))
    }

    public fun share_up(arg0: u64, arg1: u64) : u64 {
        to_u64(div_up((arg0 as u256) * (arg1 as u256), (10000 as u256)))
    }

    fun to_u64(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 1);
        (arg0 as u64)
    }

    public fun value_down(arg0: u64, arg1: u256, arg2: u8, arg3: u8) : u64 {
        to_u64((arg0 as u256) * arg1 * pow10(arg3) / pow10(arg2) * 1000000000)
    }

    public fun value_up(arg0: u64, arg1: u256, arg2: u8, arg3: u8) : u64 {
        to_u64(div_up((arg0 as u256) * arg1 * pow10(arg3), pow10(arg2) * 1000000000))
    }

    // decompiled from Move bytecode v7
}

