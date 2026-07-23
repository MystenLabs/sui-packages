module 0xcf830d8b9ca7dbb3a2221db9699a18f763e82cafec2276274e59c4727dd17885::deepbook {
    struct ProfitRecord has copy, drop {
        amount: u64,
    }

    struct DeepConsumed has copy, drop {
        d: u64,
    }

    struct DeepBookFlashReceipt {
        flash_loan: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan,
        borrow_quantity: u64,
    }

    public fun check_profit_and_collect<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = ProfitRecord{amount: v0};
        0x2::event::emit<ProfitRecord>(v1);
        assert!(v0 >= arg2, 101);
        0x2::coin::join<T0>(arg0, 0x2::coin::from_balance<T0>(arg1, arg3));
    }

    public fun deepbook_flash_borrow_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (DeepBookFlashReceipt, 0x2::balance::Balance<T0>) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg1, arg2);
        let v2 = DeepBookFlashReceipt{
            flash_loan      : v1,
            borrow_quantity : arg1,
        };
        (v2, 0x2::coin::into_balance<T0>(v0))
    }

    public fun deepbook_flash_borrow_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (DeepBookFlashReceipt, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg2);
        let v2 = DeepBookFlashReceipt{
            flash_loan      : v1,
            borrow_quantity : arg1,
        };
        (v2, 0x2::coin::into_balance<T1>(v0))
    }

    public fun deepbook_flash_repay_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: DeepBookFlashReceipt, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let DeepBookFlashReceipt {
            flash_loan      : v0,
            borrow_quantity : v1,
        } = arg1;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2, v1), arg3), v0);
        arg2
    }

    public fun deepbook_flash_repay_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: DeepBookFlashReceipt, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let DeepBookFlashReceipt {
            flash_loan      : v0,
            borrow_quantity : v1,
        } = arg1;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2, v1), arg3), v0);
        arg2
    }

    public fun deepbook_swap_base_for_quote_bal<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::AuthList, arg5: &mut 0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::DeepVault, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::assert_authorized(arg4, arg6);
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, 0x2::balance::value<T0>(&arg2), 0, arg3);
        let v3 = 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::split_fee(arg5, arg4, v2, arg6), arg6);
        let v4 = 0x2::coin::from_balance<T0>(arg2, arg6);
        let v5 = 0x2::coin::zero<T1>(arg6);
        let (v6, v7, v8) = deepbook_swap_inner<T0, T1>(arg0, arg1, v4, v5, v3, arg3, arg6);
        dispose_residue<T0>(v6);
        0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::return_fee(arg5, arg4, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v8), arg6);
        0x2::coin::into_balance<T1>(v7)
    }

    public fun deepbook_swap_base_for_quote_direct<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::AuthList, arg4: &mut 0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::DeepVault, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::assert_authorized(arg3, arg5);
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, 0x2::balance::value<T0>(&arg1), 0, arg2);
        let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg0, 0x2::coin::from_balance<T0>(arg1, arg5), 0x2::coin::zero<T1>(arg5), 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::split_fee(arg4, arg3, v2, arg5), arg5), 0, arg2, arg5);
        dispose_residue<T0>(v3);
        0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::return_fee(arg4, arg3, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v5), arg5);
        0x2::coin::into_balance<T1>(v4)
    }

    fun deepbook_swap_inner<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let v0 = 0x2::coin::value<T1>(&arg3);
        let (v1, v2) = if (v0 > 0) {
            let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, 0, v0, arg5);
            (v3, true)
        } else {
            (0x2::coin::value<T0>(&arg2), false)
        };
        let (_, v7, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v9 = v1 - v1 % v7;
        if (v9 < v8) {
            return (arg2, arg3, arg4)
        };
        let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, arg2, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, arg3, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, arg4, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v10, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v9, v2, true, arg5, arg6);
        let v11 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, arg6);
        let v12 = DeepConsumed{d: 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg4) - 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v11)};
        0x2::event::emit<DeepConsumed>(v12);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg1, arg6), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(arg1, arg6), v11)
    }

    public fun deepbook_swap_quote_for_base_bal<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::AuthList, arg5: &mut 0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::DeepVault, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::assert_authorized(arg4, arg6);
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, 0, 0x2::balance::value<T1>(&arg2), arg3);
        let v3 = 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::split_fee(arg5, arg4, v2, arg6), arg6);
        let v4 = 0x2::coin::zero<T0>(arg6);
        let v5 = 0x2::coin::from_balance<T1>(arg2, arg6);
        let (v6, v7, v8) = deepbook_swap_inner<T0, T1>(arg0, arg1, v4, v5, v3, arg3, arg6);
        dispose_residue<T1>(v7);
        0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::return_fee(arg5, arg4, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v8), arg6);
        0x2::coin::into_balance<T0>(v6)
    }

    public fun deepbook_swap_quote_for_base_direct<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::AuthList, arg4: &mut 0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::DeepVault, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::assert_authorized(arg3, arg5);
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, 0, 0x2::balance::value<T1>(&arg1), arg2);
        let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg0, 0x2::coin::zero<T0>(arg5), 0x2::coin::from_balance<T1>(arg1, arg5), 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::split_fee(arg4, arg3, v2, arg5), arg5), 0, arg2, arg5);
        dispose_residue<T1>(v4);
        0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault::return_fee(arg4, arg3, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v5), arg5);
        0x2::coin::into_balance<T0>(v3)
    }

    fun dispose_residue<T0>(arg0: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x2b9148639c33d4ce03d65be9366aaef275988f01b77dda6475f7b5f6e9c1dc8b);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

