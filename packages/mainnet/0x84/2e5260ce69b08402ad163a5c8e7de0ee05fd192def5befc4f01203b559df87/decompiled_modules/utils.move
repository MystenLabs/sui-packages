module 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::utils {
    public fun base_div(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::base_uint() as u128) / (arg1 as u128)) as u64)
    }

    public fun base_mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::base_uint() as u128)) as u64)
    }

    public fun convert_to_protocol_decimals(arg0: u64, arg1: u8) : u64 {
        let v0 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::protocol_decimals();
        if (arg1 < v0) {
            return arg0 * 0x1::u64::pow(10, v0 - arg1)
        };
        arg0 / 0x1::u64::pow(10, arg1 - v0)
    }

    public fun convert_to_provided_decimals(arg0: u64, arg1: u8) : u64 {
        let v0 = 0x842e5260ce69b08402ad163a5c8e7de0ee05fd192def5befc4f01203b559df87::constants::protocol_decimals();
        if (arg1 < v0) {
            return arg0 / 0x1::u64::pow(10, v0 - arg1)
        };
        arg0 * 0x1::u64::pow(10, arg1 - v0)
    }

    public fun is_empty_string(arg0: 0x1::string::String) : bool {
        arg0 == 0x1::string::utf8(b"")
    }

    // decompiled from Move bytecode v6
}

