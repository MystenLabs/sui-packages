module 0xa09f1a1d4930f10bf96a02cac1ac5cfa122ab8912cc6a940f3aba7b24f3e8aa::hydro_pump_quote {
    public fun get_sui_amount_out<T0>(arg0: &0xa09f1a1d4930f10bf96a02cac1ac5cfa122ab8912cc6a940f3aba7b24f3e8aa::hydro_pump::Config, arg1: u64) : u64 {
        let (v0, v1) = 0xa09f1a1d4930f10bf96a02cac1ac5cfa122ab8912cc6a940f3aba7b24f3e8aa::hydro_pump::get_reserves<T0>(arg0);
        let v2 = 0xa09f1a1d4930f10bf96a02cac1ac5cfa122ab8912cc6a940f3aba7b24f3e8aa::curves::calculate_remove_liquidity_return(v0, v1, arg1);
        0x1::option::extract<u64>(&mut v2) * (10000 - 0xa09f1a1d4930f10bf96a02cac1ac5cfa122ab8912cc6a940f3aba7b24f3e8aa::hydro_pump::platform_fee(arg0)) / 10000
    }

    public fun get_token_amount_out<T0>(arg0: &0xa09f1a1d4930f10bf96a02cac1ac5cfa122ab8912cc6a940f3aba7b24f3e8aa::hydro_pump::Config, arg1: u64) : u64 {
        let (v0, v1) = 0xa09f1a1d4930f10bf96a02cac1ac5cfa122ab8912cc6a940f3aba7b24f3e8aa::hydro_pump::get_reserves<T0>(arg0);
        let v2 = 0xa09f1a1d4930f10bf96a02cac1ac5cfa122ab8912cc6a940f3aba7b24f3e8aa::curves::calculate_token_amount_received(v1, v0, arg1 * (10000 - 0xa09f1a1d4930f10bf96a02cac1ac5cfa122ab8912cc6a940f3aba7b24f3e8aa::hydro_pump::platform_fee(arg0)) / 10000);
        0x1::option::extract<u64>(&mut v2)
    }

    // decompiled from Move bytecode v6
}

