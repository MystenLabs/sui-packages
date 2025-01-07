module 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::error {
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

