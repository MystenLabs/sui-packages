module 0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::momentum_adaptor {
    public fun get_position_token_amounts<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position) : (u64, u64) {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_amounts_for_liquidity(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(arg1)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(arg1)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(arg1), false)
    }

    public fun get_position_value<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg2: &0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock) : u256 {
        let (v0, v1) = get_position_token_amounts<T0, T1>(arg0, arg1);
        0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault_utils::mul_with_oracle_price((v0 as u256), 0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault_oracle::get_normalized_asset_price(arg2, arg3, 0x1::type_name::into_string(0x1::type_name::get<T0>()))) + 0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault_utils::mul_with_oracle_price((v1 as u256), 0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault_oracle::get_normalized_asset_price(arg2, arg3, 0x1::type_name::into_string(0x1::type_name::get<T1>())))
    }

    public fun update_momentum_position_value<T0, T1, T2>(arg0: &mut 0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault::Vault<T0>, arg1: &0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T2>) {
        0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault::finish_update_asset_value<T0>(arg0, arg3, get_position_value<T1, T2>(arg4, 0x1a377342aa18c9c5f1f09c3c4cc206fab70aa3ab90eacb193488ba0dd0db4d4::vault::get_defi_asset<T0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg0, arg3), arg1, arg2), 0x2::clock::timestamp_ms(arg2));
    }

    // decompiled from Move bytecode v6
}

