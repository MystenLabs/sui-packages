module 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign_stats {
    struct CampaignStats has key {
        id: 0x2::object::UID,
        parent_id: 0x2::object::ID,
        total_usd_micro: u64,
        total_donations_count: u64,
    }

    struct PerCoinKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PerCoinStats<phantom T0> has store {
        total_raw: u128,
        donation_count: u64,
    }

    struct CampaignStatsCreated has copy, drop {
        campaign_id: 0x2::object::ID,
        stats_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    public fun id(arg0: &CampaignStats) : 0x2::object::ID {
        0x2::object::id<CampaignStats>(arg0)
    }

    public(friend) fun add_donation<T0>(arg0: &mut CampaignStats, arg1: u128, arg2: u64) {
        let v0 = ensure_per_coin<T0>(arg0);
        assert!(arg1 <= 340282366920938463463374607431768211455 - v0.total_raw, 2);
        v0.total_raw = v0.total_raw + arg1;
        assert!(v0.donation_count < 18446744073709551615, 2);
        v0.donation_count = v0.donation_count + 1;
        assert!(arg2 <= 18446744073709551615 - arg0.total_usd_micro, 2);
        arg0.total_usd_micro = arg0.total_usd_micro + arg2;
        assert!(arg0.total_donations_count < 18446744073709551615, 2);
        arg0.total_donations_count = arg0.total_donations_count + 1;
    }

    public fun campaign_stats_created_campaign_id(arg0: &CampaignStatsCreated) : 0x2::object::ID {
        arg0.campaign_id
    }

    public fun campaign_stats_created_stats_id(arg0: &CampaignStatsCreated) : 0x2::object::ID {
        arg0.stats_id
    }

    public fun campaign_stats_created_timestamp_ms(arg0: &CampaignStatsCreated) : u64 {
        arg0.timestamp_ms
    }

    public(friend) fun create_for_campaign(arg0: &mut 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::Campaign, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::stats_id(arg0);
        assert!(0x2::object::id_to_address(&v0) == @0x0, 1);
        let v1 = 0x2::object::id<0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::Campaign>(arg0);
        let v2 = CampaignStats{
            id                    : 0x2::object::new(arg2),
            parent_id             : v1,
            total_usd_micro       : 0,
            total_donations_count : 0,
        };
        let v3 = 0x2::object::id<CampaignStats>(&v2);
        0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::campaign::set_stats_id(arg0, v3);
        0x2::transfer::share_object<CampaignStats>(v2);
        let v4 = CampaignStatsCreated{
            campaign_id  : v1,
            stats_id     : v3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<CampaignStatsCreated>(v4);
        v3
    }

    public fun e_overflow() : u64 {
        2
    }

    public fun e_stats_already_exists() : u64 {
        1
    }

    public(friend) fun ensure_per_coin<T0>(arg0: &mut CampaignStats) : &mut PerCoinStats<T0> {
        let v0 = per_coin_key<T0>();
        if (!0x2::dynamic_field::exists_<PerCoinKey<T0>>(&arg0.id, v0)) {
            let v1 = PerCoinStats<T0>{
                total_raw      : 0,
                donation_count : 0,
            };
            0x2::dynamic_field::add<PerCoinKey<T0>, PerCoinStats<T0>>(&mut arg0.id, v0, v1);
        };
        0x2::dynamic_field::borrow_mut<PerCoinKey<T0>, PerCoinStats<T0>>(&mut arg0.id, v0)
    }

    public fun per_coin_donation_count<T0>(arg0: &CampaignStats) : u64 {
        let v0 = per_coin_key<T0>();
        if (!0x2::dynamic_field::exists_<PerCoinKey<T0>>(&arg0.id, v0)) {
            0
        } else {
            0x2::dynamic_field::borrow<PerCoinKey<T0>, PerCoinStats<T0>>(&arg0.id, v0).donation_count
        }
    }

    fun per_coin_key<T0>() : PerCoinKey<T0> {
        PerCoinKey<T0>{dummy_field: false}
    }

    public fun per_coin_total_raw<T0>(arg0: &CampaignStats) : u128 {
        let v0 = per_coin_key<T0>();
        if (!0x2::dynamic_field::exists_<PerCoinKey<T0>>(&arg0.id, v0)) {
            0
        } else {
            0x2::dynamic_field::borrow<PerCoinKey<T0>, PerCoinStats<T0>>(&arg0.id, v0).total_raw
        }
    }

    public fun total_donations_count(arg0: &CampaignStats) : u64 {
        arg0.total_donations_count
    }

    public fun total_usd_micro(arg0: &CampaignStats) : u64 {
        arg0.total_usd_micro
    }

    // decompiled from Move bytecode v6
}

