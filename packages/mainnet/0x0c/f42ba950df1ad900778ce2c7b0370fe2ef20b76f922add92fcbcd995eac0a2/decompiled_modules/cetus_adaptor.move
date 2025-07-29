module 0xcf42ba950df1ad900778ce2c7b0370fe2ef20b76f922add92fcbcd995eac0a2::cetus_adaptor {
    public fun calculate_cetus_position_value<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &0xcf42ba950df1ad900778ce2c7b0370fe2ef20b76f922add92fcbcd995eac0a2::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock) : u256 {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_amounts<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1));
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v3 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v4 = 0xcf42ba950df1ad900778ce2c7b0370fe2ef20b76f922add92fcbcd995eac0a2::vault_oracle::get_asset_price(arg2, arg3, v2) * 1000000000000000000 / 0xcf42ba950df1ad900778ce2c7b0370fe2ef20b76f922add92fcbcd995eac0a2::vault_oracle::get_asset_price(arg2, arg3, v3);
        assert!(0x1::u256::diff(sqrt_price_x64_to_price(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), 0xcf42ba950df1ad900778ce2c7b0370fe2ef20b76f922add92fcbcd995eac0a2::vault_oracle::coin_decimals(arg2, v2), 0xcf42ba950df1ad900778ce2c7b0370fe2ef20b76f922add92fcbcd995eac0a2::vault_oracle::coin_decimals(arg2, v3)), v4) * 1000000000000000000 / v4 < 1000000000000000000 * 0xcf42ba950df1ad900778ce2c7b0370fe2ef20b76f922add92fcbcd995eac0a2::vault_oracle::dex_slippage(arg2) / 10000, 6001);
        0xcf42ba950df1ad900778ce2c7b0370fe2ef20b76f922add92fcbcd995eac0a2::vault_utils::mul_with_oracle_price((v0 as u256), 0xcf42ba950df1ad900778ce2c7b0370fe2ef20b76f922add92fcbcd995eac0a2::vault_oracle::get_normalized_asset_price(arg2, arg3, v2)) + 0xcf42ba950df1ad900778ce2c7b0370fe2ef20b76f922add92fcbcd995eac0a2::vault_utils::mul_with_oracle_price((v1 as u256), 0xcf42ba950df1ad900778ce2c7b0370fe2ef20b76f922add92fcbcd995eac0a2::vault_oracle::get_normalized_asset_price(arg2, arg3, v3))
    }

    fun sqrt_price_x64_to_price(arg0: u128, arg1: u8, arg2: u8) : u256 {
        let v0 = (arg0 as u256) * 1000000000000000000 / 0x1::u256::pow(2, 64);
        if (arg1 > arg2) {
            v0 * v0 / 1000000000000000000 * 0x1::u256::pow(10, arg1 - arg2)
        } else {
            v0 * v0 / 1000000000000000000 / 0x1::u256::pow(10, arg2 - arg1)
        }
    }

    public fun update_cetus_position_value<T0, T1, T2>(arg0: &mut 0xcf42ba950df1ad900778ce2c7b0370fe2ef20b76f922add92fcbcd995eac0a2::vault::Vault<T0>, arg1: &0xcf42ba950df1ad900778ce2c7b0370fe2ef20b76f922add92fcbcd995eac0a2::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>) {
        0xcf42ba950df1ad900778ce2c7b0370fe2ef20b76f922add92fcbcd995eac0a2::vault::finish_update_asset_value<T0>(arg0, arg3, calculate_cetus_position_value<T1, T2>(arg4, 0xcf42ba950df1ad900778ce2c7b0370fe2ef20b76f922add92fcbcd995eac0a2::vault::get_defi_asset<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg3), arg1, arg2), 0x2::clock::timestamp_ms(arg2));
    }

    // decompiled from Move bytecode v6
}

