module 0x1c32d46360d0a2be9dc54adc9cb0b90f5b5e5cdfcfad478cc6526f63fca1528f::scallop_adapter {
    struct ScallopWitness<phantom T0> has drop {
        dummy_field: bool,
    }

    struct ScallopAdapter<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        coin_in: u64,
        balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>,
    }

    public fun new<T0, T1, T2>(arg0: &0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::acl::AdminWitness<0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::sam::SAM>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopAdapter<T0, T1, T2>{
            id      : 0x2::object::new(arg1),
            coin_in : 0,
            balance : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(),
        };
        0x2::transfer::public_share_object<ScallopAdapter<T0, T1, T2>>(v0);
    }

    public fun allocate_to_protocol<T0, T1, T2>(arg0: &mut ScallopAdapter<T0, T1, T2>, arg1: &mut 0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::state::SAMState<T1, T2>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: 0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::rbr::RebalanceRequest<T1>, arg5: &0x2::clock::Clock, arg6: &0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopWitness<T2>{dummy_field: false};
        let v1 = 0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::state::allocate_to_protocol<T1, T2, ScallopWitness<T2>>(arg1, arg4, v0, arg6, arg7);
        arg0.coin_in = arg0.coin_in + 0x2::balance::value<T1>(&v1);
        0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg0.balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T1>(arg3, arg2, 0x2::coin::from_balance<T1>(v1, arg7), arg5, arg7)));
    }

    public fun approve_protocol_request<T0, T1, T2>(arg0: &mut ScallopAdapter<T0, T1, T2>, arg1: &mut 0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::state::SAMState<T1, T2>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::ptr::ProtocolRequest<T1>, arg5: &0x2::clock::Clock, arg6: &0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg2)), 0x1::type_name::get<T1>()));
        let v4 = ScallopWitness<T2>{dummy_field: false};
        0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::state::approve_protocol_request<T1, T2, ScallopWitness<T2>>(arg1, arg4, get_available_liquidity<T0, T1, T2>(arg0, arg2), get_apr<T1>(arg2), 0x2::coin::into_balance<T1>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T1>(arg3, arg2, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg0.balance, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(arg0.coin_in - 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.balance), v0 + v1 - v2, v3), v3, v0 + v1 - v2)), arg7), arg5, arg7)), v4, arg6, arg7);
    }

    public fun get_apr<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18 {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::util_rate(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg0), 0x1::type_name::get<T0>());
        let (v1, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::calc_interest(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::interest_model(arg0, 0x1::type_name::get<T0>()), v0);
        0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::mul_down(to_fixed18(v1), 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::mul_down(to_fixed18(v0), 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::sub(0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::from_u64(100), to_fixed18(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::revenue_factor(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::interest_model(arg0, 0x1::type_name::get<T0>()))))))
    }

    public fun get_apr_u64<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : u64 {
        0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::to_u64(get_apr<T0>(arg0), 9)
    }

    public fun get_available_liquidity<T0, T1, T2>(arg0: &ScallopAdapter<T0, T1, T2>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18 {
        let (v0, v1, v2, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg1)), 0x1::type_name::get<T1>()));
        let v4 = v0 + v1 - v2;
        let v5 = if (v4 < arg0.coin_in) {
            v4
        } else {
            arg0.coin_in
        };
        0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::from_u64(v5)
    }

    fun to_fixed18(arg0: 0x1::fixed_point32::FixedPoint32) : 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18 {
        0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::from_raw_u256((0x1::uq32_32::to_raw(0x1::uq32_32::from_raw(0x1::fixed_point32::get_raw_value(arg0))) as u256) * 1000000000000000000 >> 32)
    }

    public fun withdraw_rbr<T0, T1, T2>(arg0: &mut ScallopAdapter<T0, T1, T2>, arg1: &mut 0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::state::SAMState<T1, T2>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::rbr::RebalanceRequest<T1>, arg5: &0x2::clock::Clock, arg6: &0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::rbr::amount<T1>(arg4);
        arg0.coin_in = arg0.coin_in - v0;
        let (v1, v2, v3, v4) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg2)), 0x1::type_name::get<T1>()));
        let v5 = ScallopWitness<T2>{dummy_field: false};
        0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::state::fill_rebalance_request<T1, T2, ScallopWitness<T2>>(arg1, arg4, 0x2::coin::into_balance<T1>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T1>(arg3, arg2, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg0.balance, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(v0, v4, v1 + v2 - v3)), arg7), arg5, arg7)), v5, arg6, arg7);
    }

    public fun withdraw_wdr<T0, T1, T2>(arg0: &mut ScallopAdapter<T0, T1, T2>, arg1: &mut 0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::state::SAMState<T1, T2>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::wdr::WithdrawRequest<T1>, arg5: &0x2::clock::Clock, arg6: &0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::wdr::get_coin_amount<T1>(arg4);
        arg0.coin_in = arg0.coin_in - v0;
        let (v1, v2, v3, v4) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg2)), 0x1::type_name::get<T1>()));
        let v5 = ScallopWitness<T2>{dummy_field: false};
        0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::state::fill_withdraw_request<T1, T2, ScallopWitness<T2>>(arg1, arg4, 0x2::coin::into_balance<T1>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T1>(arg3, arg2, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg0.balance, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(v0, v4, v1 + v2 - v3)), arg7), arg5, arg7)), v5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

