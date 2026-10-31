module 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::math {
    public fun current_balance(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 / 1000000000000000000000000000
    }

    public fun from_base_units(arg0: u256, arg1: u8) : u256 {
        if (arg1 >= 9) {
            arg0 / pow10(arg1 - 9)
        } else {
            arg0 * pow10(9 - arg1)
        }
    }

    public fun max_repay_normalized(arg0: u256, arg1: u256, arg2: u8, arg3: u256, arg4: u256, arg5: u8, arg6: u256) : u256 {
        assert!(arg1 > 0 && arg4 > 0, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::price_unavailable());
        let v0 = arg0 * arg1 * pow10(arg5) * arg6 / arg4 * pow10(arg2) * 1000000000000000000000000000;
        if (v0 > arg3) {
            arg3
        } else {
            v0
        }
    }

    public fun navi_decimals() : u8 {
        9
    }

    public fun pow10(arg0: u8) : u256 {
        assert!(arg0 <= 38, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::bad_argument());
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun ray() : u256 {
        1000000000000000000000000000
    }

    public fun sell_remainder_is_better(arg0: u64, arg1: u64, arg2: u64) : bool {
        if (arg0 == 0) {
            return false
        };
        if (arg1 >= arg0) {
            return true
        };
        ((arg0 - arg1) as u256) * 10000 / (arg0 as u256) <= (arg2 as u256)
    }

    public fun shave_bps(arg0: u256, arg1: u64) : u256 {
        assert!(arg1 < 10000, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::bad_argument());
        arg0 * ((10000 - arg1) as u256) / 10000
    }

    public fun to_base_units(arg0: u256, arg1: u8) : u256 {
        if (arg1 >= 9) {
            arg0 * pow10(arg1 - 9)
        } else {
            arg0 / pow10(9 - arg1)
        }
    }

    // decompiled from Move bytecode v7
}

