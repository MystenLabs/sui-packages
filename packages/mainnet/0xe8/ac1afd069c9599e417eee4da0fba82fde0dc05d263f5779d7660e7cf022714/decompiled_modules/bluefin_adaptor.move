module 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::bluefin_adaptor {
    public fun get_position_token_amounts<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg2: u128) : (u64, u64) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), arg2, false)
    }

    public fun get_position_value<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg2: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock) : u256 {
        let (v0, v1) = get_position_token_amounts<T0, T1>(arg0, arg1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(arg1));
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::mul_with_oracle_price((v0 as u256), 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::get_asset_price(arg2, arg3, 0x1::type_name::into_string(0x1::type_name::get<T0>()))) + 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::mul_with_oracle_price((v1 as u256), 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::get_asset_price(arg2, arg3, 0x1::type_name::into_string(0x1::type_name::get<T1>())))
    }

    // decompiled from Move bytecode v6
}

