module 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::error {
    public fun oracle_price_not_found_error() : u64 {
        1026
    }

    public fun oracle_stale_price_error() : u64 {
        1025
    }

    public fun whitelist_error() : u64 {
        1024
    }

    // decompiled from Move bytecode v6
}

