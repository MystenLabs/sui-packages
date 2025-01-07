module 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_order_user_actions {
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

    struct LimitOrderCancelledEvent has copy, drop {
        limit_order_id: 0x2::object::ID,
        user: address,
        coin: 0x1::type_name::TypeName,
    }

    public entry fun cancel_limit_order<T0, T1>(arg0: 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::InsidexLimitOrder<T0, T1>, arg1: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::assert_limit_order_belongs_to_user<T0, T1>(&arg0, 0x2::tx_context::sender(arg2));
        let (v0, v1) = 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::cancel_limit_order<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg2));
        let v2 = LimitOrderCancelledEvent{
            limit_order_id : 0x2::object::id<0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::InsidexLimitOrder<T0, T1>>(&arg0),
            user           : 0x2::tx_context::sender(arg2),
            coin           : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<LimitOrderCancelledEvent>(v2);
    }

    public entry fun place_limit_buy_order<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: u64, arg3: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = LimitBuyOrderPlacedEvent{
            limit_order_id : 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::place_limit_order<T0, T1>(0x2::coin::zero<T0>(arg5), arg0, 0x1::option::some<u64>(arg1), 0x1::option::none<u64>(), 0x1::option::none<u64>(), arg2, arg3, arg4, arg5),
            user           : 0x2::tx_context::sender(arg5),
            amount         : 0x2::coin::value<T1>(&arg0),
            target_price   : arg1,
            coin           : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<LimitBuyOrderPlacedEvent>(v0);
    }

    public entry fun place_tpsl_order<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = LimitSellOrderPlacedEvent{
            limit_order_id : 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::place_limit_order<T0, T1>(arg0, 0x2::coin::zero<T1>(arg6), 0x1::option::none<u64>(), 0x1::option::some<u64>(arg1), 0x1::option::some<u64>(arg2), arg3, arg4, arg5, arg6),
            user           : 0x2::tx_context::sender(arg6),
            amount         : 0x2::coin::value<T0>(&arg0),
            tp_price       : arg1,
            sl_price       : arg2,
            coin           : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<LimitSellOrderPlacedEvent>(v0);
    }

    public entry fun update_limit_order<T0, T1>(arg0: &mut 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::InsidexLimitOrder<T0, T1>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config::Config, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::assert_limit_order_belongs_to_user<T0, T1>(arg0, 0x2::tx_context::sender(arg6));
        let (v0, v1, v2) = 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::update_limit_order<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v3 = LimitOrderUpdatedEvent{
            limit_order_id           : 0x2::object::id<0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::limit_orders::InsidexLimitOrder<T0, T1>>(arg0),
            user                     : 0x2::tx_context::sender(arg6),
            target_price_limit_buy   : v0,
            target_price_take_profit : v1,
            target_price_stop_loss   : v2,
            coin                     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<LimitOrderUpdatedEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

