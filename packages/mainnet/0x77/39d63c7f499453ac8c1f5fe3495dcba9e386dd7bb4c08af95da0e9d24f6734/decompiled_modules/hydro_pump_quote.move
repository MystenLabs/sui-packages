module 0x7739d63c7f499453ac8c1f5fe3495dcba9e386dd7bb4c08af95da0e9d24f6734::hydro_pump_quote {
    public fun get_sui_amount_out<T0>(arg0: &0x7739d63c7f499453ac8c1f5fe3495dcba9e386dd7bb4c08af95da0e9d24f6734::hydro_pump::Config, arg1: u64) : u64 {
        let (v0, v1) = 0x7739d63c7f499453ac8c1f5fe3495dcba9e386dd7bb4c08af95da0e9d24f6734::hydro_pump::get_reserves<T0>(arg0);
        let v2 = 0x7739d63c7f499453ac8c1f5fe3495dcba9e386dd7bb4c08af95da0e9d24f6734::curves::calculate_remove_liquidity_return(v0, v1, arg1);
        0x1::option::extract<u64>(&mut v2) * (10000 - 0x7739d63c7f499453ac8c1f5fe3495dcba9e386dd7bb4c08af95da0e9d24f6734::hydro_pump::platform_fee(arg0)) / 10000
    }

    public fun get_token_amount_out<T0>(arg0: &0x7739d63c7f499453ac8c1f5fe3495dcba9e386dd7bb4c08af95da0e9d24f6734::hydro_pump::Config, arg1: u64) : u64 {
        let (v0, v1) = 0x7739d63c7f499453ac8c1f5fe3495dcba9e386dd7bb4c08af95da0e9d24f6734::hydro_pump::get_reserves<T0>(arg0);
        let v2 = 0x7739d63c7f499453ac8c1f5fe3495dcba9e386dd7bb4c08af95da0e9d24f6734::curves::calculate_token_amount_received(v1, v0, arg1 * (10000 - 0x7739d63c7f499453ac8c1f5fe3495dcba9e386dd7bb4c08af95da0e9d24f6734::hydro_pump::platform_fee(arg0)) / 10000);
        0x1::option::extract<u64>(&mut v2)
    }

    // decompiled from Move bytecode v6
}

