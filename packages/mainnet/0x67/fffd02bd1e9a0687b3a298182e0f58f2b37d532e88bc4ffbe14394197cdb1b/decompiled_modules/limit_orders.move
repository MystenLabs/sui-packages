module 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders {
    struct InsidexLimitOrder<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        user: address,
        slippage: u64,
        balance_base: 0x2::balance::Balance<T0>,
        balance_quote: 0x2::balance::Balance<T1>,
        target_price_limit_buy: 0x1::option::Option<u64>,
        target_price_take_profit: 0x1::option::Option<u64>,
        target_price_stop_loss: 0x1::option::Option<u64>,
        created_at: u64,
        updated_at: u64,
    }

    struct Promise {
        user: address,
        limit_order_id: 0x2::object::ID,
        trade_type: u8,
        min_amount_to_repay: u64,
    }

    public(friend) fun assert_limit_order_belongs_to_user<T0, T1>(arg0: &InsidexLimitOrder<T0, T1>, arg1: address) {
        assert!(arg0.user == arg1, 1);
    }

    public(friend) fun borrow_asset_to_execute_order<T0, T1>(arg0: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::TradingManagerCap, arg1: &mut InsidexLimitOrder<T0, T1>, arg2: u8, arg3: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, Promise) {
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_interacting_with_most_up_to_date_package(arg3);
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_address_is_trading_manager(arg0, arg3, arg4);
        let v0 = &mut arg1.balance_base;
        let v1 = 0x2::balance::value<T0>(v0);
        let v2 = 0x2::coin::take<T0>(v0, v1, arg4);
        let v3 = &mut arg1.balance_quote;
        let v4 = 0x2::balance::value<T1>(v3);
        let v5 = 0x2::coin::take<T1>(v3, v4, arg4);
        let v6 = arg1.slippage;
        let v7 = 0;
        if (arg2 == 1) {
            let v8 = &mut arg1.target_price_limit_buy;
            assert!(0x1::option::is_some<u64>(v8) == true, 5);
            v7 = 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::safe_math::safe_mul_div_u64(v4, 1000000000 * (10000 - v6), 10000 * 0x1::option::extract<u64>(v8));
        };
        if (arg2 == 2) {
            let v9 = &mut arg1.target_price_take_profit;
            assert!(0x1::option::is_some<u64>(v9) == true, 6);
            v7 = 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::safe_math::safe_mul_div_u64(v1, 0x1::option::extract<u64>(v9) * (10000 - v6), 10000 * 1000000000);
        };
        if (arg2 == 3) {
            let v10 = &mut arg1.target_price_stop_loss;
            assert!(0x1::option::is_some<u64>(v10) == true, 7);
            v7 = 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::safe_math::safe_mul_div_u64(v1, 0x1::option::extract<u64>(v10) * (10000 - v6), 10000 * 1000000000);
        };
        let v11 = Promise{
            user                : arg1.user,
            limit_order_id      : 0x2::object::id<InsidexLimitOrder<T0, T1>>(arg1),
            trade_type          : arg2,
            min_amount_to_repay : v7,
        };
        (v2, v5, v11)
    }

    public(friend) fun cancel_limit_order<T0, T1>(arg0: InsidexLimitOrder<T0, T1>, arg1: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_interacting_with_most_up_to_date_package(arg1);
        assert_limit_order_belongs_to_user<T0, T1>(&arg0, 0x2::tx_context::sender(arg2));
        let InsidexLimitOrder {
            id                       : v0,
            user                     : _,
            slippage                 : _,
            balance_base             : v3,
            balance_quote            : v4,
            target_price_limit_buy   : _,
            target_price_take_profit : _,
            target_price_stop_loss   : _,
            created_at               : _,
            updated_at               : _,
        } = arg0;
        0x2::object::delete(v0);
        (0x2::coin::from_balance<T0>(v3, arg2), 0x2::coin::from_balance<T1>(v4, arg2))
    }

    public(friend) fun place_limit_order<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_interacting_with_most_up_to_date_package(arg6);
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_quote_asset_is_allowed_for_limit_order(arg6, 0x1::type_name::get<T1>());
        let v0 = 0x1::option::get_with_default<u64>(&arg2, 0);
        let v1 = 0x1::option::get_with_default<u64>(&arg3, 0);
        let v2 = 0x1::option::get_with_default<u64>(&arg4, 0);
        if (v1 == 0 && v2 == 0) {
            assert!(v0 != 0, 2);
        };
        if (v0 == 0) {
            assert!(v1 != 0 || v2 != 0, 2);
        };
        let v3 = InsidexLimitOrder<T0, T1>{
            id                       : 0x2::object::new(arg8),
            user                     : 0x2::tx_context::sender(arg8),
            slippage                 : arg5,
            balance_base             : 0x2::coin::into_balance<T0>(arg0),
            balance_quote            : 0x2::coin::into_balance<T1>(arg1),
            target_price_limit_buy   : arg2,
            target_price_take_profit : arg3,
            target_price_stop_loss   : arg4,
            created_at               : 0x2::clock::timestamp_ms(arg7),
            updated_at               : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::transfer::share_object<InsidexLimitOrder<T0, T1>>(v3);
        0x2::object::id<InsidexLimitOrder<T0, T1>>(&v3)
    }

    public(friend) fun return_asset_after_order_execution<T0, T1>(arg0: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::TradingManagerCap, arg1: InsidexLimitOrder<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: Promise, arg5: u64, arg6: u64, arg7: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, u64, u64, address, 0x2::object::ID, u8, u64) {
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_interacting_with_most_up_to_date_package(arg7);
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_address_is_trading_manager(arg0, arg7, arg8);
        let Promise {
            user                : v0,
            limit_order_id      : v1,
            trade_type          : v2,
            min_amount_to_repay : v3,
        } = arg4;
        assert!(arg1.user == v0, 3);
        assert!(0x2::object::id<InsidexLimitOrder<T0, T1>>(&arg1) == v1, 4);
        let v4 = 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::safe_math::safe_mul_div_u64(0x2::coin::value<T1>(&arg3), arg5, arg6);
        if (v2 == 1) {
            assert!(0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::safe_math::safe_mul_div_u64(0x2::coin::value<T0>(&arg2), arg6, arg5) >= v3, 8);
        };
        if (v2 == 2) {
            assert!(v4 >= v3, 9);
        };
        if (v2 == 3) {
            assert!(v4 >= v3, 10);
        };
        let InsidexLimitOrder {
            id                       : v5,
            user                     : _,
            slippage                 : _,
            balance_base             : v8,
            balance_quote            : v9,
            target_price_limit_buy   : v10,
            target_price_take_profit : v11,
            target_price_stop_loss   : v12,
            created_at               : _,
            updated_at               : _,
        } = arg1;
        let v15 = v12;
        let v16 = v11;
        let v17 = v10;
        0x2::object::delete(v5);
        (arg2, arg3, 0x2::coin::from_balance<T0>(v8, arg8), 0x2::coin::from_balance<T1>(v9, arg8), 0x1::option::get_with_default<u64>(&v17, 0), 0x1::option::get_with_default<u64>(&v16, 0), 0x1::option::get_with_default<u64>(&v15, 0), v0, v1, v2, v3)
    }

    public(friend) fun update_limit_order<T0, T1>(arg0: &mut InsidexLimitOrder<T0, T1>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_interacting_with_most_up_to_date_package(arg4);
        if (0x1::option::is_some<u64>(&arg1)) {
            arg0.target_price_limit_buy = arg1;
        };
        if (0x1::option::is_some<u64>(&arg2)) {
            arg0.target_price_take_profit = arg2;
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            arg0.target_price_stop_loss = arg3;
        };
        arg0.updated_at = 0x2::clock::timestamp_ms(arg5);
        (0x1::option::get_with_default<u64>(&arg0.target_price_limit_buy, 0), 0x1::option::get_with_default<u64>(&arg0.target_price_take_profit, 0), 0x1::option::get_with_default<u64>(&arg0.target_price_stop_loss, 0))
    }

    // decompiled from Move bytecode v6
}

