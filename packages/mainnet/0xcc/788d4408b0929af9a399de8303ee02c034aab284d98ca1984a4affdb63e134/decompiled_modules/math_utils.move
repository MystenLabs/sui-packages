module 0xcc788d4408b0929af9a399de8303ee02c034aab284d98ca1984a4affdb63e134::math_utils {
    public fun average_u64(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u256) + (arg1 as u256)) / 2) as u64)
    }

    public fun sqrt_u64(arg0: u64) : u64 {
        0x2::math::sqrt(arg0)
    }

    // decompiled from Move bytecode v6
}

