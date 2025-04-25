module 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::deepbook_v3 {
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

    public fun place_market_order<T0, T1>(arg0: &mut 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: u8, arg6: u64, arg7: bool, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo) {
        abort 0
    }

    public fun place_market_order_by_bssm<T0, T1>(arg0: &mut 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u8, arg7: u64, arg8: bool, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo) {
        abort 0
    }

    public fun place_market_order_v2<T0, T1>(arg0: &mut 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u8, arg7: u64, arg8: bool, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::checked_package_version(arg0);
        let v0 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg5);
        if (arg8) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, 0x2::coin::split<T1>(&mut arg4, 0x2::coin::value<T1>(&arg4), arg11), arg11);
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, 0x2::coin::split<T0>(&mut arg3, 0x2::coin::value<T0>(&arg3), arg11), arg11);
        };
        let v1 = 0;
        let v2 = v0;
        let v3 = if (arg9) {
            if (v0 >= 0) {
                v0 < 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::alternative_payment_amount(arg0)
            } else {
                false
            }
        } else {
            false
        };
        if (v3) {
            let v4 = 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::alternative_payment_amount(arg0) - v0;
            v1 = v4;
            let v5 = 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::alternative_payment_deep(arg0, arg5, v4, arg11);
            v2 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v5);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, v5, arg11);
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, arg5, arg11);
        };
        let v6 = arg9 && v2 > 0;
        let v7 = 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::place_market_order_by_user_bm<T0, T1>(arg1, arg2, 1107, arg6, arg7, arg8, v6, arg10, arg11);
        if (v1 > 0) {
            0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::deposit_deep_fee(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, v1 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v7), arg11));
        };
        0x2::coin::join<T0>(&mut arg3, 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::withdraw_all<T0>(arg0, arg11));
        0x2::coin::join<T1>(&mut arg4, 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::withdraw_all<T1>(arg0, arg11));
        let v8 = PlaceMarktetOrderEvent{
            balance_manager_id        : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1),
            pool_id                   : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            order_id                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v7),
            client_order_id           : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::client_order_id(&v7),
            trader                    : 0x2::tx_context::sender(arg11),
            quantity                  : arg7,
            is_bid                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(&v7),
            self_matching_option      : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::self_matching_option(&v7),
            original_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v7),
            executed_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v7),
            cumulative_quote_quantity : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v7),
            paid_fees                 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v7),
            epoch                     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::epoch(&v7),
            fee_is_deep               : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(&v7),
            status                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::status(&v7),
            alt_payment_deep_fee      : v1,
        };
        0x2::event::emit<PlaceMarktetOrderEvent>(v8);
        (arg3, arg4, 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::withdraw_all<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, arg11))
    }

    public fun place_market_order_v3<T0, T1>(arg0: &mut 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u8, arg7: u64, arg8: bool, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::checked_package_version(arg0);
        let v0 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, arg4, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, arg3, arg11);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v1 = 0;
        let v2 = v0;
        let v3 = if (arg9) {
            if (v0 >= 0) {
                v0 < 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::alternative_payment_amount(arg0)
            } else {
                false
            }
        } else {
            false
        };
        if (v3) {
            let v4 = 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::alternative_payment_amount(arg0) - v0;
            v1 = v4;
            let v5 = 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::alternative_payment_deep(arg0, arg5, v4, arg11);
            v2 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v5);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, v5, arg11);
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, arg5, arg11);
        };
        let v6 = arg9 && v2 > 0;
        let v7 = 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::place_market_order_by_user_bm<T0, T1>(arg1, arg2, 1107, arg6, arg7, arg8, v6, arg10, arg11);
        if (v1 > 0) {
            0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::deposit_deep_fee(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, v1 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v7), arg11));
        };
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v8 = PlaceMarktetOrderEvent{
            balance_manager_id        : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1),
            pool_id                   : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            order_id                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v7),
            client_order_id           : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::client_order_id(&v7),
            trader                    : 0x2::tx_context::sender(arg11),
            quantity                  : arg7,
            is_bid                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(&v7),
            self_matching_option      : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::self_matching_option(&v7),
            original_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v7),
            executed_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v7),
            cumulative_quote_quantity : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v7),
            paid_fees                 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v7),
            epoch                     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::epoch(&v7),
            fee_is_deep               : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(&v7),
            status                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::status(&v7),
            alt_payment_deep_fee      : v1,
        };
        0x2::event::emit<PlaceMarktetOrderEvent>(v8);
    }

    public fun place_market_order_v4<T0, T1>(arg0: &mut 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u8, arg7: u64, arg8: bool, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun place_market_order_v5<T0, T1>(arg0: &mut 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u8, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::checked_package_version(arg0);
        let v0 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, arg4, arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, arg3, arg12);
        let v1 = 0;
        let v2 = v0;
        let v3 = if (arg9) {
            if (v0 >= 0) {
                v0 < 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::alternative_payment_amount(arg0)
            } else {
                false
            }
        } else {
            false
        };
        if (v3) {
            let v4 = 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::alternative_payment_amount(arg0) - v0;
            v1 = v4;
            let v5 = 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::alternative_payment_deep(arg0, arg5, v4, arg12);
            v2 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v5);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, v5, arg12);
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, arg5, arg12);
        };
        let v6 = arg9 && v2 > 0;
        let v7 = 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::place_market_order_by_user_bm<T0, T1>(arg1, arg2, 1107, arg6, arg7, arg8, v6, arg11, arg12);
        if (v1 > 0) {
            0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::deposit_deep_fee(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, v1 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v7), arg12));
        };
        if (arg8) {
            assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1) >= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1) + arg10, 3);
        } else {
            assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1) >= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1) + arg10, 3);
        };
        let v8 = PlaceMarktetOrderEvent{
            balance_manager_id        : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1),
            pool_id                   : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            order_id                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v7),
            client_order_id           : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::client_order_id(&v7),
            trader                    : 0x2::tx_context::sender(arg12),
            quantity                  : arg7,
            is_bid                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(&v7),
            self_matching_option      : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::self_matching_option(&v7),
            original_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v7),
            executed_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v7),
            cumulative_quote_quantity : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v7),
            paid_fees                 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v7),
            epoch                     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::epoch(&v7),
            fee_is_deep               : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(&v7),
            status                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::status(&v7),
            alt_payment_deep_fee      : v1,
        };
        0x2::event::emit<PlaceMarktetOrderEvent>(v8);
    }

    public fun send_or_destory_zero_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun swap_a2b_<T0, T1>(arg0: &mut 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::checked_package_version(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg1, v0, arg4);
        let v4 = 0;
        let v5 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3);
        let v6 = if (v3 > v5) {
            let v7 = v3 - v5;
            v4 = v7;
            0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::alternative_payment_deep(arg0, arg3, v7, arg5)
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
            coin_a               : 0x1::type_name::get<T0>(),
            coin_b               : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<DeepbookV3InternalSwapEvent>(v15);
        (v14, v13, v12)
    }

    public fun swap_b2a_<T0, T1>(arg0: &mut 0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::checked_package_version(arg0);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg1, v0, arg4);
        let v4 = 0;
        let v5 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3);
        let v6 = if (v3 > v5) {
            let v7 = v3 - v5;
            v4 = v7;
            0x18eb3999327614f2c5287df3b7af825e349a6b45978aad1e466b0230113887ce::global_config::alternative_payment_deep(arg0, arg3, v7, arg5)
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
            coin_a               : 0x1::type_name::get<T0>(),
            coin_b               : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<DeepbookV3InternalSwapEvent>(v15);
        (v14, v13, v12)
    }

    // decompiled from Move bytecode v6
}

