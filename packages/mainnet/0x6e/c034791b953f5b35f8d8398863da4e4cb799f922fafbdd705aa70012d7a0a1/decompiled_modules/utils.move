module 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils {
    public fun base_div(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::base_uint() as u128) / (arg1 as u128)) as u64)
    }

    public fun base_mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::base_uint() as u128)) as u64)
    }

    public fun convert_to_protocol_decimals(arg0: u64, arg1: u8) : u64 {
        let v0 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::protocol_decimals();
        if (arg1 < v0) {
            return arg0 * 0x1::u64::pow(10, v0 - arg1)
        };
        arg0 / 0x1::u64::pow(10, arg1 - v0)
    }

    public fun convert_to_provided_decimals(arg0: u64, arg1: u8) : u64 {
        let v0 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::protocol_decimals();
        if (arg1 < v0) {
            return arg0 / 0x1::u64::pow(10, v0 - arg1)
        };
        arg0 * 0x1::u64::pow(10, arg1 - v0)
    }

    public fun is_empty_string(arg0: 0x1::string::String) : bool {
        arg0 == 0x1::string::utf8(b"")
    }

    public fun is_reducing_trade(arg0: bool, arg1: u64, arg2: bool, arg3: u64) : bool {
        arg0 != arg2 && arg3 <= arg1
    }

    public fun mul_div_uint(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun round(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg0 % arg1 * 2 > arg1) {
            arg0 / arg1 + 1
        } else {
            arg0 / arg1
        };
        v0 * arg1
    }

    public fun round_down_to_tick_size(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return arg0
        };
        arg0 - arg0 % arg1
    }

    public fun round_to_tick_size_based_on_direction(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            round_up_to_tick_size(arg0, arg1)
        } else {
            round_down_to_tick_size(arg0, arg1)
        }
    }

    public fun round_up_to_tick_size(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return arg0
        };
        let v0 = arg0 % arg1;
        if (v0 == 0) {
            arg0
        } else {
            arg0 + arg1 - v0
        }
    }

    // decompiled from Move bytecode v6
}

