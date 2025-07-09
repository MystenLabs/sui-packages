module 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::stats {
    struct InitStatsEvent has copy, drop {
        stats_id: 0x2::object::ID,
    }

    struct Stats has store, key {
        id: 0x2::object::UID,
        total_volume: u256,
    }

    public(friend) fun add_total_volume_internal(arg0: &mut Stats, arg1: u256) {
        assert!(0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::math_u256::add_check(arg0.total_volume, arg1), 932523069343634633);
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

