module 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::oracle_adapter {
    struct PriceReadEvent has copy, drop, store {
        bps: u64,
    }

    public entry fun emit_sui_usd_bps(arg0: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        let v0 = PriceReadEvent{bps: read_sui_usd_bps(arg0, arg1, arg2, arg3)};
        0x2::event::emit<PriceReadEvent>(v0);
    }

    public fun read_sui_usd_bps(arg0: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : u64 {
        if (0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::emergency_fixed_mode(arg0)) {
            return 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::fixed_sui_usd_price_bps(arg0)
        };
        assert!(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State>(arg1) == 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::pyth_state_id(arg0), 1003);
        assert!(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2) == 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::pyth_sui_price_info_id(arg0), 1004);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg1, arg2, arg3);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1), 1002);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3), 1005);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3) == 8, 1005);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0) * 10000 <= v2 * 1000, 1006);
        v2 * 10000 / 100000000
    }

    // decompiled from Move bytecode v7
}

