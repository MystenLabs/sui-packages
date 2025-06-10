module 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::constants {
    public fun current_version() : u64 {
        1
    }

    public fun float_scaling() : u64 {
        1000000000
    }

    public fun float_scaling_i256() : 0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::I256 {
        0x1da1090a6233cbcfbdd8aca6a4b125904fa4ab97d65215a94d56883e9b95f28::i256::from_u64(1000000000)
    }

    public fun float_scaling_u128() : u128 {
        1000000000
    }

    // decompiled from Move bytecode v6
}

