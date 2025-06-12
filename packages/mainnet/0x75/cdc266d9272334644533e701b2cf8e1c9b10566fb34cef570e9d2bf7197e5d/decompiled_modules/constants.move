module 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::constants {
    public fun current_version() : u64 {
        1
    }

    public fun float_scaling() : u64 {
        1000000000
    }

    public fun float_scaling_i256() : 0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::I256 {
        0x75cdc266d9272334644533e701b2cf8e1c9b10566fb34cef570e9d2bf7197e5d::i256::from_u64(1000000000)
    }

    // decompiled from Move bytecode v6
}

