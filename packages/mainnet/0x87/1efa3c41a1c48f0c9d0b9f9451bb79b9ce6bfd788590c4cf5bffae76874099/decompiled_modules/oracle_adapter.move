module 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::oracle_adapter {
    struct PriceReadEvent has copy, drop, store {
        bps: u64,
    }

    public entry fun emit_sui_usd_bps(arg0: &0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::Config, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        let v0 = PriceReadEvent{bps: read_sui_usd_bps(arg0, arg1, arg2, arg3)};
        0x2::event::emit<PriceReadEvent>(v0);
    }

    public fun read_sui_usd_bps(arg0: &0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::Config, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : u64 {
        if (0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::emergency_fixed_mode(arg0)) {
            return 0x73fada5297ef08f7e7fd2413bbcd3253ace9d730b5be04bcde192d436d8aa323::config_registry::fixed_sui_usd_price_bps(arg0)
        };
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg1, arg2, arg3);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1), 1002);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) * 10000 / 100000000
    }

    // decompiled from Move bytecode v6
}

