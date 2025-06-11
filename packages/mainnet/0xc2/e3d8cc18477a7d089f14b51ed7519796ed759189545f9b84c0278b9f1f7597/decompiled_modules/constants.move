module 0xc2e3d8cc18477a7d089f14b51ed7519796ed759189545f9b84c0278b9f1f7597::constants {
    public fun current_version() : u64 {
        1
    }

    public fun float_scaling() : u64 {
        1000000000
    }

    public fun float_scaling_i256() : 0xc2e3d8cc18477a7d089f14b51ed7519796ed759189545f9b84c0278b9f1f7597::i256::I256 {
        0xc2e3d8cc18477a7d089f14b51ed7519796ed759189545f9b84c0278b9f1f7597::i256::from_u64(1000000000)
    }

    // decompiled from Move bytecode v6
}

