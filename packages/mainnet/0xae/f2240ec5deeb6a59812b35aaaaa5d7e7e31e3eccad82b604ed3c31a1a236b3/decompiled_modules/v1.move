module 0xaef2240ec5deeb6a59812b35aaaaa5d7e7e31e3eccad82b604ed3c31a1a236b3::v1 {
    struct SwapReceipt<phantom T0, phantom T1, T2> {
        flash_loan_receipt: T2,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        repay_amount: u64,
        a2b: bool,
    }

    public fun bluefin__a_to_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, arg3, 0x2::balance::zero<T1>(), true, true, 0x2::balance::value<T0>(&arg3), 0, get_sqrt_price_limit(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2), true));
        transfer_or_destroy_balance<T0>(v0, arg4);
        v1
    }

    public fun bluefin__b_to_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), arg3, false, true, 0x2::balance::value<T1>(&arg3), 0, get_sqrt_price_limit(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2), false));
        transfer_or_destroy_balance<T1>(v1, arg4);
        v0
    }

    public fun flash_loan_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SwapReceipt<T1, T1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan> {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg2);
        let v2 = 0x2::coin::into_balance<T1>(v0);
        assert!(0x2::balance::value<T1>(&v2) == arg1, 101);
        SwapReceipt<T1, T1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>{
            flash_loan_receipt : v1,
            balance_a          : v2,
            balance_b          : 0x2::balance::zero<T1>(),
            repay_amount       : arg1,
            a2b                : false,
        }
    }

    public fun get_sqrt_price_limit(arg0: u128, arg1: bool) : u128 {
        if (arg1) {
            arg0 * 3 / 5
        } else {
            arg0 * 5 / 3
        }
    }

    public fun move_balance_a_from_receipt<T0, T1, T2>(arg0: &mut SwapReceipt<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance_a), arg1)
    }

    public fun move_balance_b_from_receipt<T0, T1, T2>(arg0: &mut SwapReceipt<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.balance_b), arg1)
    }

    public fun repay_loan_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: SwapReceipt<T1, T1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let SwapReceipt {
            flash_loan_receipt : v0,
            balance_a          : v1,
            balance_b          : v2,
            repay_amount       : v3,
            a2b                : _,
        } = arg2;
        0x2::balance::destroy_zero<T1>(v1);
        0x2::balance::destroy_zero<T1>(v2);
        assert!(0x2::balance::value<T1>(&arg1) >= v3, 401);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1, v3), arg3), v0);
        arg1
    }

    fun transfer_or_destroy_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(0x2::coin::from_balance<T0>(arg0, arg1));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

