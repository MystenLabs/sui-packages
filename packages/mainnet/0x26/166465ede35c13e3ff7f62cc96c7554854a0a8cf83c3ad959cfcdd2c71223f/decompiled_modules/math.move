module 0x26166465ede35c13e3ff7f62cc96c7554854a0a8cf83c3ad959cfcdd2c71223f::math {
    public(friend) fun div(arg0: u64, arg1: u64) : u64 {
        mul_div(arg0, 0x26166465ede35c13e3ff7f62cc96c7554854a0a8cf83c3ad959cfcdd2c71223f::constants::float_scaling(), arg1)
    }

    public(friend) fun mul(arg0: u64, arg1: u64) : u64 {
        mul_div(arg0, arg1, 0x26166465ede35c13e3ff7f62cc96c7554854a0a8cf83c3ad959cfcdd2c71223f::constants::float_scaling())
    }

    public(friend) fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public(friend) fun power_of_ten(arg0: u8) : u64 {
        0x1::u64::pow(10, arg0)
    }

    public(friend) fun scale_down(arg0: 0x26166465ede35c13e3ff7f62cc96c7554854a0a8cf83c3ad959cfcdd2c71223f::i256::I256, arg1: u64) : 0x26166465ede35c13e3ff7f62cc96c7554854a0a8cf83c3ad959cfcdd2c71223f::i256::I256 {
        0x26166465ede35c13e3ff7f62cc96c7554854a0a8cf83c3ad959cfcdd2c71223f::i256::div(0x26166465ede35c13e3ff7f62cc96c7554854a0a8cf83c3ad959cfcdd2c71223f::i256::mul(arg0, 0x26166465ede35c13e3ff7f62cc96c7554854a0a8cf83c3ad959cfcdd2c71223f::i256::from_u64(arg1)), 0x26166465ede35c13e3ff7f62cc96c7554854a0a8cf83c3ad959cfcdd2c71223f::constants::float_scaling_i256())
    }

    public(friend) fun scale_up(arg0: u64, arg1: u64) : 0x26166465ede35c13e3ff7f62cc96c7554854a0a8cf83c3ad959cfcdd2c71223f::i256::I256 {
        0x26166465ede35c13e3ff7f62cc96c7554854a0a8cf83c3ad959cfcdd2c71223f::i256::div(0x26166465ede35c13e3ff7f62cc96c7554854a0a8cf83c3ad959cfcdd2c71223f::i256::mul(0x26166465ede35c13e3ff7f62cc96c7554854a0a8cf83c3ad959cfcdd2c71223f::i256::from_u64(arg0), 0x26166465ede35c13e3ff7f62cc96c7554854a0a8cf83c3ad959cfcdd2c71223f::constants::float_scaling_i256()), 0x26166465ede35c13e3ff7f62cc96c7554854a0a8cf83c3ad959cfcdd2c71223f::i256::from_u64(arg1))
    }

    // decompiled from Move bytecode v6
}

