module 0xb97857eb8c5b0c9aaf4ae617982a9557d5386b093a00adbc35bace8b14a6a7a6::oracle_error {
    public(friend) fun ema_spot_price_too_different() : u64 {
        8000009
    }

    public(friend) fun future_pyth_price() : u64 {
        8000006
    }

    public(friend) fun illegal_pyth_price_object() : u64 {
        8000004
    }

    public(friend) fun invalid_conf_range() : u64 {
        8000005
    }

    public(friend) fun invalid_delay_tolerance() : u64 {
        8000012
    }

    public(friend) fun oracle_price_not_found_error() : u64 {
        8000007
    }

    public(friend) fun oracle_stale_price_error() : u64 {
        8000010
    }

    public(friend) fun oracle_zero_price_error() : u64 {
        8000011
    }

    public(friend) fun pyth_price_conf_too_large() : u64 {
        8000002
    }

    public(friend) fun pyth_price_decimals_too_large() : u64 {
        8000000
    }

    public(friend) fun pyth_price_too_old() : u64 {
        8000001
    }

    public(friend) fun pyth_spot_ema_price_decimals_not_match() : u64 {
        8000003
    }

    public(friend) fun unknown_oracle_base_token() : u64 {
        8000008
    }

    public(friend) fun version_not_match() : u64 {
        8000013
    }

    // decompiled from Move bytecode v6
}

