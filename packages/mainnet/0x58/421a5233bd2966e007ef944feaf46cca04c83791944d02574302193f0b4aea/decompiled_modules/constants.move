module 0x58421a5233bd2966e007ef944feaf46cca04c83791944d02574302193f0b4aea::constants {
    public fun current_version() : u64 {
        1
    }

    public fun float_scaling() : u64 {
        1000000000
    }

    public fun float_scaling_i256() : 0x58421a5233bd2966e007ef944feaf46cca04c83791944d02574302193f0b4aea::i256::I256 {
        0x58421a5233bd2966e007ef944feaf46cca04c83791944d02574302193f0b4aea::i256::from_u64(1000000000)
    }

    public fun float_scaling_u128() : u128 {
        1000000000
    }

    // decompiled from Move bytecode v6
}

