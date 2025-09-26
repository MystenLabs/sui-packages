module 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::constants {
    public fun amount_mismatch() : u64 {
        1
    }

    public fun bronze_stake_cap_usd() : u64 {
        500
    }

    public fun caller_already_added() : u64 {
        23
    }

    public fun caller_not_found() : u64 {
        24
    }

    public fun check_not_due() : u64 {
        13
    }

    public fun escrow_address() : address {
        @0x1544643ecd21f2f5e79daf5f5feeb117d3c0006c677bc3fe834c985ab4c7c0f1
    }

    public fun feed_not_found() : u64 {
        27
    }

    public fun game_not_staked() : u64 {
        12
    }

    public fun gold_stake_cap_usd() : u64 {
        1000
    }

    public fun insufficient_balance() : u64 {
        2
    }

    public fun insufficient_fee() : u64 {
        26
    }

    public fun invalid_address() : u64 {
        4
    }

    public fun invalid_amount() : u64 {
        8
    }

    public fun invalid_number_of_players() : u64 {
        14
    }

    public fun invalid_pairing() : u64 {
        17
    }

    public fun invalid_player() : u64 {
        16
    }

    public fun invalid_price_feed() : u64 {
        19
    }

    public fun invalid_round() : u64 {
        11
    }

    public fun invalid_stake_amount() : u64 {
        18
    }

    public fun invalid_stork_state() : u64 {
        25
    }

    public fun max_price_age_seconds() : u64 {
        60
    }

    public fun not_admin() : u64 {
        22
    }

    public fun not_creator() : u64 {
        15
    }

    public fun not_verified_caller() : u64 {
        9
    }

    public fun one_month_ms() : u64 {
        2592000000
    }

    public fun price_feed_negative() : u64 {
        21
    }

    public fun price_feed_stale() : u64 {
        20
    }

    public fun silver_stake_cap_usd() : u64 {
        700
    }

    public fun stork_state_address() : address {
        @0x3c7d6f27048538f8484142c59cff680c9b31c5353d15470a5a526177f781d1da
    }

    public fun sui_usd_feed_id() : vector<u8> {
        x"a24cc95a4f3d70a0a2f7ac652b67a4a73791631ff06b4ee7f729097311169b81"
    }

    public fun tournament_closed() : u64 {
        10
    }

    public fun zero_amount() : u64 {
        5
    }

    // decompiled from Move bytecode v6
}

