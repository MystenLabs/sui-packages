module 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::exchange_price {
    public fun load_exchange_prices(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::RateMagnifier, arg8: 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::RateMagnifier) : (u128, u128) {
        assert!(arg4 >= arg2 && arg5 >= arg3, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::errors::vault_liquidity_exchange_price_unexpected());
        let v0 = 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::exchange_price_scale_factor();
        let v1 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128(arg0, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128(arg4, v0, arg2), v0);
        let v2 = v1;
        if (!0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::magnifier_is_zero(&arg7)) {
            let v3 = if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::magnifier_is_negative(&arg7)) {
                v1 - rate_change(arg0, arg6, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::magnifier_magnitude(&arg7))
            } else {
                v1 + rate_change(arg0, arg6, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::magnifier_magnitude(&arg7))
            };
            v2 = v3;
        };
        let v4 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_ceil_u128(arg1, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128(arg5, v0, arg3), v0);
        let v5 = v4;
        if (!0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::magnifier_is_zero(&arg8)) {
            let v6 = if (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::magnifier_is_negative(&arg8)) {
                v4 - rate_change(arg1, arg6, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::magnifier_magnitude(&arg8))
            } else {
                v4 + rate_change(arg1, arg6, 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::structs::magnifier_magnitude(&arg8))
            };
            v5 = v6;
        };
        (v2, v5)
    }

    fun rate_change(arg0: u128, arg1: u128, arg2: u16) : u128 {
        (((arg0 as u256) * (arg1 as u256) * (arg2 as u256) / (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::four_decimals() as u256) / (0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::constants::seconds_per_year() as u256)) as u128)
    }

    // decompiled from Move bytecode v7
}

