module 0xb943f6c94f32a0df0229fab524cf45064c788e6f13a00be97adfe89082c65217::fee_quoter {
    struct UsdPerTokenUpdated has copy, drop {
        token: address,
        usd_per_token: u256,
        timestamp: u64,
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
            dest_chain_selector : 9762610643973837292,
            usd_per_unit_gas    : arg1,
            timestamp           : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<UsdPerUnitGasUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

