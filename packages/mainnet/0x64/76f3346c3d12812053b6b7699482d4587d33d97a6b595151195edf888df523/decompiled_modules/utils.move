module 0x6476f3346c3d12812053b6b7699482d4587d33d97a6b595151195edf888df523::utils {
    public fun base_div(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (0x6476f3346c3d12812053b6b7699482d4587d33d97a6b595151195edf888df523::constants::base_uint() as u128) / (arg1 as u128)) as u64)
    }

    public fun base_mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (0x6476f3346c3d12812053b6b7699482d4587d33d97a6b595151195edf888df523::constants::base_uint() as u128)) as u64)
    }

    public fun convert_to_protocol_decimals(arg0: u64, arg1: u8) : u64 {
        let v0 = 0x6476f3346c3d12812053b6b7699482d4587d33d97a6b595151195edf888df523::constants::protocol_decimals();
        if (arg1 < v0) {
            return arg0 * 0x1::u64::pow(10, v0 - arg1)
        };
        arg0 / 0x1::u64::pow(10, arg1 - v0)
    }

    public fun convert_to_provided_decimals(arg0: u64, arg1: u8) : u64 {
        let v0 = 0x6476f3346c3d12812053b6b7699482d4587d33d97a6b595151195edf888df523::constants::protocol_decimals();
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

    // decompiled from Move bytecode v6
}

