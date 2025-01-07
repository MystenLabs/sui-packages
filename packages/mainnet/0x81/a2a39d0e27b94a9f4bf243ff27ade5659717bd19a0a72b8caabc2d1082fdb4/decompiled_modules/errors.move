module 0x81a2a39d0e27b94a9f4bf243ff27ade5659717bd19a0a72b8caabc2d1082fdb4::errors {
    public fun insufficient_funds() : u64 {
        1004
    }

    public fun unauthorized() : u64 {
        1003
    }

    public fun version_mismatch() : u64 {
        1001
    }

    public fun zero_coin_amount() : u64 {
        1002
    }

    // decompiled from Move bytecode v6
}

