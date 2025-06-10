module 0xae59a8e1ba8caa0de5937003e0df77570108788354a8b95543526e07ad063d82::constants {
    public fun current_version() : u64 {
        1
    }

    public fun float_scaling() : u64 {
        1000000000
    }

    public fun float_scaling_i256() : 0xae59a8e1ba8caa0de5937003e0df77570108788354a8b95543526e07ad063d82::i256::I256 {
        0xae59a8e1ba8caa0de5937003e0df77570108788354a8b95543526e07ad063d82::i256::from_u64(1000000000)
    }

    public fun float_scaling_u128() : u128 {
        1000000000
    }

    // decompiled from Move bytecode v6
}

