module 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::deepbook_v3 {
    struct DeepbookV3InternalSwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        deep_fee: u64,
        alt_payment_deep_fee: u64,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun place_market_order<T0, T1>(arg0: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: u8, arg6: u64, arg7: bool, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo) {
        abort 0
    }

    public fun place_market_order_by_bssm<T0, T1>(arg0: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u8, arg7: u64, arg8: bool, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo) {
        abort 0
    }

    public fun send_or_destory_zero_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun swap_a2b_<T0, T1>(arg0: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::checked_package_version(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg1, v0, arg4);
        let v4 = 0;
        let v5 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3);
        let v6 = if (v3 > v5) {
            let v7 = v3 - v5;
            v4 = v7;
            0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::alternative_payment_deep(arg0, arg3, v7, arg5)
        } else {
            arg3
        };
        let v8 = v6;
        let (v9, v10, v11) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, arg2, v8, 0, arg4, arg5);
        let v12 = v11;
        let v13 = v10;
        let v14 = v9;
        let v15 = DeepbookV3InternalSwapEvent{
            pool                 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            amount_in            : v0 - 0x2::coin::value<T0>(&v14),
            amount_out           : 0x2::coin::value<T1>(&v13),
            a2b                  : true,
            by_amount_in         : true,
            deep_fee             : 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v8) - 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v12),
            alt_payment_deep_fee : v4,
            coin_a               : 0x1::type_name::with_original_ids<T0>(),
            coin_b               : 0x1::type_name::with_original_ids<T1>(),
        };
        0x2::event::emit<DeepbookV3InternalSwapEvent>(v15);
        (v14, v13, v12)
    }

    public fun swap_a2b_with_referral<T0, T1>(arg0: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::BalanceCaps, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DeepBookPoolReferral, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::checked_package_version(arg0);
        let v0 = 0x2::coin::value<T0>(&arg4);
        let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg1, v0, arg6);
        let v4 = v3 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v3, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_referral_multiplier<T0, T1>(arg1, arg3));
        let v5 = 0;
        let v6 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg5);
        let (v7, v8) = if (v4 > v6) {
            let v9 = v4 - v6;
            v5 = v9;
            (0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::alternative_payment_deep(arg0, arg5, v9, arg7), 0)
        } else {
            (arg5, v6 - v4)
        };
        let v10 = v7;
        let (v11, v12) = 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::get_mut_balance_manager_and_trade_cap(arg0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v11, v10, arg7);
        let (v13, v14) = 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::get_deposit_and_withdraw_caps(arg2);
        let (v15, v16) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote_with_manager<T0, T1>(arg1, v11, v12, v13, v14, arg4, 0, arg6, arg7);
        let v17 = v16;
        let v18 = v15;
        let v19 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v11, v8, arg7);
        let v20 = DeepbookV3InternalSwapEvent{
            pool                 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            amount_in            : v0 - 0x2::coin::value<T0>(&v18),
            amount_out           : 0x2::coin::value<T1>(&v17),
            a2b                  : true,
            by_amount_in         : true,
            deep_fee             : 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v10) - 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v19),
            alt_payment_deep_fee : v5,
            coin_a               : 0x1::type_name::with_original_ids<T0>(),
            coin_b               : 0x1::type_name::with_original_ids<T1>(),
        };
        0x2::event::emit<DeepbookV3InternalSwapEvent>(v20);
        (v18, v17, v19)
    }

    public fun swap_b2a_<T0, T1>(arg0: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::checked_package_version(arg0);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg1, v0, arg4);
        let v4 = 0;
        let v5 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3);
        let v6 = if (v3 > v5) {
            let v7 = v3 - v5;
            v4 = v7;
            0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::alternative_payment_deep(arg0, arg3, v7, arg5)
        } else {
            arg3
        };
        let v8 = v6;
        let (v9, v10, v11) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, arg2, v8, 0, arg4, arg5);
        let v12 = v11;
        let v13 = v10;
        let v14 = v9;
        let v15 = DeepbookV3InternalSwapEvent{
            pool                 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            amount_in            : v0 - 0x2::coin::value<T1>(&v13),
            amount_out           : 0x2::coin::value<T0>(&v14),
            a2b                  : false,
            by_amount_in         : true,
            deep_fee             : 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v8) - 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v12),
            alt_payment_deep_fee : v4,
            coin_a               : 0x1::type_name::with_original_ids<T0>(),
            coin_b               : 0x1::type_name::with_original_ids<T1>(),
        };
        0x2::event::emit<DeepbookV3InternalSwapEvent>(v15);
        (v14, v13, v12)
    }

    public fun swap_b2a_with_referral<T0, T1>(arg0: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::BalanceCaps, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DeepBookPoolReferral, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::checked_package_version(arg0);
        let v0 = 0x2::coin::value<T1>(&arg4);
        let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg1, v0, arg6);
        let v4 = v3 + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v3, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_referral_multiplier<T0, T1>(arg1, arg3));
        let v5 = 0;
        let v6 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg5);
        let (v7, v8) = if (v4 > v6) {
            let v9 = v4 - v6;
            v5 = v9;
            (0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::alternative_payment_deep(arg0, arg5, v9, arg7), 0)
        } else {
            (arg5, v6 - v4)
        };
        let v10 = v7;
        let (v11, v12) = 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::get_mut_balance_manager_and_trade_cap(arg0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v11, v10, arg7);
        let (v13, v14) = 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::get_deposit_and_withdraw_caps(arg2);
        let (v15, v16) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base_with_manager<T0, T1>(arg1, v11, v12, v13, v14, arg4, 0, arg6, arg7);
        let v17 = v16;
        let v18 = v15;
        let v19 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v11, v8, arg7);
        let v20 = DeepbookV3InternalSwapEvent{
            pool                 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            amount_in            : v0 - 0x2::coin::value<T1>(&v17),
            amount_out           : 0x2::coin::value<T0>(&v18),
            a2b                  : false,
            by_amount_in         : true,
            deep_fee             : 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v10) - 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v19),
            alt_payment_deep_fee : v5,
            coin_a               : 0x1::type_name::with_original_ids<T0>(),
            coin_b               : 0x1::type_name::with_original_ids<T1>(),
        };
        0x2::event::emit<DeepbookV3InternalSwapEvent>(v20);
        (v18, v17, v19)
    }

    // decompiled from Move bytecode v6
}

