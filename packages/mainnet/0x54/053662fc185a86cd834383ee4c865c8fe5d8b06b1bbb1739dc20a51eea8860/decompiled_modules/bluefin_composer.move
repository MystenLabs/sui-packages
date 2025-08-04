module 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_composer {
    struct SwapRecordEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        direction: bool,
        key_storage: vector<u8>,
        input_amount: u64,
        swap_input_amount: u64,
        swap_output_amount: u64,
        amount_in_vault: u64,
    }

    struct SwapFromRecordEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        direction: bool,
        key_storage: vector<u8>,
        restore: bool,
        amount_in_vault_before: u64,
        swap_input_amount: u64,
        swap_output_amount: u64,
        amount_in_vault_after: u64,
    }

    struct AddLiquidityRecordEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        key_storage: vector<u8>,
        amount_in_vault: u64,
        liquidity: u128,
        amount_a: u64,
        amount_b: u64,
        amount_a_fixed: u64,
        amount_b_fixed: u64,
    }

    public entry fun add_liquidity_from_record<T0, T1, T2, T3>(arg0: &mut 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u32, arg6: u32, arg7: u128, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1, v2, v3, v4, v5) = get_coin_amount_for_add_liquidity<T2, T3, T0, T1>(arg2, arg3, arg5, arg6, arg7, arg8, arg9);
        let (_, _) = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::exec_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, (v3 as u64), (v4 as u64), arg10, arg11);
        0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::borrow_access_cap(arg0, arg11)), arg3, arg8);
        let v8 = AddLiquidityRecordEvent<T2, T3>{
            vault_id        : 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3),
            pool_id         : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2),
            tick_lower      : arg5,
            tick_upper      : arg6,
            key_storage     : arg8,
            amount_in_vault : v5,
            liquidity       : v0,
            amount_a        : (v1 as u64),
            amount_b        : (v2 as u64),
            amount_a_fixed  : (v3 as u64),
            amount_b_fixed  : (v4 as u64),
        };
        0x2::event::emit<AddLiquidityRecordEvent<T2, T3>>(v8);
    }

    public entry fun add_liquidity_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u32, arg6: u32, arg7: u128, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1, v2, v3, v4, v5) = get_coin_amount_for_add_liquidity<T0, T2, T0, T1>(arg2, arg3, arg5, arg6, arg7, arg8, arg9);
        let (_, _) = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, (v3 as u64), (v4 as u64), arg10, arg11);
        0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::borrow_access_cap(arg0, arg11)), arg3, arg8);
        let v8 = AddLiquidityRecordEvent<T0, T2>{
            vault_id        : 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3),
            pool_id         : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg2),
            tick_lower      : arg5,
            tick_upper      : arg6,
            key_storage     : arg8,
            amount_in_vault : v5,
            liquidity       : v0,
            amount_a        : (v1 as u64),
            amount_b        : (v2 as u64),
            amount_a_fixed  : (v3 as u64),
            amount_b_fixed  : (v4 as u64),
        };
        0x2::event::emit<AddLiquidityRecordEvent<T0, T2>>(v8);
    }

    public entry fun add_liquidity_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u32, arg6: u32, arg7: u128, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1, v2, v3, v4, v5) = get_coin_amount_for_add_liquidity<T2, T0, T0, T1>(arg2, arg3, arg5, arg6, arg7, arg8, arg9);
        let (_, _) = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, (v3 as u64), (v4 as u64), arg10, arg11);
        let v8 = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::borrow_access_cap(arg0, arg11);
        0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(v8), arg3, arg8);
        0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(v8), arg3, arg8);
        let v9 = AddLiquidityRecordEvent<T2, T0>{
            vault_id        : 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3),
            pool_id         : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>>(arg2),
            tick_lower      : arg5,
            tick_upper      : arg6,
            key_storage     : arg8,
            amount_in_vault : v5,
            liquidity       : v0,
            amount_a        : (v1 as u64),
            amount_b        : (v2 as u64),
            amount_a_fixed  : (v3 as u64),
            amount_b_fixed  : (v4 as u64),
        };
        0x2::event::emit<AddLiquidityRecordEvent<T2, T0>>(v9);
    }

    fun get_coin_amount_for_add_liquidity<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T2, T3>, arg2: u32, arg3: u32, arg4: u128, arg5: vector<u8>, arg6: bool) : (u128, u128, u128, u128, u128, u64) {
        let v0 = 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::get_dynamic_field<T2, T3, u64>(arg1, arg5);
        let (v1, v2, v3) = 0x5135c6e7fa45663b6cd70478d1a40e3d4b328978080445e55deddeedb4247760::liquidity_math::estimate_token(arg2, arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), 0x5135c6e7fa45663b6cd70478d1a40e3d4b328978080445e55deddeedb4247760::liquidity_math::adjust_for_slippage((v0 as u128), arg4, 10000, false), arg6);
        (v1, v2, v3, v2, 0x5135c6e7fa45663b6cd70478d1a40e3d4b328978080445e55deddeedb4247760::liquidity_math::adjust_for_slippage(v3, arg4 / 2, 10000, true), v0)
    }

    public entry fun swap_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg11, arg12);
        let v2 = arg7 && false || true;
        let (_, v4, v5) = 0x5135c6e7fa45663b6cd70478d1a40e3d4b328978080445e55deddeedb4247760::liquidity_math::estimate_token(arg8, arg9, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T2, T3>(arg2), 0x5135c6e7fa45663b6cd70478d1a40e3d4b328978080445e55deddeedb4247760::liquidity_math::adjust_for_slippage((v1 as u128), arg10, 10000, false), v2);
        let (_, _) = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::exec_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, (v4 as u64), (0x5135c6e7fa45663b6cd70478d1a40e3d4b328978080445e55deddeedb4247760::liquidity_math::adjust_for_slippage(v5, arg10 / 2, 10000, true) as u64), arg11, arg12);
    }

    public entry fun swap_from_record<T0, T1, T2, T3>(arg0: &mut 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let v0 = 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        let (v1, v2) = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg9, arg10);
        let v3 = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::borrow_access_cap(arg0, arg10);
        0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(v3), arg3, arg7);
        let v4 = 0;
        if (arg8) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(v3), arg3, arg7, (v2 as u64));
            v4 = 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        };
        let v5 = SwapFromRecordEvent<T2, T3>{
            vault_id               : 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3),
            pool_id                : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2),
            direction              : arg6,
            key_storage            : arg7,
            restore                : arg8,
            amount_in_vault_before : v0,
            swap_input_amount      : v1,
            swap_output_amount     : v2,
            amount_in_vault_after  : v4,
        };
        0x2::event::emit<SwapFromRecordEvent<T2, T3>>(v5);
    }

    public entry fun swap_have_coin_a_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg11, arg12);
        let v2 = arg7 && false || true;
        let (_, v4, v5) = 0x5135c6e7fa45663b6cd70478d1a40e3d4b328978080445e55deddeedb4247760::liquidity_math::estimate_token(arg8, arg9, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T2>(arg2), 0x5135c6e7fa45663b6cd70478d1a40e3d4b328978080445e55deddeedb4247760::liquidity_math::adjust_for_slippage((v1 as u128), arg10, 10000, false), v2);
        let (_, _) = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, (v4 as u64), (0x5135c6e7fa45663b6cd70478d1a40e3d4b328978080445e55deddeedb4247760::liquidity_math::adjust_for_slippage(v5, arg10 / 2, 10000, true) as u64), arg11, arg12);
    }

    public entry fun swap_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let v0 = 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        let (v1, v2) = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg9, arg10);
        let v3 = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::borrow_access_cap(arg0, arg10);
        0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(v3), arg3, arg7);
        let v4 = 0;
        if (arg8) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(v3), arg3, arg7, (v2 as u64));
            v4 = 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        };
        let v5 = SwapFromRecordEvent<T0, T2>{
            vault_id               : 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3),
            pool_id                : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg2),
            direction              : arg6,
            key_storage            : arg7,
            restore                : arg8,
            amount_in_vault_before : v0,
            swap_input_amount      : v1,
            swap_output_amount     : v2,
            amount_in_vault_after  : v4,
        };
        0x2::event::emit<SwapFromRecordEvent<T0, T2>>(v5);
    }

    public entry fun swap_have_coin_b_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg11, arg12);
        let v2 = arg7 && false || true;
        let (_, v4, v5) = 0x5135c6e7fa45663b6cd70478d1a40e3d4b328978080445e55deddeedb4247760::liquidity_math::estimate_token(arg8, arg9, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T2, T0>(arg2), (0x5135c6e7fa45663b6cd70478d1a40e3d4b328978080445e55deddeedb4247760::liquidity_math::adjust_for_slippage((v1 as u128), arg10, 10000, false) as u128), v2);
        let (_, _) = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, (v4 as u64), (0x5135c6e7fa45663b6cd70478d1a40e3d4b328978080445e55deddeedb4247760::liquidity_math::adjust_for_slippage(v5, arg10 / 2, 10000, true) as u64), arg11, arg12);
    }

    public entry fun swap_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let v0 = 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        let (v1, v2) = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg9, arg10);
        let v3 = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::borrow_access_cap(arg0, arg10);
        0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(v3), arg3, arg7);
        let v4 = 0;
        if (arg8) {
            0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(v3), arg3, arg7, (v2 as u64));
            v4 = 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        };
        let v5 = SwapFromRecordEvent<T2, T0>{
            vault_id               : 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3),
            pool_id                : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>>(arg2),
            direction              : arg6,
            key_storage            : arg7,
            restore                : arg8,
            amount_in_vault_before : v0,
            swap_input_amount      : v1,
            swap_output_amount     : v2,
            amount_in_vault_after  : v4,
        };
        0x2::event::emit<SwapFromRecordEvent<T2, T0>>(v5);
    }

    public entry fun swap_record<T0, T1, T2, T3>(arg0: &mut 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
        let v2 = SwapRecordEvent<T2, T3>{
            vault_id           : 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3),
            pool_id            : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2),
            direction          : arg7,
            key_storage        : arg8,
            input_amount       : arg5,
            swap_input_amount  : v0,
            swap_output_amount : v1,
            amount_in_vault    : 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::get_dynamic_field<T0, T1, u64>(arg3, arg8),
        };
        0x2::event::emit<SwapRecordEvent<T2, T3>>(v2);
    }

    public entry fun swap_record_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
        let v2 = SwapRecordEvent<T0, T2>{
            vault_id           : 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3),
            pool_id            : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg2),
            direction          : arg7,
            key_storage        : arg8,
            input_amount       : arg5,
            swap_input_amount  : v0,
            swap_output_amount : v1,
            amount_in_vault    : 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::get_dynamic_field<T0, T1, u64>(arg3, arg8),
        };
        0x2::event::emit<SwapRecordEvent<T0, T2>>(v2);
    }

    public entry fun swap_record_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>, arg4: &mut 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = 0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::AccessCap>(0x82b0c94f43d4326699b82b995645f08f04c212d7b034c25baa2caa7d6b2e7c09::bluefin_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
        let v2 = SwapRecordEvent<T2, T0>{
            vault_id           : 0x2::object::id<0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::Vault<T0, T1>>(arg3),
            pool_id            : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>>(arg2),
            direction          : arg7,
            key_storage        : arg8,
            input_amount       : arg5,
            swap_input_amount  : v0,
            swap_output_amount : v1,
            amount_in_vault    : 0x23726b949bc1927a15ace88933989086ea581c888ccc4b74413f70e8ae091a4::vault::get_dynamic_field<T0, T1, u64>(arg3, arg8),
        };
        0x2::event::emit<SwapRecordEvent<T2, T0>>(v2);
    }

    // decompiled from Move bytecode v6
}

