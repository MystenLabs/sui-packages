module 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants {
    public fun accessible_by_all_plan() : u8 {
        0
    }

    public fun admin_fee_profile_kraft() : u64 {
        50
    }

    public fun amm_fee_precision() : u64 {
        10000
    }

    public fun bee_burn_pct() : u64 {
        3
    }

    public fun bees_for_streambuzz_profile_pct() : u64 {
        20
    }

    public fun bees_for_treasury_pct() : u64 {
        50
    }

    public fun boost_precision() : u64 {
        1000
    }

    public fun borrow_locking_window() : u64 {
        604800000
    }

    public fun buidler_share_pct() : u64 {
        50
    }

    public fun chronicle_comment_entropy_cost() : u64 {
        1
    }

    public fun chronicle_comment_entropy_points() : u64 {
        3
    }

    public fun chronicle_like_entropy_cost() : u64 {
        1
    }

    public fun chronicle_like_entropy_points() : u64 {
        1
    }

    public fun comment_engagement_cost() : u64 {
        3
    }

    public fun comment_points() : u64 {
        10
    }

    public fun creator_share_kraft() : u64 {
        75
    }

    public fun curved_hive_fee_percent() : u64 {
        42
    }

    public fun curved_total_fee_bps() : u64 {
        40
    }

    public fun default_username() : vector<u8> {
        b"undefined"
    }

    public fun drone_bee_plan() : u8 {
        2
    }

    public fun emergency_unlock_tax() : u64 {
        3
    }

    public fun epoch_duration_ms() : u64 {
        86400000
    }

    public fun forever_subscribe_plan() : u8 {
        4
    }

    public fun forever_subscribe_plan_length() : u64 {
        833040
    }

    public fun genesis_bee_for_lp_pct() : u64 {
        15
    }

    public fun hive_burn_pct() : u64 {
        25
    }

    public fun hive_decimal_precision() : u64 {
        1000000
    }

    public fun hive_gems_for_ad_incentives() : u64 {
        50000000000000
    }

    public fun hive_treasury_pct() : u64 {
        10
    }

    public fun init_bee_pol_pct() : u64 {
        20
    }

    public fun init_buzzes_per_stream() : u64 {
        10
    }

    public fun init_hive_pol_pct() : u64 {
        70
    }

    public fun init_tax_allowed() : u64 {
        5
    }

    public fun init_treasury_percent() : u64 {
        10
    }

    public fun init_winning_bid_points() : u64 {
        10000
    }

    public fun kiosk_storage() : vector<u8> {
        b"creator_kiosk"
    }

    public fun like_engagement_cost() : u64 {
        1
    }

    public fun like_points() : u64 {
        1
    }

    public fun limited_deposit_window() : u64 {
        2
    }

    public fun lockdrop_emergency_unlock_tax() : u64 {
        7
    }

    public fun lsd_exchange_rate_precision() : u64 {
        1000000000
    }

    public fun lsd_init_delay_epoches() : u64 {
        1
    }

    public fun lsd_init_protocol_fee_percent() : u64 {
        5
    }

    public fun lsd_init_service_fee_percent() : u64 {
        2
    }

    public fun lsd_init_treasury_fee_percent() : u64 {
        10
    }

    public fun lsd_max_protocol_fee_percent() : u64 {
        15
    }

    public fun lsd_max_service_fee_percent() : u64 {
        5
    }

    public fun lsd_max_treasury_fee_percent() : u64 {
        50
    }

    public fun max_bio_length() : u64 {
        370
    }

    public fun max_collection_name_length() : u64 {
        24
    }

    public fun max_first_rank_limit() : u64 {
        10000
    }

    public fun max_hive_fee() : u64 {
        70
    }

    public fun max_profile_name_length() : u64 {
        24
    }

    public fun max_swap_fee() : u64 {
        300
    }

    public fun max_treasury_fee() : u64 {
        25
    }

    public fun max_twap_update_delay() : u64 {
        3600000
    }

    public fun max_weighted_exit_fee() : u64 {
        100
    }

    public fun max_whitelisted_validators_allowed() : u64 {
        100
    }

    public fun min_gap_for_profile_deletion() : u64 {
        2592000000
    }

    public fun min_hive_fee() : u64 {
        30
    }

    public fun min_swap_fee() : u64 {
        1
    }

    public fun min_treasury_fee() : u64 {
        5
    }

    public fun month_multiplier() : u64 {
        2592000000
    }

    public fun nfts_royalty_num() : u64 {
        5
    }

    public fun percent_precision() : u64 {
        100
    }

    public fun pool_royalty_pct() : u64 {
        5
    }

    public fun precision_constant() : u64 {
        1000000000000000000
    }

    public fun public_kraft_storage() : vector<u8> {
        b"::PUBLIC_KRAFT_CONFIG"
    }

    public fun queen_bee_plan() : u8 {
        3
    }

    public fun rank_rewards_pct(arg0: u8) : u64 {
        if (arg0 == 1) {
            5
        } else if (arg0 == 2) {
            3
        } else {
            2
        }
    }

    public fun required_quorum() : u64 {
        240000
    }

    public fun socials_royalty_num() : u64 {
        5
    }

    public fun stable_hive_fee_percent() : u64 {
        35
    }

    public fun stable_total_fee_bps() : u64 {
        20
    }

    public fun stream_duration_epoches() : u64 {
        7
    }

    public fun streamer_buzzes_store() : vector<u8> {
        b"STREAMER_BUZZES"
    }

    public fun subscriber_points() : u64 {
        100
    }

    public fun sui_for_hive_pool() : u64 {
        40
    }

    public fun sui_for_stream_pct() : u64 {
        10
    }

    public fun total_bee_supply() : u64 {
        420000000000000000
    }

    public fun total_hive_gems_supply() : u64 {
        1000000000000000
    }

    public fun twap_init_tolerance() : u64 {
        300000
    }

    public fun twap_init_window_size() : u64 {
        900000
    }

    public fun twap_max_tolerance() : u64 {
        900000
    }

    public fun twap_max_window_size() : u64 {
        18000000
    }

    public fun twap_precision() : u64 {
        9
    }

    public fun unlimited_deposit_window() : u64 {
        5
    }

    public fun vote_threshold() : u64 {
        510000
    }

    public fun voting_precision() : u64 {
        1000000
    }

    public fun week_multiplier() : u64 {
        604800000
    }

    public fun weighted_hive_fee_percent() : u64 {
        34
    }

    public fun weighted_total_fee_bps() : u64 {
        35
    }

    public fun worker_bee_plan() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

