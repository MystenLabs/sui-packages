module 0x8d02dc18905a31a0f97a81d64815b87a63d321b98b5edac04c9b9d7a4e25ca59::deppbookv3 {
    struct FlashLoan {
        a: u64,
        r: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan,
    }

    public fun bm_x2y<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 10190001);
        let (v1, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg1);
        let (_, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg1, v0, 0, arg4);
        let v7 = v5;
        let v8 = v6 > 0;
        if (v8) {
            assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3) >= v6, 10190003);
            v7 = v5 - (((v5 as u128) * (v1 as u128) / 1000000000) as u64);
        };
        assert!(v7 >= arg2, 10190002);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg3, arg0, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg1, arg3, &v9, 0, 0, v0, false, v8, arg4, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg3, v7, arg5)
    }

    public fun bm_y2x<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg0);
        assert!(v0 > 0, 10190001);
        let (v1, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg1);
        let (v4, _, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg1, 0, v0, arg4);
        let v7 = v4;
        let v8 = v6 > 0;
        if (v8) {
            assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3) >= v6, 10190003);
            v7 = v4 - (((v4 as u128) * (v1 as u128) / 1000000000) as u64);
        };
        assert!(v7 >= arg2, 10190002);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg3, arg0, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg1, arg3, &v9, 0, 0, v0, true, v8, arg4, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg3, v7, arg5)
    }

    public fun flash_loan_amount(arg0: &FlashLoan) : u64 {
        arg0.a
    }

    public fun loan_x<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoan) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg1, arg2);
        let v2 = FlashLoan{
            a : arg1,
            r : v1,
        };
        (v0, v2)
    }

    public fun loan_y<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, FlashLoan) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg2);
        let v2 = FlashLoan{
            a : arg1,
            r : v1,
        };
        (v0, v2)
    }

    public fun repay_x<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: FlashLoan, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let FlashLoan {
            a : v1,
            r : v2,
        } = arg2;
        assert!(v0 >= v1, 10190005);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::split<T0>(&mut arg1, v1, arg3), v2);
        0x8d02dc18905a31a0f97a81d64815b87a63d321b98b5edac04c9b9d7a4e25ca59::vault::event_emit_repay<T1>(0x2::object::id_from_address(@0x0), v1, v0);
        arg1
    }

    public fun repay_y<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: FlashLoan, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        let FlashLoan {
            a : v1,
            r : v2,
        } = arg2;
        assert!(v0 >= v1, 10190005);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::split<T1>(&mut arg1, v1, arg3), v2);
        0x8d02dc18905a31a0f97a81d64815b87a63d321b98b5edac04c9b9d7a4e25ca59::vault::event_emit_repay<T1>(0x2::object::id_from_address(@0x0), v1, v0);
        arg1
    }

    public fun sp_x2y<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0xa77ab364e584d5099b5494cb20805f87763dd35f6900d40ed26b577f7a97a33a::sponsored_swap::SponsoredTokens, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(&arg0) > 0, 10190001);
        let (v0, v1) = 0xa77ab364e584d5099b5494cb20805f87763dd35f6900d40ed26b577f7a97a33a::sponsored_swap::swap_exact_base_for_quote_sponsored<T0, T1>(arg3, arg1, arg0, arg2, arg4, arg5);
        0x8d02dc18905a31a0f97a81d64815b87a63d321b98b5edac04c9b9d7a4e25ca59::util::return_remaining_coin<T0>(v0, arg5);
        v1
    }

    public fun sp_y2x<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0xa77ab364e584d5099b5494cb20805f87763dd35f6900d40ed26b577f7a97a33a::sponsored_swap::SponsoredTokens, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T1>(&arg0) > 0, 10190001);
        let (v0, v1) = 0xa77ab364e584d5099b5494cb20805f87763dd35f6900d40ed26b577f7a97a33a::sponsored_swap::swap_exact_quote_for_base_sponsored<T0, T1>(arg3, arg1, arg0, arg2, arg4, arg5);
        0x8d02dc18905a31a0f97a81d64815b87a63d321b98b5edac04c9b9d7a4e25ca59::util::return_remaining_coin<T1>(v1, arg5);
        v0
    }

    public fun xj<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(&arg0) > 0, 10190001);
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, arg0, 0x2::coin::zero<T1>(arg4), 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), arg2, arg3, arg4);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        0x8d02dc18905a31a0f97a81d64815b87a63d321b98b5edac04c9b9d7a4e25ca59::util::return_remaining_coin<T0>(v0, arg4);
        v1
    }

    public fun yj<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T1>(&arg0) > 0, 10190001);
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, 0x2::coin::zero<T0>(arg4), arg0, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), arg2, arg3, arg4);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        0x8d02dc18905a31a0f97a81d64815b87a63d321b98b5edac04c9b9d7a4e25ca59::util::return_remaining_coin<T1>(v1, arg4);
        v0
    }

    // decompiled from Move bytecode v6
}

