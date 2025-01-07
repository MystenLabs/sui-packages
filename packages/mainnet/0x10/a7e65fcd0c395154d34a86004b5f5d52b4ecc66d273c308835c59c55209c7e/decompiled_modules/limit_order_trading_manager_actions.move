module 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_order_trading_manager_actions {
    struct LimitBuyOrderPlacedEvent has copy, drop {
        limit_order_id: 0x2::object::ID,
        user: address,
        amount: u64,
        target_price: u64,
        coin: 0x1::type_name::TypeName,
    }

    struct LimitSellOrderPlacedEvent has copy, drop {
        limit_order_id: 0x2::object::ID,
        user: address,
        amount: u64,
        tp_price: u64,
        sl_price: u64,
        coin: 0x1::type_name::TypeName,
    }

    struct LimitOrderUpdatedEvent has copy, drop {
        limit_order_id: 0x2::object::ID,
        user: address,
        target_price_limit_buy: u64,
        target_price_take_profit: u64,
        target_price_stop_loss: u64,
        coin: 0x1::type_name::TypeName,
    }

    struct LimitOrderExecutedEvent has copy, drop {
        limit_order_id: 0x2::object::ID,
        user: address,
        trade_type: u8,
        amount_base: u64,
        amount_quote: u64,
        coin_base: 0x1::type_name::TypeName,
        coin_quote: 0x1::type_name::TypeName,
        target_buy_price: u64,
        tp_price: u64,
        sl_price: u64,
        min_amount_to_repay: u64,
    }

    public fun borrow_asset_to_execute_order<T0, T1>(arg0: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::TradingManagerCap, arg1: &mut 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::InsidexLimitOrder<T0, T1>, arg2: u8, arg3: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::Promise) {
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::borrow_asset_to_execute_order<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public entry fun place_limit_buy_order<T0, T1>(arg0: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::TradingManagerCap, arg1: &mut 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::trade_account::TradeAsset<T1>, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = LimitBuyOrderPlacedEvent{
            limit_order_id : 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::place_limit_order<T0, T1>(0x2::coin::zero<T0>(arg8), 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::trade_account::borrow_asset_to_place_limit_order<T1>(arg0, arg1, arg2, arg3, arg6, arg8), 0x1::option::some<u64>(arg4), 0x1::option::none<u64>(), 0x1::option::none<u64>(), arg5, arg6, arg7, arg8),
            user           : arg3,
            amount         : arg2,
            target_price   : arg4,
            coin           : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<LimitBuyOrderPlacedEvent>(v0);
    }

    public entry fun place_tpsl_order<T0, T1>(arg0: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::TradingManagerCap, arg1: &mut 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::trade_account::TradeAsset<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = LimitSellOrderPlacedEvent{
            limit_order_id : 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::place_limit_order<T0, T1>(0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::trade_account::borrow_asset_to_place_limit_order<T0>(arg0, arg1, arg2, 0x2::tx_context::sender(arg8), arg6, arg8), 0x2::coin::zero<T1>(arg8), 0x1::option::none<u64>(), 0x1::option::some<u64>(arg3), 0x1::option::some<u64>(arg4), arg5, arg6, arg7, arg8),
            user           : 0x2::tx_context::sender(arg8),
            amount         : arg2,
            tp_price       : arg3,
            sl_price       : arg4,
            coin           : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<LimitSellOrderPlacedEvent>(v0);
    }

    public fun return_asset_after_order_execution<T0, T1>(arg0: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::TradingManagerCap, arg1: 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::InsidexLimitOrder<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::Promise, arg5: u64, arg6: u64, arg7: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::value<T1>(&arg3);
        let (v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12) = 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::return_asset_after_order_execution<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v13 = v3;
        let v14 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v14, v0 * 120 / 100, arg8), 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v13, v1 * 120 / 100, arg8), 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v13, v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, v9);
        let v15 = LimitOrderExecutedEvent{
            limit_order_id      : v10,
            user                : v9,
            trade_type          : v11,
            amount_base         : v0,
            amount_quote        : v1,
            coin_base           : 0x1::type_name::get<T0>(),
            coin_quote          : 0x1::type_name::get<T1>(),
            target_buy_price    : v6,
            tp_price            : v7,
            sl_price            : v8,
            min_amount_to_repay : v12,
        };
        0x2::event::emit<LimitOrderExecutedEvent>(v15);
    }

    public entry fun update_limit_order<T0, T1>(arg0: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::TradingManagerCap, arg1: &mut 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::InsidexLimitOrder<T0, T1>, arg2: address, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::assert_address_is_trading_manager(arg0, arg6, arg8);
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::assert_limit_order_belongs_to_user<T0, T1>(arg1, arg2);
        let (v0, v1, v2) = 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::update_limit_order<T0, T1>(arg1, arg3, arg4, arg5, arg6, arg7);
        let v3 = LimitOrderUpdatedEvent{
            limit_order_id           : 0x2::object::id<0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::InsidexLimitOrder<T0, T1>>(arg1),
            user                     : 0x2::tx_context::sender(arg8),
            target_price_limit_buy   : v0,
            target_price_take_profit : v1,
            target_price_stop_loss   : v2,
            coin                     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<LimitOrderUpdatedEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

