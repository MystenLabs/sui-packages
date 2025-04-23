module 0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::deepbook_v3 {
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

    struct PlaceMarktetOrderEvent has copy, drop, store {
        balance_manager_id: 0x2::object::ID,
        trade_cap_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        order_id: u128,
        client_order_id: u64,
        trader: address,
        quantity: u64,
        is_bid: bool,
        self_matching_option: u8,
        original_quantity: u64,
        executed_quantity: u64,
        cumulative_quote_quantity: u64,
        paid_fees: u64,
        epoch: u64,
        fee_is_deep: bool,
        status: u8,
        alt_payment_deep_fee: u64,
    }

    public fun place_market_order<T0, T1>(arg0: &mut 0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: u8, arg6: u64, arg7: bool, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo) {
        0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::checked_package_version(arg0);
        let v0 = if (arg7) {
            0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::deposit<T1>(arg0, 0x2::coin::split<T1>(&mut arg3, 0x2::coin::value<T1>(&arg3), arg10), arg10);
            let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg1, arg6, arg9);
            v3
        } else {
            0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::deposit<T0>(arg0, 0x2::coin::split<T0>(&mut arg2, 0x2::coin::value<T0>(&arg2), arg10), arg10);
            let (_, _, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg1, arg6, arg9);
            v6
        };
        let v7 = 0;
        let v8 = v7;
        let v9 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg4);
        let v10 = if (v0 > v9) {
            let v11 = 0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::alternative_payment_deep(arg0, arg4, v7, arg10);
            v8 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v11) - v9;
            0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, v11, arg10);
            true
        } else {
            0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, arg4, arg10);
            false
        };
        let v12 = 0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::place_market_order_by_trader<T0, T1>(arg0, arg1, 1107, arg5, arg6, arg7, v10, arg9, arg10);
        0x2::coin::join<T1>(&mut arg3, 0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::withdraw_all<T1>(arg0, arg10));
        0x2::coin::join<T0>(&mut arg2, 0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::withdraw_all<T0>(arg0, arg10));
        let v13 = PlaceMarktetOrderEvent{
            balance_manager_id        : 0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::balance_manager_id(arg0),
            trade_cap_id              : 0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::trade_cap_id(arg0),
            pool_id                   : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            order_id                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v12),
            client_order_id           : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::client_order_id(&v12),
            trader                    : 0x2::tx_context::sender(arg10),
            quantity                  : arg6,
            is_bid                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(&v12),
            self_matching_option      : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::self_matching_option(&v12),
            original_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v12),
            executed_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v12),
            cumulative_quote_quantity : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v12),
            paid_fees                 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v12),
            epoch                     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::epoch(&v12),
            fee_is_deep               : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(&v12),
            status                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::status(&v12),
            alt_payment_deep_fee      : v8,
        };
        0x2::event::emit<PlaceMarktetOrderEvent>(v13);
        (arg2, arg3, v12)
    }

    public fun place_market_order_by_bssm<T0, T1>(arg0: &mut 0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u8, arg7: u64, arg8: bool, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo) {
        abort 0
    }

    public fun send_or_destory_zero_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun swap_a2b_<T0, T1>(arg0: &mut 0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::checked_package_version(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg1, v0, arg4);
        let v4 = 0;
        let v5 = v4;
        let v6 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3);
        let v7 = if (v3 > v6) {
            let v8 = 0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::alternative_payment_deep(arg0, arg3, v4, arg5);
            v5 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v8) - v6;
            v8
        } else {
            arg3
        };
        let v9 = v7;
        let (v10, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, arg2, v9, 0, arg4, arg5);
        let v13 = v12;
        let v14 = v11;
        let v15 = v10;
        let v16 = DeepbookV3InternalSwapEvent{
            pool                 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            amount_in            : v0 - 0x2::coin::value<T0>(&v15),
            amount_out           : 0x2::coin::value<T1>(&v14),
            a2b                  : true,
            by_amount_in         : true,
            deep_fee             : 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v9) - 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v13),
            alt_payment_deep_fee : v5,
            coin_a               : 0x1::type_name::get<T0>(),
            coin_b               : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<DeepbookV3InternalSwapEvent>(v16);
        (v15, v14, v13)
    }

    public fun swap_b2a_<T0, T1>(arg0: &mut 0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::checked_package_version(arg0);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg1, v0, arg4);
        let v4 = 0;
        let v5 = v4;
        let v6 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3);
        let v7 = if (v3 > v6) {
            let v8 = 0x45f329c053ff43ac12aa29eb5013702c046c90ed852028fa87f6627f6cc807a1::global_config::alternative_payment_deep(arg0, arg3, v4, arg5);
            v5 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v8) - v6;
            v8
        } else {
            arg3
        };
        let v9 = v7;
        let (v10, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, arg2, v9, 0, arg4, arg5);
        let v13 = v12;
        let v14 = v11;
        let v15 = v10;
        let v16 = DeepbookV3InternalSwapEvent{
            pool                 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            amount_in            : v0 - 0x2::coin::value<T1>(&v14),
            amount_out           : 0x2::coin::value<T0>(&v15),
            a2b                  : false,
            by_amount_in         : true,
            deep_fee             : 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v9) - 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v13),
            alt_payment_deep_fee : v5,
            coin_a               : 0x1::type_name::get<T0>(),
            coin_b               : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<DeepbookV3InternalSwapEvent>(v16);
        (v15, v14, v13)
    }

    // decompiled from Move bytecode v6
}

