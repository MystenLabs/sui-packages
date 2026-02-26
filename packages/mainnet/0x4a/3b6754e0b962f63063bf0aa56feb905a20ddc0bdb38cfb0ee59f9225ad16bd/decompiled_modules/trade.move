module 0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::trade {
    struct TradeEvent<phantom T0, phantom T1> has copy, drop {
        a2b: bool,
        amount_in: u64,
        receive_a: u64,
        receive_b: u64,
        token_a_type: 0x1::type_name::TypeName,
        token_b_type: 0x1::type_name::TypeName,
        vault_balance_a: u64,
        vault_balance_b: u64,
    }

    public fun trade_cetus<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault::Vault, arg4: bool, arg5: u64, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg2);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2) ^ (0x2::balance::value<T0>(v0) as u128) ^ (0x2::balance::value<T1>(v1) as u128) == arg6, 1000);
        let v2 = if (arg4) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v3 = if (arg5 == 18446744073709551615) {
            if (arg4) {
                0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault::balance_of<T0>(arg3)
            } else {
                0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault::balance_of<T1>(arg3)
            }
        } else {
            arg5
        };
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg4, true, v3, v2, arg0);
        let v7 = v5;
        let v8 = v4;
        0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault::deposit_balance<T0>(arg3, v8);
        0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault::deposit_balance<T1>(arg3, v7);
        let (v9, v10) = if (arg4) {
            (0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault::take_balance<T0>(arg3, v3, arg7), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault::take_balance<T1>(arg3, v3, arg7))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v9, v10, v6);
        let v11 = TradeEvent<T0, T1>{
            a2b             : arg4,
            amount_in       : v3,
            receive_a       : 0x2::balance::value<T0>(&v8),
            receive_b       : 0x2::balance::value<T1>(&v7),
            token_a_type    : 0x1::type_name::with_defining_ids<T0>(),
            token_b_type    : 0x1::type_name::with_defining_ids<T1>(),
            vault_balance_a : 0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault::balance_of<T0>(arg3),
            vault_balance_b : 0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault::balance_of<T1>(arg3),
        };
        0x2::event::emit<TradeEvent<T0, T1>>(v11);
    }

    public fun trade_mmt_v3<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &mut 0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault::Vault, arg4: bool, arg5: u64, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::reserves<T0, T1>(arg2);
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg2) ^ (v0 as u128) ^ (v1 as u128) == arg6, 1000);
        let v2 = if (arg4) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v3 = if (arg5 == 18446744073709551615) {
            if (arg4) {
                0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault::balance_of<T0>(arg3)
            } else {
                0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault::balance_of<T1>(arg3)
            }
        } else {
            arg5
        };
        let (v4, v5, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, arg4, true, v3, v2, arg0, arg1, arg7);
        let v7 = v5;
        let v8 = v4;
        0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault::deposit_balance<T0>(arg3, v8);
        0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault::deposit_balance<T1>(arg3, v7);
        let (v9, v10) = if (arg4) {
            (0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault::take_balance<T0>(arg3, v3, arg7), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault::take_balance<T1>(arg3, v3, arg7))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v6, v9, v10, arg1, arg7);
        let v11 = TradeEvent<T0, T1>{
            a2b             : arg4,
            amount_in       : v3,
            receive_a       : 0x2::balance::value<T0>(&v8),
            receive_b       : 0x2::balance::value<T1>(&v7),
            token_a_type    : 0x1::type_name::with_defining_ids<T0>(),
            token_b_type    : 0x1::type_name::with_defining_ids<T1>(),
            vault_balance_a : 0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault::balance_of<T0>(arg3),
            vault_balance_b : 0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault::balance_of<T1>(arg3),
        };
        0x2::event::emit<TradeEvent<T0, T1>>(v11);
    }

    // decompiled from Move bytecode v6
}

