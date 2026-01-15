module 0xdeafb4aaf63fd8cd1607cab57941101d1e611b18e195d55f1f16661391cdd56d::fee_quoter {
    struct UsdPerTokenUpdated has copy, drop {
        token: address,
        usd_per_token: u256,
        timestamp: u64,
    }

    struct StaticConfig has copy, drop {
        max_fee_juels_per_msg: u256,
        link_token: address,
        token_price_staleness_threshold: u64,
    }

    struct UsdPerUnitGasUpdated has copy, drop {
        dest_chain_selector: u64,
        usd_per_unit_gas: u256,
        timestamp: u64,
    }

    public fun drill_price_registries(arg0: &0x2::clock::Clock, arg1: address, arg2: u256, arg3: u256) {
        emit_usd_per_token_updated(arg0, arg1, arg2);
        emit_usd_per_unit_gas_updated(arg0, arg3);
    }

    public fun emit_usd_per_token_updated(arg0: &0x2::clock::Clock, arg1: address, arg2: u256) {
        let v0 = UsdPerTokenUpdated{
            token         : arg1,
            usd_per_token : arg2,
            timestamp     : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<UsdPerTokenUpdated>(v0);
    }

    public fun emit_usd_per_unit_gas_updated(arg0: &0x2::clock::Clock, arg1: u256) {
        let v0 = UsdPerUnitGasUpdated{
            dest_chain_selector : 17529533435026248318,
            usd_per_unit_gas    : arg1,
            timestamp           : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<UsdPerUnitGasUpdated>(v0);
    }

    public fun get_static_config(arg0: &0xdeafb4aaf63fd8cd1607cab57941101d1e611b18e195d55f1f16661391cdd56d::state_object::CCIPObjectRef) : StaticConfig {
        StaticConfig{
            max_fee_juels_per_msg           : 1,
            link_token                      : @0x147521f83d2f7fda5989686b55c1c3da07b7fd0e507a5ae37a8f0b09a3739e0e,
            token_price_staleness_threshold : 0,
        }
    }

    // decompiled from Move bytecode v6
}

