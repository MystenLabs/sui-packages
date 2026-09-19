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
        abort 1003
    }

    public fun trade_bluefin_spot_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::Vault, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg7 > 0) {
            let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::coin_reserves<T0, T1>(arg2);
            assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2) ^ 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg2) ^ (v0 as u128) ^ (v1 as u128) == arg7, 1000);
        };
        let v2 = if (arg4) {
            4295048016 + 1
        } else {
            79226673515401279992447579055 - 1
        };
        let v3 = if (arg5 == 18446744073709551615) {
            let v4 = if (arg4) {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg3)
            } else {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg3)
            };
            assert!(v4 > 0, 1001);
            v4
        } else {
            arg5
        };
        let (v5, v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg0, arg1, arg2, arg4, true, v3, v2);
        let v8 = v6;
        let v9 = v5;
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = 0x2::balance::value<T1>(&v8);
        if (arg6 > 0) {
            let v12 = if (arg4) {
                v11
            } else {
                v10
            };
            assert!(v12 >= arg6, 1002);
        };
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T0>(arg3, v9);
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T1>(arg3, v8);
        let (v13, v14) = if (arg4) {
            (0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T0>(arg3, v3, arg8), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T1>(arg3, v3, arg8))
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v13, v14, v7);
        let v15 = TradeEvent<T0, T1>{
            a2b             : arg4,
            amount_in       : v3,
            receive_a       : v10,
            receive_b       : v11,
            token_a_type    : 0x1::type_name::with_defining_ids<T0>(),
            token_b_type    : 0x1::type_name::with_defining_ids<T1>(),
            vault_balance_a : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg3),
            vault_balance_b : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg3),
        };
        0x2::event::emit<TradeEvent<T0, T1>>(v15);
    }

    public fun trade_cetus<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::Vault, arg4: bool, arg5: u64, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) {
        abort 1003
    }

    public fun trade_cetus_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::Vault, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg7 > 0) {
            let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg2);
            assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2) ^ 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg2) ^ (0x2::balance::value<T0>(v0) as u128) ^ (0x2::balance::value<T1>(v1) as u128) == arg7, 1000);
        };
        let v2 = if (arg4) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v3 = if (arg5 == 18446744073709551615) {
            let v4 = if (arg4) {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg3)
            } else {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg3)
            };
            assert!(v4 > 0, 1001);
            v4
        } else {
            arg5
        };
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg4, true, v3, v2, arg0);
        let v8 = v6;
        let v9 = v5;
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = 0x2::balance::value<T1>(&v8);
        if (arg6 > 0) {
            let v12 = if (arg4) {
                v11
            } else {
                v10
            };
            assert!(v12 >= arg6, 1002);
        };
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T0>(arg3, v9);
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T1>(arg3, v8);
        let (v13, v14) = if (arg4) {
            (0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T0>(arg3, v3, arg8), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T1>(arg3, v3, arg8))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v13, v14, v7);
        let v15 = TradeEvent<T0, T1>{
            a2b             : arg4,
            amount_in       : v3,
            receive_a       : v10,
            receive_b       : v11,
            token_a_type    : 0x1::type_name::with_defining_ids<T0>(),
            token_b_type    : 0x1::type_name::with_defining_ids<T1>(),
            vault_balance_a : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg3),
            vault_balance_b : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg3),
        };
        0x2::event::emit<TradeEvent<T0, T1>>(v15);
    }

    public fun trade_flowx_v3_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: &mut 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::Vault, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg4);
        if (arg8 > 0) {
            let (v1, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::reserves<T0, T1>(v0);
            assert!(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(v0) ^ 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::liquidity<T0, T1>(v0) ^ (v1 as u128) ^ (v2 as u128) == arg8, 1000);
        };
        let v3 = if (arg5) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v4 = if (arg6 == 18446744073709551615) {
            let v5 = if (arg5) {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg3)
            } else {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg3)
            };
            assert!(v5 > 0, 1001);
            v5
        } else {
            arg6
        };
        let (v6, v7, v8) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, arg5, true, v4, v3, arg2, arg0, arg9);
        let v9 = v7;
        let v10 = v6;
        let v11 = 0x2::balance::value<T0>(&v10);
        let v12 = 0x2::balance::value<T1>(&v9);
        if (arg7 > 0) {
            let v13 = if (arg5) {
                v12
            } else {
                v11
            };
            assert!(v13 >= arg7, 1002);
        };
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T0>(arg3, v10);
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T1>(arg3, v9);
        let (v14, v15) = if (arg5) {
            (0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T0>(arg3, v4, arg9), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T1>(arg3, v4, arg9))
        };
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v8, v14, v15, arg2, arg9);
        let v16 = TradeEvent<T0, T1>{
            a2b             : arg5,
            amount_in       : v4,
            receive_a       : v11,
            receive_b       : v12,
            token_a_type    : 0x1::type_name::with_defining_ids<T0>(),
            token_b_type    : 0x1::type_name::with_defining_ids<T1>(),
            vault_balance_a : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg3),
            vault_balance_b : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg3),
        };
        0x2::event::emit<TradeEvent<T0, T1>>(v16);
    }

    public fun trade_fullsail<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg6: &mut 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::Vault, arg7: bool, arg8: u64, arg9: u128, arg10: &mut 0x2::tx_context::TxContext) {
        abort 1003
    }

    public fun trade_fullsail_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg6: &mut 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::Vault, arg7: bool, arg8: u64, arg9: u64, arg10: u128, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg10 > 0) {
            let (v0, v1) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::balances<T0, T1>(arg5);
            assert!(0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg5) ^ 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::liquidity<T0, T1>(arg5) ^ (v0 as u128) ^ (v1 as u128) == arg10, 1000);
        };
        let v2 = if (arg7) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v3 = if (arg8 == 18446744073709551615) {
            let v4 = if (arg7) {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg6)
            } else {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg6)
            };
            assert!(v4 > 0, 1001);
            v4
        } else {
            arg8
        };
        let (v5, v6, v7) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg1, arg2, arg5, arg7, true, v3, v2, arg3, arg4, arg0);
        let v8 = v6;
        let v9 = v5;
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = 0x2::balance::value<T1>(&v8);
        if (arg9 > 0) {
            let v12 = if (arg7) {
                v11
            } else {
                v10
            };
            assert!(v12 >= arg9, 1002);
        };
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T0>(arg6, v9);
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T1>(arg6, v8);
        let (v13, v14) = if (arg7) {
            (0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T0>(arg6, v3, arg11), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T1>(arg6, v3, arg11))
        };
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg1, arg5, v13, v14, v7);
        let v15 = TradeEvent<T0, T1>{
            a2b             : arg7,
            amount_in       : v3,
            receive_a       : v10,
            receive_b       : v11,
            token_a_type    : 0x1::type_name::with_defining_ids<T0>(),
            token_b_type    : 0x1::type_name::with_defining_ids<T1>(),
            vault_balance_a : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg6),
            vault_balance_b : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg6),
        };
        0x2::event::emit<TradeEvent<T0, T1>>(v15);
    }

    public fun trade_magma_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: &mut 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::Vault, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg7 > 0) {
            let (v0, v1) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::balances<T0, T1>(arg2);
            assert!(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg2) ^ 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg2) ^ (v0 as u128) ^ (v1 as u128) == arg7, 1000);
        };
        let v2 = if (arg4) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v3 = if (arg5 == 18446744073709551615) {
            let v4 = if (arg4) {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg3)
            } else {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg3)
            };
            assert!(v4 > 0, 1001);
            v4
        } else {
            arg5
        };
        let (v5, v6, v7) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg1, arg2, arg4, true, v3, v2, arg0);
        let v8 = v6;
        let v9 = v5;
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = 0x2::balance::value<T1>(&v8);
        if (arg6 > 0) {
            let v12 = if (arg4) {
                v11
            } else {
                v10
            };
            assert!(v12 >= arg6, 1002);
        };
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T0>(arg3, v9);
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T1>(arg3, v8);
        let (v13, v14) = if (arg4) {
            (0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T0>(arg3, v3, arg8), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T1>(arg3, v3, arg8))
        };
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg2, v13, v14, v7);
        let v15 = TradeEvent<T0, T1>{
            a2b             : arg4,
            amount_in       : v3,
            receive_a       : v10,
            receive_b       : v11,
            token_a_type    : 0x1::type_name::with_defining_ids<T0>(),
            token_b_type    : 0x1::type_name::with_defining_ids<T1>(),
            vault_balance_a : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg3),
            vault_balance_b : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg3),
        };
        0x2::event::emit<TradeEvent<T0, T1>>(v15);
    }

    public fun trade_mmt_v3<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &mut 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::Vault, arg4: bool, arg5: u64, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) {
        abort 1003
    }

    public fun trade_mmt_v3_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &mut 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::Vault, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg7 > 0) {
            let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::reserves<T0, T1>(arg2);
            assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg2) ^ 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg2) ^ (v0 as u128) ^ (v1 as u128) == arg7, 1000);
        };
        let v2 = if (arg4) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v3 = if (arg5 == 18446744073709551615) {
            let v4 = if (arg4) {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg3)
            } else {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg3)
            };
            assert!(v4 > 0, 1001);
            v4
        } else {
            arg5
        };
        let (v5, v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, arg4, true, v3, v2, arg0, arg1, arg8);
        let v8 = v6;
        let v9 = v5;
        let v10 = 0x2::balance::value<T0>(&v9);
        let v11 = 0x2::balance::value<T1>(&v8);
        if (arg6 > 0) {
            let v12 = if (arg4) {
                v11
            } else {
                v10
            };
            assert!(v12 >= arg6, 1002);
        };
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T0>(arg3, v9);
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T1>(arg3, v8);
        let (v13, v14) = if (arg4) {
            (0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T0>(arg3, v3, arg8), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T1>(arg3, v3, arg8))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v7, v13, v14, arg1, arg8);
        let v15 = TradeEvent<T0, T1>{
            a2b             : arg4,
            amount_in       : v3,
            receive_a       : v10,
            receive_b       : v11,
            token_a_type    : 0x1::type_name::with_defining_ids<T0>(),
            token_b_type    : 0x1::type_name::with_defining_ids<T1>(),
            vault_balance_a : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg3),
            vault_balance_b : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg3),
        };
        0x2::event::emit<TradeEvent<T0, T1>>(v15);
    }

    public fun trade_turbos_v2<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::Vault, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg7 > 0) {
            let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_balance<T0, T1, T2>(arg2);
            assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg2) ^ 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg2) ^ (v0 as u128) ^ (v1 as u128) == arg7, 1000);
        };
        let v2 = if (arg4) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v3 = if (arg5 == 18446744073709551615) {
            let v4 = if (arg4) {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg3)
            } else {
                0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg3)
            };
            assert!(v4 > 0, 1001);
            v4
        } else {
            arg5
        };
        let (v5, v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg2, 0x2::tx_context::sender(arg8), arg4, (v3 as u128), true, v2, arg0, arg1, arg8);
        let v8 = v7;
        let v9 = 0x2::coin::into_balance<T0>(v5);
        let v10 = 0x2::coin::into_balance<T1>(v6);
        let v11 = 0x2::balance::value<T0>(&v9);
        let v12 = 0x2::balance::value<T1>(&v10);
        if (arg6 > 0) {
            let v13 = if (arg4) {
                v12
            } else {
                v11
            };
            assert!(v13 >= arg6, 1002);
        };
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T0>(arg3, v9);
        0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::deposit_balance<T1>(arg3, v10);
        let (_, _, v16) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v8);
        let (v17, v18) = if (arg4) {
            (0x2::coin::from_balance<T0>(0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T0>(arg3, v16, arg8), arg8), 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg8))
        } else {
            (0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg8), 0x2::coin::from_balance<T1>(0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::take_balance<T1>(arg3, v16, arg8), arg8))
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg2, v17, v18, v8, arg1);
        let v19 = TradeEvent<T0, T1>{
            a2b             : arg4,
            amount_in       : v16,
            receive_a       : v11,
            receive_b       : v12,
            token_a_type    : 0x1::type_name::with_defining_ids<T0>(),
            token_b_type    : 0x1::type_name::with_defining_ids<T1>(),
            vault_balance_a : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T0>(arg3),
            vault_balance_b : 0xaebf1c4d2c4ed9ba9b499e49ad7b31f7579ac50c1be3dacb22d10d1942301f04::vault::balance_of<T1>(arg3),
        };
        0x2::event::emit<TradeEvent<T0, T1>>(v19);
    }

    // decompiled from Move bytecode v7
}

