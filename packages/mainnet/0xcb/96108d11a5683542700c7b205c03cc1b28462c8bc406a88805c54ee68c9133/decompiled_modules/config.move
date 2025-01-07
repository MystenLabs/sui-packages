module 0xcb96108d11a5683542700c7b205c03cc1b28462c8bc406a88805c54ee68c9133::config {
    public fun crew_others_shares() : u64 {
        90
    }

    public fun crew_winner_shares() : u64 {
        10
    }

    public fun dev_shares() : u64 {
        100
    }

    public fun direct_senior_shares() : u64 {
        100
    }

    public fun end_time_hard_cap() : u64 {
        1200000
    }

    public fun final_pool_shares() : u64 {
        600
    }

    public fun final_total_shares() : u64 {
        1000
    }

    public fun final_winner_count() : u64 {
        20
    }

    public fun indirect_seniors_shares() : u64 {
        100
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(ticket_total_shares() == final_pool_shares() + lootbox_pool_shares() + direct_senior_shares() + indirect_seniors_shares(), 0);
        assert!(final_total_shares() == winner_shares() + dev_shares() + crew_winner_shares() + crew_others_shares(), 0);
    }

    public fun initial_countdown() : u64 {
        259200000
    }

    public fun initial_price_in_sui() : u64 {
        2000000000
    }

    public fun lootbox_pool_shares() : u64 {
        200
    }

    public fun max_price_in_sui() : u64 {
        30000000000
    }

    public fun max_referral_depth() : u64 {
        50
    }

    public fun precision() : u128 {
        1000000000000000000
    }

    public fun precision_decimals() : u8 {
        18
    }

    public fun price_increment() : u64 {
        1000000000
    }

    public fun price_period() : u64 {
        7200000
    }

    public fun raffle_period() : u64 {
        7200000
    }

    public fun raffle_winner_count() : u64 {
        3
    }

    public fun score_threshold() : u64 {
        20
    }

    public fun sui_decimals() : u8 {
        9
    }

    public fun ticket_total_shares() : u64 {
        1000
    }

    public fun time_increment() : u64 {
        45000
    }

    public fun winner_shares() : u64 {
        800
    }

    // decompiled from Move bytecode v6
}

