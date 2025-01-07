module 0xf9a8cc6f3e3d52af2f1372a81ab6097ed95b4e11c917ccc107c72446d2575290::hydro_pump_quote {
    public fun get_sui_amount_out<T0>(arg0: &0xf9a8cc6f3e3d52af2f1372a81ab6097ed95b4e11c917ccc107c72446d2575290::hydro_pump::Config, arg1: u64) : u64 {
        let (v0, v1) = 0xf9a8cc6f3e3d52af2f1372a81ab6097ed95b4e11c917ccc107c72446d2575290::hydro_pump::get_reserves<T0>(arg0);
        let v2 = 0xf9a8cc6f3e3d52af2f1372a81ab6097ed95b4e11c917ccc107c72446d2575290::curves::calculate_remove_liquidity_return(v0, v1, arg1);
        0x1::option::extract<u64>(&mut v2) * (10000 - 0xf9a8cc6f3e3d52af2f1372a81ab6097ed95b4e11c917ccc107c72446d2575290::hydro_pump::platform_fee(arg0)) / 10000
    }

    public fun get_token_amount_out<T0>(arg0: &0xf9a8cc6f3e3d52af2f1372a81ab6097ed95b4e11c917ccc107c72446d2575290::hydro_pump::Config, arg1: u64) : u64 {
        let (v0, v1) = 0xf9a8cc6f3e3d52af2f1372a81ab6097ed95b4e11c917ccc107c72446d2575290::hydro_pump::get_reserves<T0>(arg0);
        let v2 = 0xf9a8cc6f3e3d52af2f1372a81ab6097ed95b4e11c917ccc107c72446d2575290::curves::calculate_token_amount_received(v1, v0, arg1 * (10000 - 0xf9a8cc6f3e3d52af2f1372a81ab6097ed95b4e11c917ccc107c72446d2575290::hydro_pump::platform_fee(arg0)) / 10000);
        0x1::option::extract<u64>(&mut v2)
    }

    // decompiled from Move bytecode v6
}

