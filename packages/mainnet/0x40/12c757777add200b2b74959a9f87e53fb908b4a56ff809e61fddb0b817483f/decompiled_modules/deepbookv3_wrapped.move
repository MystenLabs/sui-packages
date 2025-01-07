module 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::deepbookv3_wrapped {
    struct TurbosBalanceManagerIndexer has store, key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<address, 0x2::linked_table::LinkedTable<0x2::object::ID, bool>>,
        size: u64,
    }

    struct InitEvent has copy, drop, store {
        turbos_balance_manager_indexer_id: 0x2::object::ID,
    }

    struct CreateTurbosBalanceManagerEvent has copy, drop, store {
        turbos_balance_manager_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        owner: address,
    }

    struct GetTurbosBalanceManagerList has copy, drop, store {
        owner: address,
        list: vector<0x2::object::ID>,
    }

    struct SponsoredEvent has copy, drop {
        pool_id: 0x2::object::ID,
        base_for_quote: bool,
        deep_amount: u64,
        fee_amount: u64,
        base_out_amount: u64,
        quote_out_amount: u64,
    }

    struct PlaceLimitOrderEvent has copy, drop, store {
        turbos_balance_manager_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
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
        advance_fees: u64,
        epoch: u64,
        fee_is_deep: bool,
        status: u8,
        fee_amount: u64,
    }

    struct PlaceMarketOrderEvent has copy, drop, store {
        turbos_balance_manager_id: 0x2::object::ID,
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
        fee_amount: u64,
    }

    struct CancelOrderEvent has copy, drop, store {
        turbos_balance_manager_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        order_id: u128,
        client_order_id: u64,
        trader: address,
        price: u64,
        timestamp: u64,
        base_asset_original_quantity: u128,
        base_asset_maker_quantity: u128,
        base_asset_quantity_canceled: u128,
        maker_fees: u128,
        refund_fees: u64,
        fee_is_deep: bool,
    }

    struct DEEPBOOKV3_WRAPPED has drop {
        dummy_field: bool,
    }

    public fun cancel_order<T0, T1>(arg0: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::GlobalConfig, arg1: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::TurbosBalanceManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::checked_package_version(arg0);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_order<T0, T1>(arg2, arg3);
        let v1 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(&v0) as u128);
        let v2 = v1 - (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(&v0) as u128);
        let v3 = 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::get_order_paid_fees(arg1, arg3);
        let v4 = (0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::get_order_maker_fee(v3) as u128);
        if (v4 > 0) {
            let v5 = (0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::get_order_maker_quantity(v3) as u128);
            let v6 = ((v2 * 1000000000 * v4 / v5 / 1000000000) as u64);
            let v7 = v6;
            if (v2 * 1000000000 * v4 % v5 / 1000000000 > 0) {
                v7 = v6 - 1;
            };
            0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::cancel_order<T0, T1>(arg1, arg2, arg3, arg4, arg5);
            if (v7 > 0) {
                0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::deposit_deep_fee(arg0, 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::withdraw_refund_deep<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, v7, arg5));
            };
            let v8 = CancelOrderEvent{
                turbos_balance_manager_id    : 0x2::object::id<0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::TurbosBalanceManager>(arg1),
                balance_manager_id           : 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::balance_manager_id(arg1),
                pool_id                      : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
                order_id                     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(&v0),
                client_order_id              : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::client_order_id(&v0),
                trader                       : 0x2::tx_context::sender(arg5),
                price                        : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(&v0),
                timestamp                    : 0x2::clock::timestamp_ms(arg4),
                base_asset_original_quantity : v1,
                base_asset_maker_quantity    : v5,
                base_asset_quantity_canceled : v2,
                maker_fees                   : v4,
                refund_fees                  : v7,
                fee_is_deep                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::fee_is_deep(&v0),
            };
            0x2::event::emit<CancelOrderEvent>(v8);
        } else {
            0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::cancel_order<T0, T1>(arg1, arg2, arg3, arg4, arg5);
            let v9 = CancelOrderEvent{
                turbos_balance_manager_id    : 0x2::object::id<0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::TurbosBalanceManager>(arg1),
                balance_manager_id           : 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::balance_manager_id(arg1),
                pool_id                      : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
                order_id                     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::order_id(&v0),
                client_order_id              : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::client_order_id(&v0),
                trader                       : 0x2::tx_context::sender(arg5),
                price                        : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(&v0),
                timestamp                    : 0x2::clock::timestamp_ms(arg4),
                base_asset_original_quantity : v1,
                base_asset_maker_quantity    : 0,
                base_asset_quantity_canceled : v2,
                maker_fees                   : v4,
                refund_fees                  : 0,
                fee_is_deep                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::fee_is_deep(&v0),
            };
            0x2::event::emit<CancelOrderEvent>(v9);
        };
    }

    fun check_and_add_balance_manager_indexer(arg0: &mut TurbosBalanceManagerIndexer, arg1: &0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::TurbosBalanceManager, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::id<0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::TurbosBalanceManager>(arg1);
        if (0x2::table::contains<address, 0x2::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.table, v0)) {
            let v2 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.table, v0);
            if (!0x2::linked_table::contains<0x2::object::ID, bool>(v2, v1)) {
                0x2::linked_table::push_back<0x2::object::ID, bool>(v2, v1, true);
            };
        } else {
            let v3 = 0x2::linked_table::new<0x2::object::ID, bool>(arg2);
            0x2::linked_table::push_back<0x2::object::ID, bool>(&mut v3, v1, true);
            0x2::table::add<address, 0x2::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.table, v0, v3);
            arg0.size = arg0.size + 1;
        };
    }

    fun check_and_delete_balance_manager_indexer(arg0: &mut TurbosBalanceManagerIndexer, arg1: &0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::TurbosBalanceManager, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::id<0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::TurbosBalanceManager>(arg1);
        if (0x2::table::contains<address, 0x2::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.table, v0)) {
            let v2 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.table, v0);
            if (0x2::linked_table::contains<0x2::object::ID, bool>(v2, v1)) {
                0x2::linked_table::remove<0x2::object::ID, bool>(v2, v1);
            };
        };
    }

    public fun check_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 2);
    }

    fun collect_protocol_fee<T0>(arg0: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::GlobalConfig, arg1: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::TurbosBalanceManager, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::get_protocol_fee_rate(arg0, arg2);
        if (v0 == 0) {
            return (arg3, 0)
        };
        let v1 = 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::math::mul_div_ceil(arg3, v0, 1000000);
        0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::deposit_protocol_fee<T0>(arg0, arg2, 0x2::coin::into_balance<T0>(0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::withdraw<T0>(arg1, v1, arg4)));
        (arg3 - v1, v1)
    }

    fun collect_protocol_fee_without_manager<T0>(arg0: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::GlobalConfig, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, u64) {
        let v0 = 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::get_protocol_fee_rate(arg0, arg1);
        if (v0 == 0) {
            return (arg2, arg3, 0)
        };
        let v1 = 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::math::mul_div_ceil(arg3, v0, 1000000);
        0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::deposit_protocol_fee<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v1, arg4)));
        (arg2, arg3 - v1, v1)
    }

    public fun create_deposit_then_place_limit_order<T0, T1>(arg0: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::GlobalConfig, arg1: &mut TurbosBalanceManagerIndexer, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u8, arg7: u8, arg8: u64, arg9: u64, arg10: bool, arg11: bool, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::checked_package_version(arg0);
        let v0 = 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::new(arg14);
        check_and_add_balance_manager_indexer(arg1, &v0, arg14);
        let v1 = &mut v0;
        deposit_then_place_limit_order_by_owner<T0, T1>(arg0, arg1, arg2, v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::share(v0);
    }

    public fun create_deposit_then_place_market_order<T0, T1>(arg0: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::GlobalConfig, arg1: &mut TurbosBalanceManagerIndexer, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u8, arg6: u64, arg7: bool, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::checked_package_version(arg0);
        let v0 = 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::new(arg10);
        let v1 = &mut v0;
        let (v2, v3) = deposit_then_place_market_order_by_owner<T0, T1>(arg0, arg1, arg2, v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        check_and_delete_balance_manager_indexer(arg1, &v0, arg10);
        0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x2::tx_context::sender(arg10));
    }

    public fun create_deposit_then_place_market_order_with_return<T0, T1>(arg0: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::GlobalConfig, arg1: &mut TurbosBalanceManagerIndexer, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u8, arg6: u64, arg7: bool, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::checked_package_version(arg0);
        let v0 = 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::new(arg10);
        let v1 = &mut v0;
        let (v2, v3) = deposit_then_place_market_order_by_owner<T0, T1>(arg0, arg1, arg2, v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        check_and_delete_balance_manager_indexer(arg1, &v0, arg10);
        0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::delete(v0);
        (v2, v3)
    }

    public fun create_turbos_balance_manager(arg0: &mut TurbosBalanceManagerIndexer, arg1: &mut 0x2::tx_context::TxContext) : 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::TurbosBalanceManager {
        let v0 = 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::new(arg1);
        check_and_add_balance_manager_indexer(arg0, &v0, arg1);
        let v1 = CreateTurbosBalanceManagerEvent{
            turbos_balance_manager_id : 0x2::object::id<0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::TurbosBalanceManager>(&v0),
            balance_manager_id        : 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::balance_manager_id(&v0),
            owner                     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CreateTurbosBalanceManagerEvent>(v1);
        v0
    }

    public fun deposit_then_place_limit_order_by_owner<T0, T1>(arg0: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::GlobalConfig, arg1: &mut TurbosBalanceManagerIndexer, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::TurbosBalanceManager, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u8, arg8: u8, arg9: u64, arg10: u64, arg11: bool, arg12: bool, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::checked_package_version(arg0);
        check_and_add_balance_manager_indexer(arg1, arg3, arg15);
        if (arg11) {
            0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::deposit<T1>(arg3, arg6, arg15);
            send_or_destory_zero_coin<T0>(arg5, arg15);
        } else {
            0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::deposit<T0>(arg3, arg5, arg15);
            send_or_destory_zero_coin<T1>(arg6, arg15);
        };
        place_limit_order<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    public(friend) fun deposit_then_place_market_order_by_owner<T0, T1>(arg0: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::GlobalConfig, arg1: &mut TurbosBalanceManagerIndexer, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::TurbosBalanceManager, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u8, arg7: u64, arg8: bool, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        check_and_add_balance_manager_indexer(arg1, arg3, arg11);
        if (arg8) {
            0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::deposit<T1>(arg3, arg5, arg11);
            send_or_destory_zero_coin<T0>(arg4, arg11);
        } else {
            0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::deposit<T0>(arg3, arg4, arg11);
            send_or_destory_zero_coin<T1>(arg5, arg11);
        };
        place_market_order_once<T0, T1>(arg0, arg2, arg3, arg6, arg7, arg8, arg9, arg10, arg11);
        (0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::withdraw_all<T0>(arg3, arg11), 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::withdraw_all<T1>(arg3, arg11))
    }

    public fun get_balance_managers_by_owner(arg0: &TurbosBalanceManagerIndexer, arg1: address) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        if (0x2::table::contains<address, 0x2::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.table, arg1)) {
            let v1 = 0x2::table::borrow<address, 0x2::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.table, arg1);
            let v2 = 0x2::linked_table::front<0x2::object::ID, bool>(v1);
            while (0x1::option::is_some<0x2::object::ID>(v2)) {
                let v3 = *0x1::option::borrow<0x2::object::ID>(v2);
                0x1::vector::push_back<0x2::object::ID>(&mut v0, v3);
                v2 = 0x2::linked_table::next<0x2::object::ID, bool>(v1, v3);
            };
        };
        let v4 = GetTurbosBalanceManagerList{
            owner : arg1,
            list  : v0,
        };
        0x2::event::emit<GetTurbosBalanceManagerList>(v4);
    }

    fun init(arg0: DEEPBOOKV3_WRAPPED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TurbosBalanceManagerIndexer{
            id    : 0x2::object::new(arg1),
            table : 0x2::table::new<address, 0x2::linked_table::LinkedTable<0x2::object::ID, bool>>(arg1),
            size  : 0,
        };
        let v1 = InitEvent{turbos_balance_manager_indexer_id: 0x2::object::id<TurbosBalanceManagerIndexer>(&v0)};
        0x2::event::emit<InitEvent>(v1);
        0x2::transfer::share_object<TurbosBalanceManagerIndexer>(v0);
    }

    public fun place_limit_order<T0, T1>(arg0: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::GlobalConfig, arg1: &mut TurbosBalanceManagerIndexer, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::TurbosBalanceManager, arg4: u64, arg5: u8, arg6: u8, arg7: u64, arg8: u64, arg9: bool, arg10: bool, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::checked_package_version(arg0);
        check_and_add_balance_manager_indexer(arg1, arg3, arg13);
        0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::deposit_advance_deep(arg3, arg0, arg13);
        let v0 = 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::place_limit_order<T0, T1>(arg3, arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v0) + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::maker_fees(&v0);
        if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(&v0)) {
            0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::deposit_deep_fee(arg0, 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::withdraw_refund_deep<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::advance_amount(arg0) - v1, arg13));
        } else {
            0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::deposit_deep_fee(arg0, 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::withdraw_refund_deep<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::advance_amount(arg0), arg13));
        };
        let v2 = PlaceLimitOrderEvent{
            turbos_balance_manager_id : 0x2::object::id<0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::TurbosBalanceManager>(arg3),
            balance_manager_id        : 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::balance_manager_id(arg3),
            pool_id                   : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2),
            order_id                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(&v0),
            client_order_id           : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::client_order_id(&v0),
            trader                    : 0x2::tx_context::sender(arg13),
            price                     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::price(&v0),
            quantity                  : arg8,
            is_bid                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(&v0),
            expire_timestamp          : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::expire_timestamp(&v0),
            order_type                : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_type(&v0),
            self_matching_option      : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::self_matching_option(&v0),
            original_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(&v0),
            executed_quantity         : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(&v0),
            cumulative_quote_quantity : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::cumulative_quote_quantity(&v0),
            paid_fees                 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v0),
            maker_fees                : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::maker_fees(&v0),
            advance_fees              : v1,
            epoch                     : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::epoch(&v0),
            fee_is_deep               : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(&v0),
            status                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::status(&v0),
            fee_amount                : 0,
        };
        0x2::event::emit<PlaceLimitOrderEvent>(v2);
    }

    public(friend) fun place_market_order_once<T0, T1>(arg0: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::TurbosBalanceManager, arg3: u8, arg4: u64, arg5: bool, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::deposit_advance_deep(arg2, arg0, arg8);
        let v0 = 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::place_market_order<T0, T1>(arg2, arg1, arg4, arg3, 0x2::clock::timestamp_ms(arg7), arg5, arg6, arg7, arg8);
        if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(&v0)) {
            0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::deposit_deep_fee(arg0, 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::withdraw_refund_deep<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::advance_amount(arg0) - 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::paid_fees(&v0), arg8));
        } else {
            0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::deposit_deep_fee(arg0, 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::withdraw_refund_deep<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::advance_amount(arg0), arg8));
        };
        let v1 = PlaceMarketOrderEvent{
            turbos_balance_manager_id : 0x2::object::id<0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::TurbosBalanceManager>(arg2),
            balance_manager_id        : 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::turbos_balance_manager::balance_manager_id(arg2),
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
            fee_is_deep               : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::fee_is_deep(&v0),
            status                    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::status(&v0),
            fee_amount                : 0,
        };
        0x2::event::emit<PlaceMarketOrderEvent>(v1);
    }

    public fun send_or_destory_zero_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun swap_exact_base_for_quote_sponsored<T0, T1>(arg0: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::checked_package_version(arg0);
        0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1);
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg1, 0x2::coin::value<T0>(&arg2), arg4);
        let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, arg2, 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::withdraw_deep(arg0, v2, arg5), arg3, arg4, arg5);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        assert!(0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v6) == 0, 1);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v6);
        let v9 = SponsoredEvent{
            pool_id          : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            base_for_quote   : true,
            deep_amount      : v2,
            fee_amount       : 0,
            base_out_amount  : 0x2::coin::value<T0>(&v8),
            quote_out_amount : 0x2::coin::value<T1>(&v7),
        };
        0x2::event::emit<SponsoredEvent>(v9);
        (v8, v7)
    }

    public fun swap_exact_quote_for_base_sponsored<T0, T1>(arg0: &mut 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::checked_package_version(arg0);
        0x2::object::id_address<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1);
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg1, 0x2::coin::value<T1>(&arg2), arg4);
        let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, arg2, 0x4012c757777add200b2b74959a9f87e53fb908b4a56ff809e61fddb0b817483f::global_config::withdraw_deep(arg0, v2, arg5), arg3, arg4, arg5);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        assert!(0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v6) == 0, 1);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v6);
        let v9 = SponsoredEvent{
            pool_id          : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1),
            base_for_quote   : false,
            deep_amount      : v2,
            fee_amount       : 0,
            base_out_amount  : 0x2::coin::value<T0>(&v8),
            quote_out_amount : 0x2::coin::value<T1>(&v7),
        };
        0x2::event::emit<SponsoredEvent>(v9);
        (v8, v7)
    }

    // decompiled from Move bytecode v6
}

