module 0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::deepbookv3 {
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

    public fun place_market_order<T0, T1>(arg0: &mut 0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: u8, arg6: u64, arg7: bool, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::checked_package_version(arg0);
        if (arg7) {
            0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::deposit<T1>(arg0, arg3, arg10);
            send_or_destory_zero_coin<T0>(arg2, arg10);
        } else {
            0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::deposit<T0>(arg0, arg2, arg10);
            send_or_destory_zero_coin<T1>(arg3, arg10);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg4) > 0) {
            0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, arg4, arg10);
        } else {
            send_or_destory_zero_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4, arg10);
        };
        0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::deposit_proxy_deep(arg0, arg10);
        let v0 = 0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::place_market_order_by_trader<T0, T1>(arg0, arg1, 1107, arg5, arg6, arg7, arg8, arg9, arg10);
        let v1 = 0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::alternative_payment_amount(arg0);
        if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(&v0) && 0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::is_alternative_payment(arg0)) {
            0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::deposit_deep_fee(arg0, 0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::withdraw_refund_deep(arg0, v1 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v0), arg10));
        } else {
            0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::deposit_deep_fee(arg0, 0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::withdraw_refund_deep(arg0, v1, arg10));
        };
        (0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::withdraw_all<T0>(arg0, arg10), 0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::withdraw_all<T1>(arg0, arg10))
    }

    public fun send_or_destory_zero_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun swap_a2b_<T0, T1>(arg0: &mut 0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg1, v0, arg4);
        let v4 = 0;
        let v5 = if (v3 > 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3)) {
            let v6 = v3 - 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3);
            v4 = v6;
            assert!(0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::is_whitelisted(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1)), 2);
            0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::alternative_payment_deep(arg0, arg3, v6, arg5)
        } else {
            arg3
        };
        let (v7, v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, arg2, v5, 0, arg4, arg5);
        let v10 = v8;
        let v11 = v7;
        let v12 = DeepbookV3InternalSwapEvent{
            pool                 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            amount_in            : v0 - 0x2::coin::value<T0>(&v11),
            amount_out           : 0x2::coin::value<T1>(&v10),
            a2b                  : true,
            by_amount_in         : true,
            deep_fee             : v3,
            alt_payment_deep_fee : v4,
            coin_a               : 0x1::type_name::get<T0>(),
            coin_b               : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<DeepbookV3InternalSwapEvent>(v12);
        (v11, v10, v9)
    }

    public fun swap_b2a_<T0, T1>(arg0: &mut 0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg1, v0, arg4);
        let v4 = 0;
        let v5 = if (v3 > 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3)) {
            let v6 = v3 - 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3);
            v4 = v6;
            assert!(0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::is_whitelisted(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1)), 2);
            0x10c204aed4982592299bb729199e4d2f590b95faf77c935057f75f99fd6c9cd7::global_config::alternative_payment_deep(arg0, arg3, v6, arg5)
        } else {
            arg3
        };
        let (v7, v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, arg2, v5, 0, arg4, arg5);
        let v10 = v8;
        let v11 = v7;
        let v12 = DeepbookV3InternalSwapEvent{
            pool                 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            amount_in            : v0 - 0x2::coin::value<T1>(&v10),
            amount_out           : 0x2::coin::value<T0>(&v11),
            a2b                  : false,
            by_amount_in         : true,
            deep_fee             : v3,
            alt_payment_deep_fee : v4,
            coin_a               : 0x1::type_name::get<T0>(),
            coin_b               : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<DeepbookV3InternalSwapEvent>(v12);
        (v11, v10, v9)
    }

    // decompiled from Move bytecode v6
}

