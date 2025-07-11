module 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::mmt_adapter {
    struct SwapEvent<phantom T0, phantom T1> has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        direction: bool,
        input_amount: u64,
        output_amount: u64,
    }

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

    public fun internal_swap<T0, T1>(arg0: 0x2::object::ID, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u128, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        abort 0
    }

    public fun internal_swap_v2<T0, T1>(arg0: 0x2::object::ID, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u128, arg7: bool, arg8: bool, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, arg7, true, arg5, arg6, arg10, arg2, arg11);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0;
        let v7 = if (arg7) {
            assert!(0x2::balance::value<T1>(&v4) > 0, 2);
            0x2::balance::value<T1>(&v4)
        } else {
            assert!(0x2::balance::value<T0>(&v5) > 0, 2);
            0x2::balance::value<T0>(&v5)
        };
        let (v8, v9) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v10 = if (arg7) {
            assert!(0x2::coin::value<T0>(&arg3) >= v8, 3);
            v6 = v8;
            0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v8, arg11))
        } else {
            0x2::balance::zero<T0>()
        };
        let v11 = if (!arg7) {
            assert!(0x2::coin::value<T1>(&arg4) >= v9, 3);
            v6 = v9;
            0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v9, arg11))
        } else {
            0x2::balance::zero<T1>()
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, v10, v11, arg2, arg11);
        0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v5, arg11));
        0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v4, arg11));
        if (arg8) {
            let v12 = SwapWithdrawEvent<T0, T1>{
                receiver               : arg9,
                vault_id               : arg0,
                pool_id                : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1),
                direction              : arg7,
                input_amount           : v6,
                output_amount          : v7,
                remaining_input_amount : arg5 - v6,
            };
            0x2::event::emit<SwapWithdrawEvent<T0, T1>>(v12);
        } else {
            let v13 = SwapDepositEvent<T0, T1>{
                receiver      : arg9,
                vault_id      : arg0,
                pool_id       : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1),
                direction     : arg7,
                input_amount  : v6,
                output_amount : v7,
            };
            0x2::event::emit<SwapDepositEvent<T0, T1>>(v13);
        };
        (arg3, arg4)
    }

    public entry fun redeem_then_swap_coin_a<T0, T1, T2>(arg0: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg1: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T1, T2>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: u128, arg5: address, arg6: vector<u64>, arg7: vector<u64>, arg8: u64, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::utils::calc_sqrt_price_max_limit(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg2), arg4);
        let v1 = 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::redeem_internal<T1, T2>(arg0, arg1, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v2 = 0x2::coin::zero<T0>(arg12);
        let (v3, v4) = internal_swap_v2<T0, T1>(0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T1, T2>>(arg1), arg2, arg3, v2, v1, 0x2::coin::value<T1>(&v1), v0, false, true, arg5, arg11, arg12);
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::utils::destroy_zero_or_transfer_to_receiver<T0>(v3, arg5, arg12);
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::utils::destroy_zero_or_transfer_to_receiver<T1>(v4, arg5, arg12);
    }

    public entry fun redeem_then_swap_coin_b<T0, T1, T2>(arg0: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg1: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T1, T2>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: u128, arg5: address, arg6: vector<u64>, arg7: vector<u64>, arg8: u64, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::utils::calc_sqrt_price_max_limit(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T1, T0>(arg2), arg4);
        let v1 = 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::redeem_internal<T1, T2>(arg0, arg1, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v2 = 0x2::coin::zero<T0>(arg12);
        let (v3, v4) = internal_swap_v2<T1, T0>(0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T1, T2>>(arg1), arg2, arg3, v1, v2, 0x2::coin::value<T1>(&v1), v0, true, true, arg5, arg11, arg12);
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::utils::destroy_zero_or_transfer_to_receiver<T1>(v3, arg5, arg12);
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::utils::destroy_zero_or_transfer_to_receiver<T0>(v4, arg5, arg12);
    }

    public entry fun swap_coin_a_and_deposit<T0, T1, T2>(arg0: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg1: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T1, T2>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: 0x2::coin::Coin<T0>, arg5: u128, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun swap_coin_a_then_deposit<T0, T1, T2>(arg0: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg1: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T1, T2>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: 0x2::coin::Coin<T0>, arg5: u128, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 1);
        let v1 = 0x2::coin::zero<T1>(arg14);
        let v2 = 0x2::tx_context::sender(arg14);
        let (v3, v4) = internal_swap_v2<T0, T1>(0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T1, T2>>(arg1), arg2, arg3, arg4, v1, v0, arg5, true, false, v2, arg13, arg14);
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::deposit_with_sigs_credit_time<T1, T2>(arg0, arg1, v4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::utils::destroy_zero_or_transfer_to_receiver<T0>(v3, 0x2::tx_context::sender(arg14), arg14);
    }

    public entry fun swap_coin_b_and_deposit<T0, T1, T2>(arg0: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg1: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T1, T2>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: 0x2::coin::Coin<T0>, arg5: u128, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun swap_coin_b_then_deposit<T0, T1, T2>(arg0: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::VaultConfig, arg1: &mut 0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T1, T2>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: 0x2::coin::Coin<T0>, arg5: u128, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 1);
        let v1 = 0x2::coin::zero<T1>(arg14);
        let v2 = 0x2::tx_context::sender(arg14);
        let (v3, v4) = internal_swap_v2<T1, T0>(0x2::object::id<0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::Vault<T1, T2>>(arg1), arg2, arg3, v1, arg4, v0, arg5, false, false, v2, arg13, arg14);
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::vault::deposit_with_sigs_credit_time<T1, T2>(arg0, arg1, v3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        0x6912f65729914f9dbb55da0bfa6c4f36f10f5e7912c5baf5938d95828f52b840::utils::destroy_zero_or_transfer_to_receiver<T0>(v4, 0x2::tx_context::sender(arg14), arg14);
    }

    // decompiled from Move bytecode v6
}

