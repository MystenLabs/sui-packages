module 0xaafd0b7edd819a6c4172986434e1f39231de2ae006018ea49b9ab8ff074fa389::flash_loan {
    struct SwapReceipt<phantom T0, phantom T1, T2> {
        receipt: T2,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        repay_amount: u64,
        a2b: bool,
    }

    public fun deepbook_flashloan_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SwapReceipt<T0, T0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan> {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg1, arg2);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        assert!(0x2::balance::value<T0>(&v2) == arg1, 101);
        SwapReceipt<T0, T0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>{
            receipt      : v1,
            balance_a    : v2,
            balance_b    : 0x2::balance::zero<T0>(),
            repay_amount : arg1,
            a2b          : false,
        }
    }

    public fun deepbook_flashloan_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SwapReceipt<T1, T1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan> {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg2);
        let v2 = 0x2::coin::into_balance<T1>(v0);
        assert!(0x2::balance::value<T1>(&v2) == arg1, 101);
        SwapReceipt<T1, T1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>{
            receipt      : v1,
            balance_a    : v2,
            balance_b    : 0x2::balance::zero<T1>(),
            repay_amount : arg1,
            a2b          : false,
        }
    }

    public fun flash_swap_cetus<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : SwapReceipt<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>> {
        let v0 = if (arg3) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg3, true, arg4, v0, arg0);
        let v4 = v3;
        SwapReceipt<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>{
            receipt      : v4,
            balance_a    : v1,
            balance_b    : v2,
            repay_amount : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4),
            a2b          : arg3,
        }
    }

    public fun move_balance_a_from_receipt<T0, T1, T2>(arg0: &mut SwapReceipt<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::balance::withdraw_all<T0>(&mut arg0.balance_a)
    }

    public fun move_balance_b_from_receipt<T0, T1, T2>(arg0: &mut SwapReceipt<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::balance::withdraw_all<T1>(&mut arg0.balance_b)
    }

    public fun repay_cetus_flash_swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: SwapReceipt<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let SwapReceipt {
            receipt      : v0,
            balance_a    : v1,
            balance_b    : v2,
            repay_amount : v3,
            a2b          : _,
        } = arg2;
        let v5 = v1;
        let v6 = 0x2::balance::zero<T0>();
        assert!(0x2::balance::value<T0>(&v5) >= v3, 401);
        0x2::balance::destroy_zero<T1>(v2);
        0x2::balance::join<T0>(&mut v6, 0x2::balance::split<T0>(&mut v5, v3));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v6, 0x2::balance::zero<T1>(), v0);
        v5
    }

    public fun repay_cetus_flash_swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: SwapReceipt<T0, T1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let SwapReceipt {
            receipt      : v0,
            balance_a    : v1,
            balance_b    : v2,
            repay_amount : v3,
            a2b          : _,
        } = arg2;
        let v5 = v2;
        let v6 = 0x2::balance::zero<T1>();
        0x2::balance::destroy_zero<T0>(v1);
        assert!(0x2::balance::value<T1>(&v5) >= v3, 401);
        0x2::balance::join<T1>(&mut v6, 0x2::balance::split<T1>(&mut v5, v3));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v6, v0);
        v5
    }

    public fun repay_deepbook_flashloan_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: SwapReceipt<T0, T0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let SwapReceipt {
            receipt      : v0,
            balance_a    : v1,
            balance_b    : v2,
            repay_amount : v3,
            a2b          : _,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v1);
        0x2::balance::destroy_zero<T0>(v2);
        assert!(0x2::balance::value<T0>(&arg1) >= v3, 401);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1, v3), arg3), v0);
        arg1
    }

    public fun repay_deepbook_flashloan_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: SwapReceipt<T1, T1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let SwapReceipt {
            receipt      : v0,
            balance_a    : v1,
            balance_b    : v2,
            repay_amount : v3,
            a2b          : _,
        } = arg2;
        0x2::balance::destroy_zero<T1>(v1);
        0x2::balance::destroy_zero<T1>(v2);
        assert!(0x2::balance::value<T1>(&arg1) >= v3, 401);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1, v3), arg3), v0);
        arg1
    }

    // decompiled from Move bytecode v6
}

