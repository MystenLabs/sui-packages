module 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::deepbookv3_utils {
    struct PlaceLimitOrderEvent has copy, drop, store {
        deepbook_balance_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        order_id: u128,
        client_order_id: u64,
        trader: address,
        price: u64,
        quantity: u64,
        is_bid: bool,
        expire_timestamp: u64,
        order_type: u8,
        self_matching_option: u8,
        original_quantity: u64,
        executed_quantity: u64,
        cumulative_quote_quantity: u64,
        paid_fees: u64,
        maker_fees: u64,
        epoch: u64,
        fee_is_deep: bool,
        status: u8,
    }

    struct PlaceMarktetOrderEvent has copy, drop, store {
        cetus_balance_manager_id: 0x2::object::ID,
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
    }

    struct CancelOrderEvent has copy, drop, store {
        deepbook_balance_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        order_id: u128,
        client_order_id: u64,
        trader: address,
        price: u64,
        timestamp: u64,
        base_asset_original_quantity: u64,
        base_asset_maker_quantity: u64,
        base_asset_quantity_canceled: u64,
        refund_fees: u64,
        fee_is_deep: bool,
    }

    public fun cancel_order<T0, T1>(arg0: &mut 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::global_config::checked_package_version(arg0);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg2, arg3);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(&v0);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg2, arg1, &v2, arg3, arg4, arg5);
        let v3 = CancelOrderEvent{
            deepbook_balance_manager_id  : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1),
            pool_id                      : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            order_id                     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(&v0),
            client_order_id              : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::client_order_id(&v0),
            trader                       : 0x2::tx_context::sender(arg5),
            price                        : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(&v0),
            timestamp                    : 0x2::clock::timestamp_ms(arg4),
            base_asset_original_quantity : v1,
            base_asset_maker_quantity    : 0,
            base_asset_quantity_canceled : v1 - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v0),
            refund_fees                  : 0,
            fee_is_deep                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::fee_is_deep(&v0),
        };
        0x2::event::emit<CancelOrderEvent>(v3);
    }

    public fun place_limit_order<T0, T1>(arg0: &mut 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::global_config::GlobalConfig, arg1: &mut 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::CetusBalanceManagerIndexer, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::global_config::checked_package_version(arg0);
        0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::check_and_add_deepbook_balance_manager_indexer(arg1, arg3, arg12);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg12);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg2, arg3, &v0, 1107, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v2 = PlaceLimitOrderEvent{
            deepbook_balance_manager_id : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg3),
            pool_id                     : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            order_id                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v1),
            client_order_id             : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::client_order_id(&v1),
            trader                      : 0x2::tx_context::sender(arg12),
            price                       : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::price(&v1),
            quantity                    : arg7,
            is_bid                      : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(&v1),
            expire_timestamp            : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::expire_timestamp(&v1),
            order_type                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_type(&v1),
            self_matching_option        : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::self_matching_option(&v1),
            original_quantity           : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v1),
            executed_quantity           : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v1),
            cumulative_quote_quantity   : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v1),
            paid_fees                   : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v1),
            maker_fees                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::maker_fees(&v1),
            epoch                       : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::epoch(&v1),
            fee_is_deep                 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(&v1),
            status                      : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::status(&v1),
        };
        0x2::event::emit<PlaceLimitOrderEvent>(v2);
    }

    public fun check_coin_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    public fun create_deposit_then_place_limit_order<T0, T1>(arg0: &mut 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::global_config::GlobalConfig, arg1: &mut 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::CetusBalanceManagerIndexer, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u8, arg7: u8, arg8: u64, arg9: u64, arg10: bool, arg11: bool, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg14);
        let v1 = &mut v0;
        deposit_then_place_limit_order_by_owner<T0, T1>(arg0, arg1, arg2, v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        0x2::transfer::public_share_object<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(v0);
    }

    public fun create_deposit_then_place_market_order<T0, T1>(arg0: &mut 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::global_config::GlobalConfig, arg1: &mut 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::CetusBalanceManagerIndexer, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u8, arg7: u64, arg8: bool, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::new(arg11);
        let v1 = &mut v0;
        let (v2, v3) = deposit_then_place_market_order_by_owner<T0, T1>(arg0, arg1, arg2, v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x2::tx_context::sender(arg11));
    }

    public fun create_deposit_then_place_market_order_return_coins<T0, T1>(arg0: &mut 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::global_config::GlobalConfig, arg1: &mut 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::CetusBalanceManagerIndexer, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u8, arg7: u64, arg8: bool, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::new(arg11);
        let v1 = &mut v0;
        let (v2, v3) = deposit_then_place_market_order_by_owner<T0, T1>(arg0, arg1, arg2, v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::delete(v0);
        (v2, v3)
    }

    public fun deposit_then_place_limit_order_by_owner<T0, T1>(arg0: &mut 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::global_config::GlobalConfig, arg1: &mut 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::CetusBalanceManagerIndexer, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg7: u8, arg8: u8, arg9: u64, arg10: u64, arg11: bool, arg12: bool, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::check_and_add_deepbook_balance_manager_indexer(arg1, arg3, arg15);
        if (arg11) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg3, arg5, arg15);
            send_or_destory_zero_coin<T0>(arg4, arg15);
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg3, arg4, arg15);
            send_or_destory_zero_coin<T1>(arg5, arg15);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg6) > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, arg6, arg15);
        } else {
            send_or_destory_zero_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6, arg15);
        };
        place_limit_order<T0, T1>(arg0, arg1, arg2, arg3, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public fun deposit_then_place_market_order_by_owner<T0, T1>(arg0: &mut 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::global_config::GlobalConfig, arg1: &mut 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::CetusBalanceManagerIndexer, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::CetusBalanceManager, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg7: u8, arg8: u64, arg9: bool, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::check_and_add_cetus_balance_manager_indexer(arg1, arg3, arg12);
        if (arg9) {
            0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::deposit<T1>(arg3, arg5, arg12);
            send_or_destory_zero_coin<T0>(arg4, arg12);
        } else {
            0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::deposit<T0>(arg3, arg4, arg12);
            send_or_destory_zero_coin<T1>(arg5, arg12);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg6) > 0) {
            0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, arg6, arg12);
        } else {
            send_or_destory_zero_coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6, arg12);
        };
        place_market_order_once<T0, T1>(arg0, arg2, arg3, arg7, arg8, arg9, arg10, arg11, arg12);
        (0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::withdraw_all<T0>(arg3, arg12), 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::withdraw_all<T1>(arg3, arg12))
    }

    public(friend) fun place_market_order_once<T0, T1>(arg0: &mut 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::CetusBalanceManager, arg3: u8, arg4: u64, arg5: bool, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::global_config::checked_package_version(arg0);
        0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::deposit_proxy_deep(arg2, arg0, arg8);
        let v0 = 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::place_market_order<T0, T1>(arg2, arg1, 1107, arg3, arg4, arg5, arg6, arg7, arg8);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(&v0);
        if (v1 && 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::global_config::advance_deep_fee(arg0)) {
            0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::global_config::deposit_deep_fee(arg0, 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::withdraw_refund_deep<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::global_config::advance_amount(arg0) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v0), arg8));
        } else {
            0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::global_config::deposit_deep_fee(arg0, 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::withdraw_refund_deep<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::global_config::advance_amount(arg0), arg8));
        };
        let v2 = PlaceMarktetOrderEvent{
            cetus_balance_manager_id  : 0x2::object::id<0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::CetusBalanceManager>(arg2),
            balance_manager_id        : 0xade998d24db74df75d96646e1ce7bb996587ce28747b4db600b5ccd82e00cb5a::cetus_balance_manager::balance_manager_id(arg2),
            pool_id                   : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            order_id                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v0),
            client_order_id           : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::client_order_id(&v0),
            trader                    : 0x2::tx_context::sender(arg8),
            quantity                  : arg4,
            is_bid                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(&v0),
            self_matching_option      : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::self_matching_option(&v0),
            original_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v0),
            executed_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v0),
            cumulative_quote_quantity : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v0),
            paid_fees                 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v0),
            epoch                     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::epoch(&v0),
            fee_is_deep               : v1,
            status                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::status(&v0),
        };
        0x2::event::emit<PlaceMarktetOrderEvent>(v2);
    }

    public fun send_or_destory_zero_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

