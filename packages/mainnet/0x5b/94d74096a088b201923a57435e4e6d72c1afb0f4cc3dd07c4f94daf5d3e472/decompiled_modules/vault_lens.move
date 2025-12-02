module 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens {
    struct CalculateNetVaultValueEvent has copy, drop {
        vault_id: 0x2::object::ID,
        token_a: 0x1::ascii::String,
        token_a_amount: u128,
        token_b: 0x1::ascii::String,
        token_b_amount: u128,
        vault_tokens: vector<0x1::ascii::String>,
        vault_token_amounts: vector<u128>,
        withdraw_tokens: vector<0x1::ascii::String>,
        withdraw_token_amounts: vector<u128>,
        tokens: vector<0x1::ascii::String>,
        token_decimals: vector<u64>,
        prices: vector<u64>,
        liquidity: u128,
        pending_redemptions: u128,
        final_liquidity: u128,
    }

    public fun calculate_net_value_vault_bluefin<T0, T1, T2, T3>(arg0: &0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg2: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: vector<0x1::ascii::String>, arg4: vector<u64>, arg5: vector<u64>) : u128 {
        let (v0, v1) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_vault_asset_balances<T0, T1>(arg2);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_withdraw_asset_balances<T0, T1>(arg2);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_pending_redemptions<T0, T1>(arg2);
        let (v9, v10, _) = 0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::get_exactly_token_amount_from_positions<T2, T3>(arg0, arg1, 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg2));
        let v12 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v13 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        let v14 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>());
        let v15 = if (v13 == v12) {
            v9
        } else {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::get_token_out_amount(v13, v12, arg3, arg4, arg5, (v9 as u64))
        };
        let v16 = if (v14 == v12) {
            v10
        } else {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::get_token_out_amount(v14, v12, arg3, arg4, arg5, (v10 as u64))
        };
        let v17 = 0 + v15 + v16;
        let v18 = 0;
        while (v18 < 0x1::vector::length<0x1::ascii::String>(&v3)) {
            let v19 = 0x1::vector::borrow<0x1::ascii::String>(&v3, v18);
            let v20 = if (*v19 == v12) {
                *0x1::vector::borrow<u128>(&v2, v18)
            } else {
                0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::get_token_out_amount(*v19, v12, arg3, arg4, arg5, (*0x1::vector::borrow<u128>(&v2, v18) as u64))
            };
            v17 = v17 + v20;
            v18 = v18 + 1;
        };
        let v21 = 0;
        while (v21 < 0x1::vector::length<0x1::ascii::String>(&v7)) {
            let v22 = 0x1::vector::borrow<0x1::ascii::String>(&v7, v21);
            let v23 = if (*v22 == v12) {
                *0x1::vector::borrow<u128>(&v6, v21)
            } else {
                0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::get_token_out_amount(*v22, v12, arg3, arg4, arg5, (*0x1::vector::borrow<u128>(&v6, v21) as u64))
            };
            v17 = v17 + v23;
            v21 = v21 + 1;
        };
        let v24 = if (v17 > v8) {
            v17 - v8
        } else {
            0
        };
        let v25 = CalculateNetVaultValueEvent{
            vault_id               : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg2),
            token_a                : v13,
            token_a_amount         : v9,
            token_b                : v14,
            token_b_amount         : v10,
            vault_tokens           : v3,
            vault_token_amounts    : v2,
            withdraw_tokens        : v7,
            withdraw_token_amounts : v6,
            tokens                 : arg3,
            token_decimals         : arg4,
            prices                 : arg5,
            liquidity              : v17,
            pending_redemptions    : v8,
            final_liquidity        : v24,
        };
        0x2::event::emit<CalculateNetVaultValueEvent>(v25);
        v24
    }

    public fun calculate_net_value_vault_cetus<T0, T1, T2, T3>(arg0: &0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: vector<0x1::ascii::String>, arg4: vector<u64>, arg5: vector<u64>) : u128 {
        let (v0, v1) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_vault_asset_balances<T0, T1>(arg2);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_withdraw_asset_balances<T0, T1>(arg2);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_pending_redemptions<T0, T1>(arg2);
        let (v9, v10, _) = 0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::get_exactly_token_amount_from_positions<T2, T3>(arg0, arg1, 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg2));
        let v12 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v13 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        let v14 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>());
        let v15 = if (v13 == v12) {
            v9
        } else {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::get_token_out_amount(v13, v12, arg3, arg4, arg5, (v9 as u64))
        };
        let v16 = if (v14 == v12) {
            v10
        } else {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::get_token_out_amount(v14, v12, arg3, arg4, arg5, (v10 as u64))
        };
        let v17 = 0 + v15 + v16;
        let v18 = 0;
        while (v18 < 0x1::vector::length<0x1::ascii::String>(&v3)) {
            let v19 = 0x1::vector::borrow<0x1::ascii::String>(&v3, v18);
            let v20 = if (*v19 == v12) {
                *0x1::vector::borrow<u128>(&v2, v18)
            } else {
                0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::get_token_out_amount(*v19, v12, arg3, arg4, arg5, (*0x1::vector::borrow<u128>(&v2, v18) as u64))
            };
            v17 = v17 + v20;
            v18 = v18 + 1;
        };
        let v21 = 0;
        while (v21 < 0x1::vector::length<0x1::ascii::String>(&v7)) {
            let v22 = 0x1::vector::borrow<0x1::ascii::String>(&v7, v21);
            let v23 = if (*v22 == v12) {
                *0x1::vector::borrow<u128>(&v6, v21)
            } else {
                0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::get_token_out_amount(*v22, v12, arg3, arg4, arg5, (*0x1::vector::borrow<u128>(&v6, v21) as u64))
            };
            v17 = v17 + v23;
            v21 = v21 + 1;
        };
        let v24 = if (v17 > v8) {
            v17 - v8
        } else {
            0
        };
        let v25 = CalculateNetVaultValueEvent{
            vault_id               : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg2),
            token_a                : v13,
            token_a_amount         : v9,
            token_b                : v14,
            token_b_amount         : v10,
            vault_tokens           : v3,
            vault_token_amounts    : v2,
            withdraw_tokens        : v7,
            withdraw_token_amounts : v6,
            tokens                 : arg3,
            token_decimals         : arg4,
            prices                 : arg5,
            liquidity              : v17,
            pending_redemptions    : v8,
            final_liquidity        : v24,
        };
        0x2::event::emit<CalculateNetVaultValueEvent>(v25);
        v24
    }

    public fun calculate_net_value_vault_mmt<T0, T1, T2, T3>(arg0: &0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: vector<0x1::ascii::String>, arg4: vector<u64>, arg5: vector<u64>) : u128 {
        let (v0, v1) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_vault_asset_balances<T0, T1>(arg2);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_withdraw_asset_balances<T0, T1>(arg2);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_pending_redemptions<T0, T1>(arg2);
        let (v9, v10, _) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::get_exactly_token_amount_from_positions<T2, T3>(arg0, arg1, 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg2));
        let v12 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v13 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        let v14 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>());
        let v15 = if (v13 == v12) {
            v9
        } else {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::get_token_out_amount(v13, v12, arg3, arg4, arg5, (v9 as u64))
        };
        let v16 = if (v14 == v12) {
            v10
        } else {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::get_token_out_amount(v14, v12, arg3, arg4, arg5, (v10 as u64))
        };
        let v17 = 0 + v15 + v16;
        let v18 = 0;
        while (v18 < 0x1::vector::length<0x1::ascii::String>(&v3)) {
            let v19 = 0x1::vector::borrow<0x1::ascii::String>(&v3, v18);
            let v20 = if (*v19 == v12) {
                *0x1::vector::borrow<u128>(&v2, v18)
            } else {
                0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::get_token_out_amount(*v19, v12, arg3, arg4, arg5, (*0x1::vector::borrow<u128>(&v2, v18) as u64))
            };
            v17 = v17 + v20;
            v18 = v18 + 1;
        };
        let v21 = 0;
        while (v21 < 0x1::vector::length<0x1::ascii::String>(&v7)) {
            let v22 = 0x1::vector::borrow<0x1::ascii::String>(&v7, v21);
            let v23 = if (*v22 == v12) {
                *0x1::vector::borrow<u128>(&v6, v21)
            } else {
                0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::get_token_out_amount(*v22, v12, arg3, arg4, arg5, (*0x1::vector::borrow<u128>(&v6, v21) as u64))
            };
            v17 = v17 + v23;
            v21 = v21 + 1;
        };
        let v24 = if (v17 > v8) {
            v17 - v8
        } else {
            0
        };
        let v25 = CalculateNetVaultValueEvent{
            vault_id               : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg2),
            token_a                : v13,
            token_a_amount         : v9,
            token_b                : v14,
            token_b_amount         : v10,
            vault_tokens           : v3,
            vault_token_amounts    : v2,
            withdraw_tokens        : v7,
            withdraw_token_amounts : v6,
            tokens                 : arg3,
            token_decimals         : arg4,
            prices                 : arg5,
            liquidity              : v17,
            pending_redemptions    : v8,
            final_liquidity        : v24,
        };
        0x2::event::emit<CalculateNetVaultValueEvent>(v25);
        v24
    }

    public fun get_bluefin_position_liquidities(arg0: &0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_bluefin_vault_position_liquidities(arg0: &0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>) {
        0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::get_vault_position_liquidities(arg0, arg1)
    }

    public fun get_bluefin_vault_position_value(arg0: &0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>) {
        0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::get_vault_position_value(arg0, arg1)
    }

    public fun get_cetus_position_liquidities(arg0: &0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_cetus_vault_position_liquidities(arg0: &0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>) {
        0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::get_vault_position_liquidities(arg0, arg1)
    }

    public fun get_cetus_vault_position_value(arg0: &0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>) {
        0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::get_vault_position_value(arg0, arg1)
    }

    public fun get_last_credit_profit<T0, T1>(arg0: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>) : (u64, u64, bool, u64) {
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_last_credit_profit<T0, T1>(arg0)
    }

    public fun get_mmt_position_liquidities(arg0: &0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_mmt_vault_position_liquidities(arg0: &0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>) {
        0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::get_vault_position_liquidities(arg0, arg1)
    }

    public fun get_mmt_vault_position_value(arg0: &0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>) {
        0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::get_vault_position_value(arg0, arg1)
    }

    public fun get_vault_asset_balances<T0, T1>(arg0: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>) : (vector<0x1::ascii::String>, vector<u128>) {
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_vault_asset_balances<T0, T1>(arg0)
    }

    public fun get_vault_info_bluefin<T0, T1>(arg0: &0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig, arg1: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>, vector<0x1::ascii::String>, vector<u128>, vector<0x1::ascii::String>, vector<u128>) {
        let (v0, v1, v2, v3) = 0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::get_vault_position_value(arg0, 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg1));
        let (v4, v5) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_vault_asset_balances<T0, T1>(arg1);
        let (v6, v7) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_withdraw_asset_balances<T0, T1>(arg1);
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public fun get_vault_info_cetus<T0, T1>(arg0: &0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig, arg1: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>, vector<0x1::ascii::String>, vector<u128>, vector<0x1::ascii::String>, vector<u128>) {
        let (v0, v1, v2, v3) = 0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::get_vault_position_value(arg0, 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg1));
        let (v4, v5) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_vault_asset_balances<T0, T1>(arg1);
        let (v6, v7) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_withdraw_asset_balances<T0, T1>(arg1);
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public fun get_vault_info_mmt<T0, T1>(arg0: &0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>, vector<0x1::ascii::String>, vector<u128>, vector<0x1::ascii::String>, vector<u128>) {
        let (v0, v1, v2, v3) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::get_vault_position_value(arg0, 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg1));
        let (v4, v5) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_vault_asset_balances<T0, T1>(arg1);
        let (v6, v7) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_withdraw_asset_balances<T0, T1>(arg1);
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public fun get_withdraw_asset_balances<T0, T1>(arg0: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>) : (vector<0x1::ascii::String>, vector<u128>) {
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_withdraw_asset_balances<T0, T1>(arg0)
    }

    // decompiled from Move bytecode v6
}

