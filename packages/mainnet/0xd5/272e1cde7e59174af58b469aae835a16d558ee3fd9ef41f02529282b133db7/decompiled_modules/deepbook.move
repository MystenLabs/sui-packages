module 0xd4747583bd10a04a19b6402b3e4b1edf4ee8d9591573be0fd497e6e17be7abf8::deepbook {
    struct HopRecord has copy, drop {
        out_amount: u64,
    }

    struct DeepBookFlashReceipt {
        flash_loan: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan,
        borrow_quantity: u64,
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

    public fun deepbook_swap_base_for_quote_bal<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::coin::from_balance<T0>(arg2, arg4);
        let v1 = 0x2::coin::zero<T1>(arg4);
        let (v2, v3) = deepbook_swap_inner<T0, T1>(arg0, arg1, v0, v1, arg3, arg4);
        0x2::coin::destroy_zero<T0>(v2);
        let v4 = 0x2::coin::into_balance<T1>(v3);
        let v5 = HopRecord{out_amount: 0x2::balance::value<T1>(&v4)};
        0x2::event::emit<HopRecord>(v5);
        v4
    }

    fun deepbook_swap_inner<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::value<T1>(&arg3);
        let v2 = false;
        if (v1 > 0) {
            v2 = true;
            let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, 0, v1, arg4);
            v0 = v3;
        };
        let (_, v7, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v9 = v0 - v0 % v7;
        if (v9 < v8) {
            return (arg2, arg3)
        };
        let v10 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, arg2, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, arg3, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v10, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), v9, v2, true, arg4, arg5);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg1, arg5), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(arg1, arg5))
    }

    public fun deepbook_swap_quote_for_base_bal<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::zero<T0>(arg5);
        let v1 = 0x2::coin::from_balance<T1>(arg2, arg5);
        let (v2, v3) = deepbook_swap_inner<T0, T1>(arg0, arg1, v0, v1, arg4, arg5);
        0x2::coin::destroy_zero<T1>(v3);
        let v4 = 0x2::coin::into_balance<T0>(v2);
        let v5 = HopRecord{out_amount: 0x2::balance::value<T0>(&v4)};
        0x2::event::emit<HopRecord>(v5);
        v4
    }

    // decompiled from Move bytecode v7
}

