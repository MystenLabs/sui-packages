module 0x26166465ede35c13e3ff7f62cc96c7554854a0a8cf83c3ad959cfcdd2c71223f::constants {
    public fun current_version() : u64 {
        1
    }

    public fun float_scaling() : u64 {
        1000000000
    }

    public fun float_scaling_i256() : 0x26166465ede35c13e3ff7f62cc96c7554854a0a8cf83c3ad959cfcdd2c71223f::i256::I256 {
        0x26166465ede35c13e3ff7f62cc96c7554854a0a8cf83c3ad959cfcdd2c71223f::i256::from_u64(1000000000)
    }

    public fun float_scaling_u128() : u128 {
        1000000000
    }

    // decompiled from Move bytecode v6
}

