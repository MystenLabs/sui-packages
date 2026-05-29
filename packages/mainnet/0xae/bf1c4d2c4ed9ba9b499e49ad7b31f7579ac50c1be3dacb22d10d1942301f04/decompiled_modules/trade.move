module 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::trade {
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

    public fun trade_bluefin_spot<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::Vault, arg4: bool, arg5: u64, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg6 > 0) {
            let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::coin_reserves<T0, T1>(arg2);
            assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2) ^ 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg2) ^ (v0 as u128) ^ (v1 as u128) == arg6, 1000);
        };
        let v2 = if (arg4) {
            4295048016 + 1
        } else {
            79226673515401279992447579055 - 1
        };
        let v3 = if (arg5 == 18446744073709551615) {
            if (arg4) {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg3)
            } else {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg3)
            }
        } else {
            arg5
        };
        let (v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg0, arg1, arg2, arg4, true, v3, v2);
        let v7 = v5;
        let v8 = v4;
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T0>(arg3, v8);
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T1>(arg3, v7);
        let (v9, v10) = if (arg4) {
            (0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T0>(arg3, v3, arg7), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T1>(arg3, v3, arg7))
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v9, v10, v6);
        let v11 = TradeEvent<T0, T1>{
            a2b             : arg4,
            amount_in       : v3,
            receive_a       : 0x2::balance::value<T0>(&v8),
            receive_b       : 0x2::balance::value<T1>(&v7),
            token_a_type    : 0x1::type_name::with_defining_ids<T0>(),
            token_b_type    : 0x1::type_name::with_defining_ids<T1>(),
            vault_balance_a : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg3),
            vault_balance_b : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg3),
        };
        0x2::event::emit<TradeEvent<T0, T1>>(v11);
    }

    public fun trade_cetus<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::Vault, arg4: bool, arg5: u64, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg6 > 0) {
            let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg2);
            assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2) ^ 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg2) ^ (0x2::balance::value<T0>(v0) as u128) ^ (0x2::balance::value<T1>(v1) as u128) == arg6, 1000);
        };
        let v2 = if (arg4) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v3 = if (arg5 == 18446744073709551615) {
            if (arg4) {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg3)
            } else {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg3)
            }
        } else {
            arg5
        };
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg4, true, v3, v2, arg0);
        let v7 = v5;
        let v8 = v4;
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T0>(arg3, v8);
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T1>(arg3, v7);
        let (v9, v10) = if (arg4) {
            (0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T0>(arg3, v3, arg7), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T1>(arg3, v3, arg7))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v9, v10, v6);
        let v11 = TradeEvent<T0, T1>{
            a2b             : arg4,
            amount_in       : v3,
            receive_a       : 0x2::balance::value<T0>(&v8),
            receive_b       : 0x2::balance::value<T1>(&v7),
            token_a_type    : 0x1::type_name::with_defining_ids<T0>(),
            token_b_type    : 0x1::type_name::with_defining_ids<T1>(),
            vault_balance_a : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg3),
            vault_balance_b : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg3),
        };
        0x2::event::emit<TradeEvent<T0, T1>>(v11);
    }

    public fun trade_fullsail<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg6: &mut 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::Vault, arg7: bool, arg8: u64, arg9: u128, arg10: &mut 0x2::tx_context::TxContext) {
        if (arg9 > 0) {
            let (v0, v1) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::balances<T0, T1>(arg5);
            assert!(0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg5) ^ 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::liquidity<T0, T1>(arg5) ^ (v0 as u128) ^ (v1 as u128) == arg9, 1000);
        };
        let v2 = if (arg7) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v3 = if (arg8 == 18446744073709551615) {
            if (arg7) {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg6)
            } else {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg6)
            }
        } else {
            arg8
        };
        let (v4, v5, v6) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg1, arg2, arg5, arg7, true, v3, v2, arg3, arg4, arg0);
        let v7 = v5;
        let v8 = v4;
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T0>(arg6, v8);
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T1>(arg6, v7);
        let (v9, v10) = if (arg7) {
            (0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T0>(arg6, v3, arg10), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T1>(arg6, v3, arg10))
        };
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg1, arg5, v9, v10, v6);
        let v11 = TradeEvent<T0, T1>{
            a2b             : arg7,
            amount_in       : v3,
            receive_a       : 0x2::balance::value<T0>(&v8),
            receive_b       : 0x2::balance::value<T1>(&v7),
            token_a_type    : 0x1::type_name::with_defining_ids<T0>(),
            token_b_type    : 0x1::type_name::with_defining_ids<T1>(),
            vault_balance_a : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg6),
            vault_balance_b : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg6),
        };
        0x2::event::emit<TradeEvent<T0, T1>>(v11);
    }

    public fun trade_mmt_v3<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &mut 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::Vault, arg4: bool, arg5: u64, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg6 > 0) {
            let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::reserves<T0, T1>(arg2);
            assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg2) ^ 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg2) ^ (v0 as u128) ^ (v1 as u128) == arg6, 1000);
        };
        let v2 = if (arg4) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v3 = if (arg5 == 18446744073709551615) {
            if (arg4) {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg3)
            } else {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg3)
            }
        } else {
            arg5
        };
        let (v4, v5, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, arg4, true, v3, v2, arg0, arg1, arg7);
        let v7 = v5;
        let v8 = v4;
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T0>(arg3, v8);
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T1>(arg3, v7);
        let (v9, v10) = if (arg4) {
            (0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T0>(arg3, v3, arg7), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T1>(arg3, v3, arg7))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v6, v9, v10, arg1, arg7);
        let v11 = TradeEvent<T0, T1>{
            a2b             : arg4,
            amount_in       : v3,
            receive_a       : 0x2::balance::value<T0>(&v8),
            receive_b       : 0x2::balance::value<T1>(&v7),
            token_a_type    : 0x1::type_name::with_defining_ids<T0>(),
            token_b_type    : 0x1::type_name::with_defining_ids<T1>(),
            vault_balance_a : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg3),
            vault_balance_b : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg3),
        };
        0x2::event::emit<TradeEvent<T0, T1>>(v11);
    }

    // decompiled from Move bytecode v7
}

