module 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::constants {
    public fun current_version() : u64 {
        1
    }

    public fun float_scaling() : u64 {
        1000000000
    }

    public fun float_scaling_i256() : 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::i256::I256 {
        0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::i256::from_u64(1000000000)
    }

    public fun float_scaling_u128() : u128 {
        1000000000
    }

    // decompiled from Move bytecode v6
}

