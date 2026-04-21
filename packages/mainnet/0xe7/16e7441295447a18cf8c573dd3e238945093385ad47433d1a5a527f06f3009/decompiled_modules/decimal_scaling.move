module 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::decimal_scaling {
    public fun safe_downcast_balance(arg0: u256, arg1: u8, arg2: u8) : u64 {
        validate_decimals(arg1, arg2);
        let v0 = if (arg2 > arg1) {
            let v1 = 0x1::u256::pow(10, arg2 - arg1);
            assert!(arg0 <= 18446744073709551615 / v1, 13835058463304056833);
            arg0 * v1
        } else {
            let v2 = scale_amount(arg0, arg1, arg2);
            assert!(v2 <= 18446744073709551615, 13835058497663795201);
            v2
        };
        (v0 as u64)
    }

    public fun safe_upcast_balance(arg0: u64, arg1: u8, arg2: u8) : u256 {
        validate_decimals(arg1, arg2);
        scale_amount((arg0 as u256), arg1, arg2)
    }

    fun scale_amount(arg0: u256, arg1: u8, arg2: u8) : u256 {
        if (arg1 == arg2) {
            arg0
        } else if (arg2 > arg1) {
            arg0 * 0x1::u256::pow(10, arg2 - arg1)
        } else {
            arg0 / 0x1::u256::pow(10, arg1 - arg2)
        }
    }

    fun validate_decimals(arg0: u8, arg1: u8) {
        assert!(arg0 <= 24, 13835340445087039491);
        assert!(arg1 <= 24, 13835340449382006787);
    }

    // decompiled from Move bytecode v7
}

