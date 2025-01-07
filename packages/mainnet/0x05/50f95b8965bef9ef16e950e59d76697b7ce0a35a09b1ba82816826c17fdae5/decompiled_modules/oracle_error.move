module 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_error {
    public fun incorrect_version() : u64 {
        6200
    }

    public fun invalid_oracle_provider() : u64 {
        6009
    }

    public fun invalid_value() : u64 {
        6014
    }

    public fun non_existent_oracle() : u64 {
        6011
    }

    public fun not_available_version() : u64 {
        6201
    }

    public fun oracle_already_exist() : u64 {
        6012
    }

    public fun oracle_config_already_exists() : u64 {
        6004
    }

    public fun oracle_provider_config_not_found() : u64 {
        6005
    }

    public fun oracle_provider_disabled() : u64 {
        6013
    }

    public fun pair_not_match() : u64 {
        6007
    }

    public fun paused() : u64 {
        6006
    }

    public fun price_feed_already_exists() : u64 {
        6001
    }

    public fun price_feed_not_found() : u64 {
        6000
    }

    public fun price_length_not_match() : u64 {
        6010
    }

    public fun price_oracle_not_found() : u64 {
        6008
    }

    public fun provider_config_not_found() : u64 {
        6002
    }

    public fun provider_is_being_used_in_primary() : u64 {
        6003
    }

    // decompiled from Move bytecode v6
}

