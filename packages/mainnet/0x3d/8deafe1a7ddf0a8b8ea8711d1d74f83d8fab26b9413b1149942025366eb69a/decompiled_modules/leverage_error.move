module 0x3d8deafe1a7ddf0a8b8ea8711d1d74f83d8fab26b9413b1149942025366eb69a::leverage_error {
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

