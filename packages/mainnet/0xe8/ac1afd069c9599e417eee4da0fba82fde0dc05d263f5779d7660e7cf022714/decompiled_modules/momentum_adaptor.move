module 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::momentum_adaptor {
    public fun get_position_token_amounts<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position) : (u64, u64) {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_amounts_for_liquidity(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(arg1)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(arg1)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(arg1), false)
    }

    public fun get_position_value<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg2: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock) : u256 {
        let (v0, v1) = get_position_token_amounts<T0, T1>(arg0, arg1);
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::mul_with_oracle_price((v0 as u256), 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::get_asset_price(arg2, arg3, 0x1::type_name::into_string(0x1::type_name::get<T0>()))) + 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::mul_with_oracle_price((v1 as u256), 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::get_asset_price(arg2, arg3, 0x1::type_name::into_string(0x1::type_name::get<T1>())))
    }

    // decompiled from Move bytecode v6
}

