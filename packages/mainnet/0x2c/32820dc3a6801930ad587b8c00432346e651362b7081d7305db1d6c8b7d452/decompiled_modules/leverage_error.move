module 0x2c32820dc3a6801930ad587b8c00432346e651362b7081d7305db1d6c8b7d452::leverage_error {
    public fun market_not_supported() : u64 {
        1000001
    }

    public fun obligation_already_has_position() : u64 {
        1000002
    }

    public fun obligation_inconsistent_operation() : u64 {
        1000004
    }

    public fun obligation_no_position() : u64 {
        1000003
    }

    // decompiled from Move bytecode v6
}

