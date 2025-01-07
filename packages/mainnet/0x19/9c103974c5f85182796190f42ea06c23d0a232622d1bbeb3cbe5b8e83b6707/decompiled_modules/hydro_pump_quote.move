module 0x199c103974c5f85182796190f42ea06c23d0a232622d1bbeb3cbe5b8e83b6707::hydro_pump_quote {
    public fun get_sui_amount_out<T0>(arg0: &0x199c103974c5f85182796190f42ea06c23d0a232622d1bbeb3cbe5b8e83b6707::hydro_pump::Config, arg1: u64) : u64 {
        let (v0, v1) = 0x199c103974c5f85182796190f42ea06c23d0a232622d1bbeb3cbe5b8e83b6707::hydro_pump::get_reserves<T0>(arg0);
        let v2 = 0x199c103974c5f85182796190f42ea06c23d0a232622d1bbeb3cbe5b8e83b6707::curves::calculate_remove_liquidity_return(v0, v1, arg1);
        0x1::option::extract<u64>(&mut v2) * (10000 - 0x199c103974c5f85182796190f42ea06c23d0a232622d1bbeb3cbe5b8e83b6707::hydro_pump::platform_fee(arg0)) / 10000
    }

    public fun get_token_amount_out<T0>(arg0: &0x199c103974c5f85182796190f42ea06c23d0a232622d1bbeb3cbe5b8e83b6707::hydro_pump::Config, arg1: u64) : u64 {
        let (v0, v1) = 0x199c103974c5f85182796190f42ea06c23d0a232622d1bbeb3cbe5b8e83b6707::hydro_pump::get_reserves<T0>(arg0);
        let v2 = 0x199c103974c5f85182796190f42ea06c23d0a232622d1bbeb3cbe5b8e83b6707::curves::calculate_token_amount_received(v1, v0, arg1 * (10000 - 0x199c103974c5f85182796190f42ea06c23d0a232622d1bbeb3cbe5b8e83b6707::hydro_pump::platform_fee(arg0)) / 10000);
        0x1::option::extract<u64>(&mut v2)
    }

    // decompiled from Move bytecode v6
}

