module 0xb428bbdc8a292a279bf2e4a58c8be834232b90385da135c4c422de3e2b499922::limit_order {
    struct OrderBook has key {
        id: 0x2::object::UID,
        orders: 0x2::table::Table<u64, 0x2::object::ID>,
        next_order_id: u64,
        total_orders: u64,
        active_orders: u64,
    }

    struct LimitOrder<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        order_id: u64,
        owner: address,
        order_type: u8,
        limit_price: u64,
        amount_in: u64,
        min_amount_out: u64,
        deposited: 0x2::balance::Balance<T0>,
        status: u8,
        created_at: u64,
        expires_at: u64,
        filled_amount: u64,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
    }

    struct OrderCreated has copy, drop {
        order_id: u64,
        owner: address,
        order_type: u8,
        limit_price: u64,
        amount_in: u64,
        created_at: u64,
    }

    struct OrderFilled has copy, drop {
        order_id: u64,
        owner: address,
        amount_in: u64,
        amount_out: u64,
        execution_price: u64,
        filled_at: u64,
    }

    struct OrderCancelled has copy, drop {
        order_id: u64,
        owner: address,
        refund_amount: u64,
    }

    struct OrderExpired has copy, drop {
        order_id: u64,
        owner: address,
        refund_amount: u64,
    }

    public entry fun cancel_order<T0, T1>(arg0: &mut OrderBook, arg1: LimitOrder<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 4);
        assert!(arg1.status == 1 || arg1.status == 5, 3);
        let LimitOrder {
            id             : v0,
            order_id       : v1,
            owner          : v2,
            order_type     : _,
            limit_price    : _,
            amount_in      : _,
            min_amount_out : _,
            deposited      : v7,
            status         : _,
            created_at     : _,
            expires_at     : _,
            filled_amount  : _,
        } = arg1;
        let v12 = v7;
        if (0x2::table::contains<u64, 0x2::object::ID>(&arg0.orders, v1)) {
            0x2::table::remove<u64, 0x2::object::ID>(&mut arg0.orders, v1);
            arg0.active_orders = arg0.active_orders - 1;
        };
        let v13 = OrderCancelled{
            order_id      : v1,
            owner         : v2,
            refund_amount : 0x2::balance::value<T0>(&v12),
        };
        0x2::event::emit<OrderCancelled>(v13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg2), v2);
        0x2::object::delete(v0);
    }

    fun check_expiration<T0, T1>(arg0: &LimitOrder<T0, T1>, arg1: u64) : bool {
        arg0.expires_at == 0 && false || arg1 >= arg0.expires_at
    }

    fun check_price_condition<T0, T1>(arg0: &LimitOrder<T0, T1>, arg1: u64) : bool {
        arg0.order_type == 1 && arg1 <= arg0.limit_price || arg0.order_type == 2 && arg1 >= arg0.limit_price || arg0.order_type == 3 && arg1 <= arg0.limit_price || arg0.order_type == 4 && arg1 >= arg0.limit_price
    }

    public entry fun create_limit_buy<T0, T1>(arg0: &mut OrderBook, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = arg0.next_order_id;
        let v2 = LimitOrder<T0, T1>{
            id             : 0x2::object::new(arg6),
            order_id       : v1,
            owner          : 0x2::tx_context::sender(arg6),
            order_type     : 1,
            limit_price    : arg2,
            amount_in      : v0,
            min_amount_out : arg3,
            deposited      : 0x2::coin::into_balance<T0>(arg1),
            status         : 1,
            created_at     : arg5,
            expires_at     : arg4,
            filled_amount  : 0,
        };
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.orders, v1, 0x2::object::uid_to_inner(&v2.id));
        arg0.next_order_id = arg0.next_order_id + 1;
        arg0.total_orders = arg0.total_orders + 1;
        arg0.active_orders = arg0.active_orders + 1;
        let v3 = OrderCreated{
            order_id    : v1,
            owner       : 0x2::tx_context::sender(arg6),
            order_type  : 1,
            limit_price : arg2,
            amount_in   : v0,
            created_at  : arg5,
        };
        0x2::event::emit<OrderCreated>(v3);
        0x2::transfer::share_object<LimitOrder<T0, T1>>(v2);
    }

    public entry fun create_limit_sell<T0, T1>(arg0: &mut OrderBook, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = arg0.next_order_id;
        let v2 = LimitOrder<T0, T1>{
            id             : 0x2::object::new(arg6),
            order_id       : v1,
            owner          : 0x2::tx_context::sender(arg6),
            order_type     : 2,
            limit_price    : arg2,
            amount_in      : v0,
            min_amount_out : arg3,
            deposited      : 0x2::coin::into_balance<T0>(arg1),
            status         : 1,
            created_at     : arg5,
            expires_at     : arg4,
            filled_amount  : 0,
        };
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.orders, v1, 0x2::object::uid_to_inner(&v2.id));
        arg0.next_order_id = arg0.next_order_id + 1;
        arg0.total_orders = arg0.total_orders + 1;
        arg0.active_orders = arg0.active_orders + 1;
        let v3 = OrderCreated{
            order_id    : v1,
            owner       : 0x2::tx_context::sender(arg6),
            order_type  : 2,
            limit_price : arg2,
            amount_in   : v0,
            created_at  : arg5,
        };
        0x2::event::emit<OrderCreated>(v3);
        0x2::transfer::share_object<LimitOrder<T0, T1>>(v2);
    }

    public fun execute_order<T0, T1>(arg0: &KeeperCap, arg1: &mut OrderBook, arg2: LimitOrder<T0, T1>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2.status == 1, 3);
        assert!(check_expiration<T0, T1>(&arg2, arg5) == false, 5);
        assert!(check_price_condition<T0, T1>(&arg2, arg3), 7);
        let v0 = 0x2::coin::value<T1>(&arg4);
        assert!(v0 >= arg2.min_amount_out, 6);
        arg2.status = 2;
        arg2.filled_amount = arg2.amount_in;
        if (0x2::table::contains<u64, 0x2::object::ID>(&arg1.orders, arg2.order_id)) {
            0x2::table::remove<u64, 0x2::object::ID>(&mut arg1.orders, arg2.order_id);
            arg1.active_orders = arg1.active_orders - 1;
        };
        let v1 = OrderFilled{
            order_id        : arg2.order_id,
            owner           : arg2.owner,
            amount_in       : arg2.amount_in,
            amount_out      : v0,
            execution_price : arg3,
            filled_at       : arg5,
        };
        0x2::event::emit<OrderFilled>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg4, arg2.owner);
        let LimitOrder {
            id             : v2,
            order_id       : _,
            owner          : _,
            order_type     : _,
            limit_price    : _,
            amount_in      : _,
            min_amount_out : _,
            deposited      : v9,
            status         : _,
            created_at     : _,
            expires_at     : _,
            filled_amount  : _,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v9);
        0x2::object::delete(v2);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg2.deposited), arg6)
    }

    public entry fun expire_order<T0, T1>(arg0: &mut OrderBook, arg1: LimitOrder<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(check_expiration<T0, T1>(&arg1, arg2), 5);
        assert!(arg1.status == 1 || arg1.status == 5, 3);
        let LimitOrder {
            id             : v0,
            order_id       : v1,
            owner          : v2,
            order_type     : _,
            limit_price    : _,
            amount_in      : _,
            min_amount_out : _,
            deposited      : v7,
            status         : _,
            created_at     : _,
            expires_at     : _,
            filled_amount  : _,
        } = arg1;
        let v12 = v7;
        if (0x2::table::contains<u64, 0x2::object::ID>(&arg0.orders, v1)) {
            0x2::table::remove<u64, 0x2::object::ID>(&mut arg0.orders, v1);
            arg0.active_orders = arg0.active_orders - 1;
        };
        let v13 = OrderExpired{
            order_id      : v1,
            owner         : v2,
            refund_amount : 0x2::balance::value<T0>(&v12),
        };
        0x2::event::emit<OrderExpired>(v13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg3), v2);
        0x2::object::delete(v0);
    }

    public fun get_order_book_stats(arg0: &OrderBook) : (u64, u64, u64) {
        (arg0.total_orders, arg0.active_orders, arg0.next_order_id - 1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OrderBook{
            id            : 0x2::object::new(arg0),
            orders        : 0x2::table::new<u64, 0x2::object::ID>(arg0),
            next_order_id : 1,
            total_orders  : 0,
            active_orders : 0,
        };
        0x2::transfer::share_object<OrderBook>(v0);
        let v1 = KeeperCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<KeeperCap>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

