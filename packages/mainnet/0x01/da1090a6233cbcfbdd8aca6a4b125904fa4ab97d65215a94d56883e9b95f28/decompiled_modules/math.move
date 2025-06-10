module 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::math {
    public(friend) fun div(arg0: u64, arg1: u64) : u64 {
        mul_div(arg0, 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::constants::float_scaling(), arg1)
    }

    public(friend) fun mul(arg0: u64, arg1: u64) : u64 {
        mul_div(arg0, arg1, 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::constants::float_scaling())
    }

    public(friend) fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public(friend) fun power_of_ten(arg0: u8) : u64 {
        0x1::u64::pow(10, arg0)
    }

    public(friend) fun scale_down(arg0: 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256, arg1: u64) : 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256 {
        0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::div(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(arg0, 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::from_u64(arg1)), 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::constants::float_scaling_i256())
    }

    public(friend) fun scale_up(arg0: u64, arg1: u64) : 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256 {
        0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::div(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::mul(0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::from_u64(arg0), 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::constants::float_scaling_i256()), 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::from_u64(arg1))
    }

    // decompiled from Move bytecode v6
}

