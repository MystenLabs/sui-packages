module 0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::bluefin_adapter {
    struct SwapDepositEvent<phantom T0, phantom T1> has copy, drop, store {
        receiver: address,
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        direction: bool,
        input_amount: u64,
        output_amount: u64,
    }

    struct SwapWithdrawEvent<phantom T0, phantom T1> has copy, drop, store {
        receiver: address,
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        direction: bool,
        input_amount: u64,
        output_amount: u64,
        remaining_input_amount: u64,
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / (10000 as u64)
    }

    fun charge_deposit_fee<T0, T1, T2>(arg0: &0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::VaultConfig, arg1: &0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::Vault<T0, T1>, arg2: &mut 0x2::coin::Coin<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T2>(arg2);
        if (v0 > 0) {
            0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::collect_fee_internal<T0, T1, T2>(arg0, arg1, 0x2::coin::split<T2>(arg2, calculate_fee(v0, 0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::get_deposit_fee_bps<T0, T1>(arg1)), arg4), 0, arg3);
        };
    }

    public fun internal_swap<T0, T1>(arg0: 0x2::object::ID, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u128, arg7: bool, arg8: bool, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg10, arg1, arg2, arg7, true, arg5, arg6);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (arg7) {
            assert!(0x2::balance::value<T1>(&v4) > 0, 2);
        } else {
            assert!(0x2::balance::value<T0>(&v5) > 0, 2);
        };
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg7) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        let (v8, v9) = if (arg7) {
            assert!(0x2::coin::value<T0>(&arg3) >= v6, 3);
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v6, arg11)), 0x2::balance::zero<T1>())
        } else {
            assert!(0x2::coin::value<T1>(&arg4) >= v6, 3);
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v6, arg11)))
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg1, arg2, v8, v9, v3);
        0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v5, arg11));
        0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v4, arg11));
        if (arg8) {
            let v10 = SwapWithdrawEvent<T0, T1>{
                receiver               : arg9,
                vault_id               : arg0,
                pool_id                : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2),
                direction              : arg7,
                input_amount           : v6,
                output_amount          : v7,
                remaining_input_amount : arg5 - v6,
            };
            0x2::event::emit<SwapWithdrawEvent<T0, T1>>(v10);
        } else {
            let v11 = SwapDepositEvent<T0, T1>{
                receiver      : arg9,
                vault_id      : arg0,
                pool_id       : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2),
                direction     : arg7,
                input_amount  : v6,
                output_amount : v7,
            };
            0x2::event::emit<SwapDepositEvent<T0, T1>>(v11);
        };
        (arg3, arg4)
    }

    public entry fun redeem_then_swap_coin_a<T0, T1, T2>(arg0: &mut 0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::VaultConfig, arg1: &mut 0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::Vault<T1, T2>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u128, arg5: address, arg6: vector<u64>, arg7: vector<u64>, arg8: u64, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun redeem_then_swap_coin_b<T0, T1, T2>(arg0: &mut 0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::VaultConfig, arg1: &mut 0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::Vault<T1, T2>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: u128, arg5: address, arg6: vector<u64>, arg7: vector<u64>, arg8: u64, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun swap_coin_a_then_deposit<T0, T1, T2>(arg0: &mut 0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::VaultConfig, arg1: &mut 0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::Vault<T1, T2>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: u128, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg4) > 0, 1);
        let v0 = &mut arg4;
        charge_deposit_fee<T1, T2, T0>(arg0, arg1, v0, arg13, arg14);
        let v1 = 0x2::coin::zero<T1>(arg14);
        let v2 = 0x2::tx_context::sender(arg14);
        let (v3, v4) = internal_swap<T0, T1>(0x2::object::id<0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::Vault<T1, T2>>(arg1), arg2, arg3, arg4, v1, 0x2::coin::value<T0>(&arg4), arg5, true, false, v2, arg13, arg14);
        0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::deposit_with_no_fee<T1, T2>(arg0, arg1, v4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::utils::destroy_zero_or_transfer_to_receiver<T0>(v3, 0x2::tx_context::sender(arg14), arg14);
    }

    public entry fun swap_coin_b_then_deposit<T0, T1, T2>(arg0: &mut 0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::VaultConfig, arg1: &mut 0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::Vault<T1, T2>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg4: 0x2::coin::Coin<T0>, arg5: u128, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg4) > 0, 1);
        let v0 = &mut arg4;
        charge_deposit_fee<T1, T2, T0>(arg0, arg1, v0, arg13, arg14);
        let v1 = 0x2::coin::zero<T1>(arg14);
        let v2 = 0x2::tx_context::sender(arg14);
        let (v3, v4) = internal_swap<T1, T0>(0x2::object::id<0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::Vault<T1, T2>>(arg1), arg2, arg3, v1, arg4, 0x2::coin::value<T0>(&arg4), arg5, false, false, v2, arg13, arg14);
        0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::deposit_with_no_fee<T1, T2>(arg0, arg1, v3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::utils::destroy_zero_or_transfer_to_receiver<T0>(v4, 0x2::tx_context::sender(arg14), arg14);
    }

    // decompiled from Move bytecode v6
}

