module 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_calcs {
    public(friend) fun calc_rewards_rate(arg0: u64, arg1: u128, arg2: u64, arg3: u64) : u64 {
        let v0 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div((arg0 as u256), (arg1 as u256), (arg2 as u256));
        if (v0 > (arg3 as u256)) {
            arg3
        } else {
            (v0 as u64)
        }
    }

    public fun liquidity_return(arg0: u64, arg1: u64) : u128 {
        assert!(arg1 >= arg0, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::f_token_liquidity_exchange_price_unexpected());
        0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128(((arg1 - arg0) as u128), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::constants::return_percent_precision(), (arg0 as u128))
    }

    public fun rewards_return(arg0: u64, arg1: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::DurationS) : u128 {
        if (0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::is_zero(arg1)) {
            return 0
        };
        0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128((arg0 as u128), (0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::raw(arg1) as u128), (0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::constants::seconds_per_year() as u128))
    }

    public fun to_assets(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_ceil_u64(arg0, arg1, (0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::constants::exchange_prices_precision() as u64))
        } else {
            0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u64(arg0, arg1, (0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::constants::exchange_prices_precision() as u64))
        }
    }

    public fun to_shares(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_ceil_u64(arg0, (0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::constants::exchange_prices_precision() as u64), arg1)
        } else {
            0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u64(arg0, (0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::constants::exchange_prices_precision() as u64), arg1)
        }
    }

    // decompiled from Move bytecode v7
}

