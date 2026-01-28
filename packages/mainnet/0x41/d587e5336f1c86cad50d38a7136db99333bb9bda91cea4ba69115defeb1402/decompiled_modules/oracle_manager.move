module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_manager {
    struct OracleManagerRole {
        dummy_field: bool,
    }

    public fun set_pyth_confidence_bps(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::AggregatedOracle, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<OracleManagerRole>, arg2: u16) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::set_pyth_confidence_bps(arg0, arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_oracle_pyth_confidence_bps_updated(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::id(arg0), arg2);
    }

    public fun add_oracle_feed(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::AggregatedOracle, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<OracleManagerRole>, arg2: 0x1::string::String, arg3: vector<u8>) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::add_feed(arg0, arg2, arg3);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_oracle_feed_added(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::id(arg0), arg2, arg3);
    }

    public fun new_oracle(arg0: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<OracleManagerRole>, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::AggregatedOracle {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::new(arg1, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::new(arg3, arg4, arg2), arg5)
    }

    public fun remove_oracle_feed(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::AggregatedOracle, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<OracleManagerRole>, arg2: 0x1::string::String) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::remove_feed(arg0, arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_oracle_feed_removed(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::id(arg0), arg2);
    }

    public fun set_oracle_max_age_ms(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::AggregatedOracle, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<OracleManagerRole>, arg2: u64) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::set_max_age_ms(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::limits_mut(arg0), arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_oracle_max_age_updated(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::id(arg0), arg2);
    }

    public fun set_oracle_max_price(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::AggregatedOracle, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<OracleManagerRole>, arg2: u64) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::set_max_price(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::limits_mut(arg0), arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_oracle_max_price_updated(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::id(arg0), arg2);
    }

    public fun set_oracle_min_price(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::AggregatedOracle, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<OracleManagerRole>, arg2: u64) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::oracle_limits::set_min_price(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::limits_mut(arg0), arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_oracle_min_price_updated(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::id(arg0), arg2);
    }

    public fun set_oracle_minimum_sources(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::AggregatedOracle, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<OracleManagerRole>, arg2: u8) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::set_minimum_sources(arg0, arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_oracle_minimum_sources_updated(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::aggregated_oracle::id(arg0), arg2);
    }

    // decompiled from Move bytecode v6
}

