module 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_composer {
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

    struct UserDualDepositAndAddLiquidity<phantom T0, phantom T1> has copy, drop, store {
        lp_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        vault_token: 0x1::ascii::String,
        token_a: 0x1::ascii::String,
        token_b: 0x1::ascii::String,
        input_amount_token_a: u64,
        input_amount_token_b: u64,
        refund_amount_token_a: u64,
        refund_amount_token_b: u64,
        amount_token_a: u64,
        amount_token_b: u64,
        amount_deposit_to_vault: u64,
    }

    struct UserZapInDepositAndAddLiquidity<phantom T0, phantom T1> has copy, drop, store {
        lp_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        vault_token: 0x1::ascii::String,
        token_a: 0x1::ascii::String,
        token_b: 0x1::ascii::String,
        input_amount_token_a: u64,
        input_amount_token_b: u64,
        refund_amount_token_a: u64,
        refund_amount_token_b: u64,
        amount_token_a: u64,
        amount_token_b: u64,
        amount_deposit_to_vault: u64,
        token_deposit: 0x1::ascii::String,
        token_deposit_amount: u64,
        swap_amount_in: u64,
        swap_amount_out: u64,
    }

    public entry fun add_liquidity_from_record<T0, T1, T2, T3>(arg0: &mut 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>, arg4: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::VaultConfig, arg5: u32, arg6: u32, arg7: u128, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 >= 0 && arg7 <= 10000, 4);
        let v0 = 0x2::bcs::new(arg8);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::check_dynamic_field<T0, T1>(arg3, v1), 1);
        let (v2, v3, v4, v5, v6, v7) = get_coin_amount_for_add_liquidity<T2, T3, T0, T1>(arg2, arg3, arg5, arg6, arg7, v1, arg9, 0x2::bcs::peel_u64(&mut v0));
        let (_, _) = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, (v5 as u64), (v6 as u64), arg10, arg11);
        0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::AccessCap>(0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::borrow_access_cap(arg0, arg11)), arg3, v1);
        let v10 = AddLiquidityRecordEvent<T2, T3>{
            vault_id        : 0x2::object::id<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>>(arg3),
            pool_id         : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2),
            tick_lower      : arg5,
            tick_upper      : arg6,
            key_storage     : v1,
            amount_in_vault : v7,
            liquidity       : v2,
            amount_a        : (v3 as u64),
            amount_b        : (v4 as u64),
            amount_a_fixed  : (v5 as u64),
            amount_b_fixed  : (v6 as u64),
        };
        0x2::event::emit<AddLiquidityRecordEvent<T2, T3>>(v10);
    }

    public entry fun add_liquidity_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>, arg4: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::VaultConfig, arg5: u32, arg6: u32, arg7: u128, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 >= 0 && arg7 <= 10000, 4);
        let v0 = 0x2::bcs::new(arg8);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::check_dynamic_field<T0, T1>(arg3, v1), 1);
        let (v2, v3, v4, v5, v6, v7) = get_coin_amount_for_add_liquidity<T0, T2, T0, T1>(arg2, arg3, arg5, arg6, arg7, v1, arg9, 0x2::bcs::peel_u64(&mut v0));
        let (_, _) = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, (v5 as u64), (v6 as u64), arg10, arg11);
        0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::AccessCap>(0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::borrow_access_cap(arg0, arg11)), arg3, v1);
        let v10 = AddLiquidityRecordEvent<T0, T2>{
            vault_id        : 0x2::object::id<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>>(arg3),
            pool_id         : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg2),
            tick_lower      : arg5,
            tick_upper      : arg6,
            key_storage     : v1,
            amount_in_vault : v7,
            liquidity       : v2,
            amount_a        : (v3 as u64),
            amount_b        : (v4 as u64),
            amount_a_fixed  : (v5 as u64),
            amount_b_fixed  : (v6 as u64),
        };
        0x2::event::emit<AddLiquidityRecordEvent<T0, T2>>(v10);
    }

    public entry fun add_liquidity_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>, arg4: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::VaultConfig, arg5: u32, arg6: u32, arg7: u128, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 >= 0 && arg7 <= 10000, 4);
        let v0 = 0x2::bcs::new(arg8);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::check_dynamic_field<T0, T1>(arg3, v1), 1);
        let (v2, v3, v4, v5, v6, v7) = get_coin_amount_for_add_liquidity<T2, T0, T0, T1>(arg2, arg3, arg5, arg6, arg7, v1, arg9, 0x2::bcs::peel_u64(&mut v0));
        let (_, _) = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, (v5 as u64), (v6 as u64), arg10, arg11);
        let v10 = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::borrow_access_cap(arg0, arg11);
        0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::AccessCap>(v10), arg3, v1);
        0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::AccessCap>(v10), arg3, v1);
        let v11 = AddLiquidityRecordEvent<T2, T0>{
            vault_id        : 0x2::object::id<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>>(arg3),
            pool_id         : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>>(arg2),
            tick_lower      : arg5,
            tick_upper      : arg6,
            key_storage     : v1,
            amount_in_vault : v7,
            liquidity       : v2,
            amount_a        : (v3 as u64),
            amount_b        : (v4 as u64),
            amount_a_fixed  : (v5 as u64),
            amount_b_fixed  : (v6 as u64),
        };
        0x2::event::emit<AddLiquidityRecordEvent<T2, T0>>(v11);
    }

    fun get_coin_a_for_deposit_and_add_liquidity<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u32, arg2: u32, arg3: u128, arg4: u64, arg5: u64) : u64 {
        let (_, v1, v2) = 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::estimate_token(arg1, arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), (arg5 as u128), false);
        if (v1 <= (arg4 as u128) && v2 <= (arg5 as u128)) {
            (0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::adjust_for_slippage((v1 as u128), arg3, 10000, false) as u64)
        } else {
            let v4 = (arg4 as u128);
            let v5 = 0;
            while (v5 < 10) {
                let v6 = 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::adjust_for_slippage(v4, arg3, 10000, false);
                v4 = v6;
                if (v6 <= v1) {
                    break
                };
                v5 = v5 + 1;
            };
            (v4 as u64)
        }
    }

    fun get_coin_amount_for_add_liquidity<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T2, T3>, arg2: u32, arg3: u32, arg4: u128, arg5: vector<u8>, arg6: bool, arg7: u64) : (u128, u128, u128, u128, u128, u64) {
        let v0 = 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::get_dynamic_field<T2, T3, u64>(arg1, arg5) + arg7;
        let (v1, v2, v3) = 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::estimate_token(arg2, arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::adjust_for_slippage((v0 as u128), arg4, 10000, false), arg6);
        (v1, v2, v3, v2, 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::adjust_for_slippage(v3, arg4 / 2, 10000, true), v0)
    }

    public entry fun swap_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>, arg4: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg10 >= 0 && arg10 <= 10000, 4);
        let (_, v1) = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg11, arg12);
        let v2 = arg7 && false || true;
        let (_, v4, v5) = 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::estimate_token(arg8, arg9, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T2, T3>(arg2), 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::adjust_for_slippage((v1 as u128), arg10, 10000, false), v2);
        let (_, _) = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, (v4 as u64), (0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::adjust_for_slippage(v5, arg10 / 2, 10000, true) as u64), arg11, arg12);
    }

    public entry fun swap_from_record<T0, T1, T2, T3>(arg0: &mut 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>, arg4: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let v0 = 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        let (v1, v2) = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg9, arg10);
        let v3 = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::borrow_access_cap(arg0, arg10);
        0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::AccessCap>(v3), arg3, arg7);
        let v4 = 0;
        if (arg8) {
            0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::AccessCap>(v3), arg3, arg7, (v2 as u64));
            v4 = 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        };
        let v5 = SwapFromRecordEvent<T2, T3>{
            vault_id               : 0x2::object::id<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>>(arg3),
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

    public entry fun swap_have_coin_a_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>, arg4: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg10 >= 0 && arg10 <= 10000, 4);
        let (_, v1) = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg11, arg12);
        let v2 = arg7 && false || true;
        let (_, v4, v5) = 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::estimate_token(arg8, arg9, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T2>(arg2), 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::adjust_for_slippage((v1 as u128), arg10, 10000, false), v2);
        let (_, _) = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, (v4 as u64), (0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::adjust_for_slippage(v5, arg10 / 2, 10000, true) as u64), arg11, arg12);
    }

    public entry fun swap_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>, arg4: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let v0 = 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        let (v1, v2) = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg9, arg10);
        let v3 = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::borrow_access_cap(arg0, arg10);
        0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::AccessCap>(v3), arg3, arg7);
        let v4 = 0;
        if (arg8) {
            0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::AccessCap>(v3), arg3, arg7, (v2 as u64));
            v4 = 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        };
        let v5 = SwapFromRecordEvent<T0, T2>{
            vault_id               : 0x2::object::id<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>>(arg3),
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

    public entry fun swap_have_coin_b_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>, arg4: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg10 >= 0 && arg10 <= 10000, 4);
        let (_, v1) = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg11, arg12);
        let v2 = arg7 && false || true;
        let (_, v4, v5) = 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::estimate_token(arg8, arg9, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T2, T0>(arg2), (0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::adjust_for_slippage((v1 as u128), arg10, 10000, false) as u128), v2);
        let (_, _) = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, (v4 as u64), (0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::adjust_for_slippage(v5, arg10 / 2, 10000, true) as u64), arg11, arg12);
    }

    public entry fun swap_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>, arg4: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::VaultConfig, arg5: u128, arg6: bool, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::check_dynamic_field<T0, T1>(arg3, arg7), 1);
        let v0 = 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        let (v1, v2) = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg9, arg10);
        let v3 = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::borrow_access_cap(arg0, arg10);
        0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::AccessCap>(v3), arg3, arg7);
        let v4 = 0;
        if (arg8) {
            0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::AccessCap>(v3), arg3, arg7, (v2 as u64));
            v4 = 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::get_dynamic_field<T0, T1, u64>(arg3, arg7);
        };
        let v5 = SwapFromRecordEvent<T2, T0>{
            vault_id               : 0x2::object::id<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>>(arg3),
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

    public entry fun swap_record<T0, T1, T2, T3>(arg0: &mut 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>, arg4: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::AccessCap>(0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
        let v2 = SwapRecordEvent<T2, T3>{
            vault_id           : 0x2::object::id<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>>(arg3),
            pool_id            : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg2),
            direction          : arg7,
            key_storage        : arg8,
            input_amount       : arg5,
            swap_input_amount  : v0,
            swap_output_amount : v1,
            amount_in_vault    : 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::get_dynamic_field<T0, T1, u64>(arg3, arg8),
        };
        0x2::event::emit<SwapRecordEvent<T2, T3>>(v2);
    }

    public entry fun swap_record_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>, arg4: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::AccessCap>(0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
        let v2 = SwapRecordEvent<T0, T2>{
            vault_id           : 0x2::object::id<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>>(arg3),
            pool_id            : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>>(arg2),
            direction          : arg7,
            key_storage        : arg8,
            input_amount       : arg5,
            swap_input_amount  : v0,
            swap_output_amount : v1,
            amount_in_vault    : 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::get_dynamic_field<T0, T1, u64>(arg3, arg8),
        };
        0x2::event::emit<SwapRecordEvent<T0, T2>>(v2);
    }

    public entry fun swap_record_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>, arg4: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::AccessCap>(0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
        let v2 = SwapRecordEvent<T2, T0>{
            vault_id           : 0x2::object::id<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>>(arg3),
            pool_id            : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>>(arg2),
            direction          : arg7,
            key_storage        : arg8,
            input_amount       : arg5,
            swap_input_amount  : v0,
            swap_output_amount : v1,
            amount_in_vault    : 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::get_dynamic_field<T0, T1, u64>(arg3, arg8),
        };
        0x2::event::emit<SwapRecordEvent<T2, T0>>(v2);
    }

    public entry fun user_deposit_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>, arg5: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T3>, arg11: u128, arg12: u32, arg13: u32, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: vector<vector<u8>>, arg20: vector<vector<u8>>, arg21: vector<u8>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 >= 0 && arg11 <= 10000, 4);
        user_deposit_and_add_liquidity_internal<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, false, 0x1::ascii::string(0x1::vector::empty<u8>()), 0, 0, 0, arg22, arg23);
    }

    fun user_deposit_and_add_liquidity_internal<T0, T1, T2, T3>(arg0: &mut 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>, arg5: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T3>, arg11: u128, arg12: u32, arg13: u32, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: vector<vector<u8>>, arg20: vector<vector<u8>>, arg21: bool, arg22: 0x1::ascii::String, arg23: u64, arg24: u64, arg25: u64, arg26: &0x2::clock::Clock, arg27: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T2>(&arg9);
        let v1 = 0x2::coin::value<T3>(&arg10);
        assert!(v0 > 0 || v1 > 0, 2);
        let v2 = get_coin_a_for_deposit_and_add_liquidity<T2, T3>(arg3, arg12, arg13, arg11, v0, v1);
        assert!(v2 > 0, 2);
        let v3 = 0x2::tx_context::sender(arg27);
        let v4 = 0;
        let v5 = if (v2 < v0) {
            0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::utils::destroy_zero_or_transfer_to_receiver<T2>(arg9, v3, arg27);
            v4 = v0 - v2;
            0x2::coin::split<T2>(&mut arg9, v2, arg27)
        } else {
            arg9
        };
        let v6 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        let v7 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        let v8 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v9 = 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_age(arg2);
        let v10 = 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg2, v8);
        let (v11, v12, v13, v14, v15) = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_user_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg3, arg4, arg5, v5, arg10, arg12, arg13, arg26, arg27);
        let v16 = v15;
        let v17 = v14;
        0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::utils::destroy_zero_or_transfer_to_receiver<T2>(v17, v3, arg27);
        0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::utils::destroy_zero_or_transfer_to_receiver<T3>(v16, v3, arg27);
        let (v18, _, v20) = 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::fast_price_feed::get_amount_with_price_feed(arg7, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg2, v6), v10, v9, v12, arg26);
        assert!(v18 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg2, v6), 3);
        let (v21, _, v23) = 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::fast_price_feed::get_amount_with_price_feed(arg8, 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_token_decimal(arg2, v7), v10, v9, v13, arg26);
        assert!(v21 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg2, v7), 3);
        let (v24, v25) = 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::fast_price_feed::get_price(arg6, v10, v9, arg26);
        assert!(v24 == 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_price_feed(arg2, v8), 3);
        let v26 = 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::fast_price_feed::safe_mul(v20 + v23, 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::fast_price_feed::pow10((v10 as u8))) / v25;
        if (arg21) {
            0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_vault_zapin_deposit<T0, T1>(arg0, arg4, arg5, v26, arg14, arg15, arg16, arg17, arg18, arg19, arg20, v3, v6, v7, v12, v13, arg22, arg23, arg26, arg27);
            let v27 = UserZapInDepositAndAddLiquidity<T2, T3>{
                lp_id                   : v11,
                vault_id                : 0x2::object::id<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>>(arg4),
                pool_id                 : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg3),
                tick_lower              : arg12,
                tick_upper              : arg13,
                vault_token             : v8,
                token_a                 : v6,
                token_b                 : v7,
                input_amount_token_a    : v0,
                input_amount_token_b    : v1,
                refund_amount_token_a   : v4 + 0x2::coin::value<T2>(&v17),
                refund_amount_token_b   : 0x2::coin::value<T3>(&v16),
                amount_token_a          : v12,
                amount_token_b          : v13,
                amount_deposit_to_vault : v26,
                token_deposit           : arg22,
                token_deposit_amount    : arg23,
                swap_amount_in          : arg24,
                swap_amount_out         : arg25,
            };
            0x2::event::emit<UserZapInDepositAndAddLiquidity<T2, T3>>(v27);
        } else {
            0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_vault_dual_deposit<T0, T1>(arg0, arg4, arg5, v26, arg14, arg15, arg16, arg17, arg18, arg19, arg20, v3, v6, v7, v12, v13, arg26, arg27);
            let v28 = UserDualDepositAndAddLiquidity<T2, T3>{
                lp_id                   : v11,
                vault_id                : 0x2::object::id<0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>>(arg4),
                pool_id                 : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg3),
                tick_lower              : arg12,
                tick_upper              : arg13,
                vault_token             : v8,
                token_a                 : v6,
                token_b                 : v7,
                input_amount_token_a    : v0,
                input_amount_token_b    : v1,
                refund_amount_token_a   : v4 + 0x2::coin::value<T2>(&v17),
                refund_amount_token_b   : 0x2::coin::value<T3>(&v16),
                amount_token_a          : v12,
                amount_token_b          : v13,
                amount_deposit_to_vault : v26,
            };
            0x2::event::emit<UserDualDepositAndAddLiquidity<T2, T3>>(v28);
        };
    }

    public entry fun user_swap_coin_a_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>, arg5: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T2>, arg10: u64, arg11: u128, arg12: u32, arg13: u32, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: vector<vector<u8>>, arg20: vector<vector<u8>>, arg21: vector<u8>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 >= 0 && arg11 <= 10000, 4);
        let v0 = 0x2::coin::value<T2>(&arg9);
        assert!(v0 > 0 && v0 > arg10, 2);
        let (v1, v2, v3, v4) = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_user_swap<T2, T3>(arg1, arg3, arg9, 0x2::coin::zero<T3>(arg23), arg10, 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::adjust_for_slippage(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T2, T3>(arg3), arg11, 10000, false), true, arg22, arg23);
        user_deposit_and_add_liquidity_internal<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v3, v4, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, true, 0x1::type_name::into_string(0x1::type_name::get<T2>()), v0, v1, v2, arg22, arg23);
    }

    public entry fun user_swap_coin_b_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg4: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::Vault<T0, T1>, arg5: &mut 0x8404e665609111801ec4231c748faf586da4e740d809c0c43ba80a5bd61f6d0a::vault::VaultConfig, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: 0x2::coin::Coin<T3>, arg10: u64, arg11: u128, arg12: u32, arg13: u32, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: vector<vector<u8>>, arg20: vector<vector<u8>>, arg21: vector<u8>, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        assert!(arg11 >= 0 && arg11 <= 10000, 4);
        let v0 = 0x2::coin::value<T3>(&arg9);
        assert!(v0 > 0 && v0 > arg10, 2);
        let (v1, v2, v3, v4) = 0xe0fb88401d43e89ce8a3a1452153831876201bd0a7ac12d63987d68b773e2780::bluefin_executor::exec_user_swap<T2, T3>(arg1, arg3, 0x2::coin::zero<T2>(arg23), arg9, arg10, 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::adjust_for_slippage(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T2, T3>(arg3), arg11, 10000, true), false, arg22, arg23);
        user_deposit_and_add_liquidity_internal<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v3, v4, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, true, 0x1::type_name::into_string(0x1::type_name::get<T3>()), v0, v1, v2, arg22, arg23);
    }

    // decompiled from Move bytecode v6
}

