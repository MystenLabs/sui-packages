module 0x786a461fd6ac9df351a867181f8cf2679df9e1912201daa8dc4c9452970c1da8::leverage_error {
    public fun market_not_supported() : u64 {
        1000001
    }

    public fun obligation_already_has_position() : u64 {
        1000002
    }

    public fun obligation_no_position() : u64 {
        1000003
    }

    // decompiled from Move bytecode v6
}

