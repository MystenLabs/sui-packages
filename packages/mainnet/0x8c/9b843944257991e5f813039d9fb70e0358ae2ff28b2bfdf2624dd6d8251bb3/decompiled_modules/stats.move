module 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::stats {
    struct InitStatsEvent has copy, drop {
        stats_id: 0x2::object::ID,
    }

    struct Stats has store, key {
        id: 0x2::object::UID,
        total_volume: u256,
    }

    public(friend) fun add_total_volume_internal(arg0: &mut Stats, arg1: u256) {
        assert!(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::math_u256::add_check(arg0.total_volume, arg1), 932523069343634633);
        arg0.total_volume = arg0.total_volume + arg1;
    }

    public fun get_total_volume(arg0: &Stats) : u256 {
        arg0.total_volume
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Stats{
            id           : 0x2::object::new(arg0),
            total_volume : 0,
        };
        let v1 = InitStatsEvent{stats_id: 0x2::object::id<Stats>(&v0)};
        0x2::transfer::share_object<Stats>(v0);
        0x2::event::emit<InitStatsEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

