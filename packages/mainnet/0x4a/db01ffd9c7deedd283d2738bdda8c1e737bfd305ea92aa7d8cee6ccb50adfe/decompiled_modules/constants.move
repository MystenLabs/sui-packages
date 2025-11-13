module 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants {
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

    public fun invalid_oracle() : u64 {
        25
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

    public fun max_price_age_ms() : u64 {
        300000
    }

    public fun max_reasonable_price() : u64 {
        1000000000
    }

    public fun min_reasonable_price() : u64 {
        100000
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

    public fun oracle_id_mainnet() : address {
        @0x7a8053471a59e25ec1995fc41fe0bec72cff619b609aded3ce7c785d2a6e3881
    }

    public fun oracle_id_testnet() : address {
        @0x7e9f0c7485624bb7dfce2f83a1508e5165c3f7a4d42a73a87fef7990d414046b
    }

    public fun our_scale_u64() : u64 {
        1000000
    }

    public fun price_decimals() : u8 {
        6
    }

    public fun price_feed_negative() : u64 {
        21
    }

    public fun price_feed_stale() : u64 {
        20
    }

    public fun price_out_of_bounds() : u64 {
        28
    }

    public fun silver_stake_cap_usd() : u64 {
        700
    }

    public fun tournament_closed() : u64 {
        10
    }

    public fun zero_amount() : u64 {
        5
    }

    // decompiled from Move bytecode v6
}

