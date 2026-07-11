module 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::oracle_error {
    public(friend) fun admin_ref_not_set() : u64 {
        8000025
    }

    public(friend) fun asset_already_registered() : u64 {
        8000019
    }

    public(friend) fun asset_not_registered() : u64 {
        8000020
    }

    public(friend) fun asset_source_conflict() : u64 {
        8000021
    }

    public(friend) fun base_token_not_supported() : u64 {
        8000029
    }

    public(friend) fun deprecated() : u64 {
        1
    }

    public(friend) fun ema_spot_price_too_different() : u64 {
        8000009
    }

    public(friend) fun feed_checks_not_passed() : u64 {
        8000028
    }

    public(friend) fun future_pyth_price() : u64 {
        8000006
    }

    public(friend) fun future_stork_price() : u64 {
        8000022
    }

    public(friend) fun invalid_bound() : u64 {
        8000018
    }

    public(friend) fun invalid_conf_range() : u64 {
        8000005
    }

    public(friend) fun invalid_delay_tolerance() : u64 {
        8000012
    }

    public(friend) fun not_allowed_as_primary() : u64 {
        8000032
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

    public(friend) fun price_time_regressed() : u64 {
        8000033
    }

    public(friend) fun primary_source_missing() : u64 {
        8000026
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

    public(friend) fun pyth_pro_feed_id_not_matching() : u64 {
        8000004
    }

    public(friend) fun pyth_pro_invalid_min_publisher_count() : u64 {
        8000036
    }

    public(friend) fun pyth_pro_missing_item() : u64 {
        8100000
    }

    public(friend) fun pyth_pro_no_value() : u64 {
        8200000
    }

    public(friend) fun pyth_pro_publisher_count_too_small() : u64 {
        8000034
    }

    public(friend) fun pyth_pro_unexpected_channel() : u64 {
        8000035
    }

    public(friend) fun pyth_spot_ema_price_decimals_not_match() : u64 {
        8000003
    }

    public(friend) fun reference_not_monotonic() : u64 {
        8000024
    }

    public(friend) fun source_feed_not_configured() : u64 {
        8000030
    }

    public(friend) fun stork_price_too_old() : u64 {
        8000023
    }

    public(friend) fun unknown_oracle_base_token() : u64 {
        8000008
    }

    public(friend) fun unknown_source() : u64 {
        8000031
    }

    public(friend) fun update_time_gap_too_large() : u64 {
        8000027
    }

    public(friend) fun value_above_upper_bound() : u64 {
        8000017
    }

    public(friend) fun value_below_lower_bound() : u64 {
        8000016
    }

    public(friend) fun value_overflow() : u64 {
        8000015
    }

    public(friend) fun version_not_match() : u64 {
        8000013
    }

    // decompiled from Move bytecode v6
}

