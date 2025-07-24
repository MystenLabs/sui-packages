module 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_composer {
    public entry fun add_liquidity_from_record<T0, T1, T2, T3>(arg0: &mut 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u32, arg6: u32, arg7: u128, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = get_coin_amount_for_add_liquidity<T2, T3, T0, T1>(arg2, arg3, arg5, arg6, arg7, arg8, arg9);
        let (_, _) = 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::exec_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, (v0 as u64), (v1 as u64), arg10, arg11);
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::borrow_access_cap(arg0, arg11)), arg3, arg8);
    }

    public entry fun add_liquidity_have_coin_a_in_vault_from_record<T0, T1, T2>(arg0: &mut 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u32, arg6: u32, arg7: u128, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = get_coin_amount_for_add_liquidity<T0, T2, T0, T1>(arg2, arg3, arg5, arg6, arg7, arg8, arg9);
        let (_, _) = 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, (v0 as u64), (v1 as u64), arg10, arg11);
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::borrow_access_cap(arg0, arg11)), arg3, arg8);
    }

    public entry fun add_liquidity_have_coin_b_in_vault_from_record<T0, T1, T2>(arg0: &mut 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u32, arg6: u32, arg7: u128, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (v0, v1) = get_coin_amount_for_add_liquidity<T2, T0, T0, T1>(arg2, arg3, arg5, arg6, arg7, arg8, arg9);
        let (_, _) = 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg3, arg4, (v0 as u64), (v1 as u64), arg10, arg11);
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::remove_dynamic_field<T0, T1, u64>(arg4, 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::borrow_access_cap(arg0, arg11)), arg3, arg8);
    }

    fun get_coin_amount_for_add_liquidity<T0, T1, T2, T3>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T2, T3>, arg2: u32, arg3: u32, arg4: u128, arg5: vector<u8>, arg6: bool) : (u128, u128) {
        let (_, v1, v2) = 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::estimate_token(arg2, arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), (0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::get_dynamic_field<T2, T3, u64>(arg1, arg5) as u128), arg6);
        let v3 = if (v1 < arg4) {
            v1
        } else {
            v1 - arg4
        };
        (v3, v2)
    }

    public entry fun swap_and_add_liquidity<T0, T1, T2, T3>(arg0: &mut 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg11, arg12);
        let v2 = arg7 && false || true;
        let (_, v4, v5) = 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::estimate_token(arg8, arg9, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T2, T3>(arg2), (v1 as u128), v2);
        let v6 = if (v4 < arg10) {
            v4
        } else {
            v4 - arg10
        };
        let (_, _) = 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::exec_add_liquidity<T0, T1, T2, T3>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, (v6 as u64), (v5 as u64), arg11, arg12);
    }

    public entry fun swap_have_coin_a_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg11, arg12);
        let v2 = arg7 && false || true;
        let (_, v4, v5) = 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::estimate_token(arg8, arg9, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T2>(arg2), (v1 as u128), v2);
        let v6 = if (v4 < arg10) {
            v4
        } else {
            v4 - arg10
        };
        let (_, _) = 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::exec_add_liquidity_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, (v6 as u64), (v5 as u64), arg11, arg12);
    }

    public entry fun swap_have_coin_b_in_vault_and_add_liquidity<T0, T1, T2>(arg0: &mut 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: u32, arg9: u32, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg11, arg12);
        let v2 = arg7 && false || true;
        let (_, v4, v5) = 0xa152a29be45afa721fd2d665bcf176574277b082faf19afe08d6f92b6b48f2e::liquidity_math::estimate_token(arg8, arg9, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T2, T0>(arg2), (v1 as u128), v2);
        let v6 = if (v4 < arg10) {
            v4
        } else {
            v4 - arg10
        };
        let (_, _) = 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::exec_add_liquidity_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg8, arg9, arg3, arg4, (v6 as u64), (v5 as u64), arg11, arg12);
    }

    public entry fun swap_record<T0, T1, T2, T3>(arg0: &mut 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (_, v1) = 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::exec_swap<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
    }

    public entry fun swap_record_have_coin_a_in_vault<T0, T1, T2>(arg0: &mut 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (_, v1) = 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::exec_swap_have_coin_a_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
    }

    public entry fun swap_record_have_coin_b_in_vault<T0, T1, T2>(arg0: &mut 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg3: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T0, T1>, arg4: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg5: u64, arg6: u128, arg7: bool, arg8: vector<u8>, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg9 && !0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::check_dynamic_field<T0, T1>(arg3, arg8) || !arg9 && 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::check_dynamic_field<T0, T1>(arg3, arg8), 1);
        let (_, v1) = 0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::exec_swap_have_coin_b_in_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::increase_balance_dynamic_field<T0, T1>(arg4, 0x1::option::borrow<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::AccessCap>(0x42b91c2a3988b2224f91f275af63a82480673afd34a738779734e4c14262cf76::bluefin_executor::borrow_access_cap(arg0, arg11)), arg3, arg8, (v1 as u64));
    }

    // decompiled from Move bytecode v6
}

