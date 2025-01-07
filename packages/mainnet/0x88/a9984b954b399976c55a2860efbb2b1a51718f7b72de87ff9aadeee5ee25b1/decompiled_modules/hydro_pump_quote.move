module 0x88a9984b954b399976c55a2860efbb2b1a51718f7b72de87ff9aadeee5ee25b1::hydro_pump_quote {
    public fun get_sui_amount_out<T0>(arg0: &0x88a9984b954b399976c55a2860efbb2b1a51718f7b72de87ff9aadeee5ee25b1::hydro_pump::Config, arg1: u64) : u64 {
        let (v0, v1) = 0x88a9984b954b399976c55a2860efbb2b1a51718f7b72de87ff9aadeee5ee25b1::hydro_pump::get_reserves<T0>(arg0);
        let v2 = 0x88a9984b954b399976c55a2860efbb2b1a51718f7b72de87ff9aadeee5ee25b1::curves::calculate_remove_liquidity_return(v0, v1, arg1);
        0x1::option::extract<u64>(&mut v2) * (10000 - 0x88a9984b954b399976c55a2860efbb2b1a51718f7b72de87ff9aadeee5ee25b1::hydro_pump::platform_fee(arg0)) / 10000
    }

    public fun get_token_amount_out<T0>(arg0: &0x88a9984b954b399976c55a2860efbb2b1a51718f7b72de87ff9aadeee5ee25b1::hydro_pump::Config, arg1: u64) : u64 {
        let (v0, v1) = 0x88a9984b954b399976c55a2860efbb2b1a51718f7b72de87ff9aadeee5ee25b1::hydro_pump::get_reserves<T0>(arg0);
        let v2 = 0x88a9984b954b399976c55a2860efbb2b1a51718f7b72de87ff9aadeee5ee25b1::curves::calculate_token_amount_received(v1, v0, arg1 * (10000 - 0x88a9984b954b399976c55a2860efbb2b1a51718f7b72de87ff9aadeee5ee25b1::hydro_pump::platform_fee(arg0)) / 10000);
        0x1::option::extract<u64>(&mut v2)
    }

    // decompiled from Move bytecode v6
}

