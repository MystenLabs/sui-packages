module 0x13fe75a37f1bf1c7776133e2bd478436cc2b3a5cbf0404ac8e30b32fdb5970af::hydro_pump_quote {
    public fun get_sui_amount_out<T0>(arg0: &0x13fe75a37f1bf1c7776133e2bd478436cc2b3a5cbf0404ac8e30b32fdb5970af::hydro_pump::Config, arg1: u64) : u64 {
        let (v0, v1) = 0x13fe75a37f1bf1c7776133e2bd478436cc2b3a5cbf0404ac8e30b32fdb5970af::hydro_pump::get_reserves<T0>(arg0);
        let v2 = 0x13fe75a37f1bf1c7776133e2bd478436cc2b3a5cbf0404ac8e30b32fdb5970af::curves::calculate_remove_liquidity_return(v0, v1, arg1);
        0x1::option::extract<u64>(&mut v2) * (10000 - 0x13fe75a37f1bf1c7776133e2bd478436cc2b3a5cbf0404ac8e30b32fdb5970af::hydro_pump::platform_fee(arg0)) / 10000
    }

    public fun get_token_amount_out<T0>(arg0: &0x13fe75a37f1bf1c7776133e2bd478436cc2b3a5cbf0404ac8e30b32fdb5970af::hydro_pump::Config, arg1: u64) : u64 {
        let (v0, v1) = 0x13fe75a37f1bf1c7776133e2bd478436cc2b3a5cbf0404ac8e30b32fdb5970af::hydro_pump::get_reserves<T0>(arg0);
        let v2 = 0x13fe75a37f1bf1c7776133e2bd478436cc2b3a5cbf0404ac8e30b32fdb5970af::curves::calculate_token_amount_received(v1, v0, arg1 * (10000 - 0x13fe75a37f1bf1c7776133e2bd478436cc2b3a5cbf0404ac8e30b32fdb5970af::hydro_pump::platform_fee(arg0)) / 10000);
        0x1::option::extract<u64>(&mut v2)
    }

    // decompiled from Move bytecode v6
}

