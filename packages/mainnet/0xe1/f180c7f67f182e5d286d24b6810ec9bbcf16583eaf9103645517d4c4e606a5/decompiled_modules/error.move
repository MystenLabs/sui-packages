module 0xe1f180c7f67f182e5d286d24b6810ec9bbcf16583eaf9103645517d4c4e606a5::error {
    public fun not_enough_balance() : u64 {
        32199663576772608 + 104
    }

    public fun not_owner() : u64 {
        32199663576772608 + 100
    }

    public fun not_publisher() : u64 {
        32199663576772608 + 103
    }

    public fun profile_cap_limit_reached() : u64 {
        32199663576772608 + 105
    }

    public fun profile_name_too_short() : u64 {
        32199663576772608 + 101
    }

    public fun unexpected_char_in_profile_name() : u64 {
        32199663576772608 + 102
    }

    // decompiled from Move bytecode v6
}

