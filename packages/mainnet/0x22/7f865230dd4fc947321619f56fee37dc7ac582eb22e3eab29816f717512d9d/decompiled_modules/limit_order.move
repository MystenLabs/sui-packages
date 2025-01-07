module 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::limit_order {
    struct GlobalStorage has key {
        id: 0x2::object::UID,
        swap_order_managers: 0x2::object_bag::ObjectBag,
    }

    struct ExecutorCap has store, key {
        id: 0x2::object::UID,
    }

    struct SwapOrderManager<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        list: 0x2::object_table::ObjectTable<0x2::object::ID, SwapOrderDetail<T0, T1, T2>>,
    }

    struct SwapOrderDetail<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        owner: address,
        expired: u64,
        status: u64,
        min_out_x: u64,
        min_out_y: u64,
        coin_x: 0x2::balance::Balance<T0>,
        coin_y: 0x2::balance::Balance<T1>,
        coin_x_val: u64,
        coin_y_val: u64,
        is_reverse: bool,
        timestamp: u64,
    }

    struct EventRegisterSwapOrderManager<phantom T0, phantom T1, phantom T2> has copy, drop {
        order_manager_id: 0x2::object::ID,
        list_id: 0x2::object::ID,
    }

    struct EventPlacedSwapOrder<phantom T0, phantom T1, phantom T2> has copy, drop {
        detail_id: 0x2::object::ID,
        owner: address,
        min_out_x: u64,
        min_out_y: u64,
        coin_x: u64,
        coin_y: u64,
        is_reverse: bool,
        timestamp: u64,
    }

    struct EventCancelSwapOrder<phantom T0, phantom T1, phantom T2> has copy, drop {
        order_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct EventExecutedSwapOrder<phantom T0, phantom T1, phantom T2> has copy, drop {
        executor: address,
        order_owner: address,
        order_id: 0x2::object::ID,
        swapped_x: u64,
        swapped_y: u64,
    }

    fun assert_coin_pair_sorted<T0, T1>() {
        assert!(0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::helper::is_sorted<T0, T1>() == true, 10001);
    }

    fun borrow_mut_orders<T0, T1, T2>(arg0: &mut GlobalStorage) : &mut SwapOrderManager<T0, T1, T2> {
        0x2::object_bag::borrow_mut<0x1::type_name::TypeName, SwapOrderManager<T0, T1, T2>>(&mut arg0.swap_order_managers, 0x1::type_name::get<SwapOrderManager<T0, T1, T2>>())
    }

    public fun borrow_orders<T0, T1, T2>(arg0: &mut GlobalStorage) : &SwapOrderManager<T0, T1, T2> {
        0x2::object_bag::borrow<0x1::type_name::TypeName, SwapOrderManager<T0, T1, T2>>(&arg0.swap_order_managers, 0x1::type_name::get<SwapOrderManager<T0, T1, T2>>())
    }

    public fun borrow_orders_list<T0, T1, T2>(arg0: &GlobalStorage) : &0x2::object_table::ObjectTable<0x2::object::ID, SwapOrderDetail<T0, T1, T2>> {
        &0x2::object_bag::borrow<0x1::type_name::TypeName, SwapOrderManager<T0, T1, T2>>(&arg0.swap_order_managers, 0x1::type_name::get<SwapOrderManager<T0, T1, T2>>()).list
    }

    public fun cancel_swap_order<T0, T1, T2>(arg0: &mut GlobalStorage, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_coin_pair_sorted<T0, T1>();
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, SwapOrderDetail<T0, T1, T2>>(&mut borrow_mut_orders<T0, T1, T2>(arg0).list, arg2);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 10007);
        assert!(v0.status == 101, 10008);
        let v1 = 0x2::balance::value<T0>(&v0.coin_x);
        let v2 = if (v1 > 0) {
            0x2::balance::split<T0>(&mut v0.coin_x, v1)
        } else {
            0x2::balance::zero<T0>()
        };
        let v3 = 0x2::balance::value<T1>(&v0.coin_y);
        let v4 = if (v3 > 0) {
            0x2::balance::split<T1>(&mut v0.coin_y, v3)
        } else {
            0x2::balance::zero<T1>()
        };
        v0.status = 103;
        let v5 = EventCancelSwapOrder<T0, T1, T2>{
            order_id  : 0x2::object::uid_to_inner(&v0.id),
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<EventCancelSwapOrder<T0, T1, T2>>(v5);
        (0x2::coin::from_balance<T0>(v2, arg3), 0x2::coin::from_balance<T1>(v4, arg3))
    }

    public fun execute_swap_order<T0, T1, T2>(arg0: &ExecutorCap, arg1: &mut GlobalStorage, arg2: &0x2::clock::Clock, arg3: &mut 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::liquidity_pool::GlobalStorage, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        assert_coin_pair_sorted<T0, T1>();
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, SwapOrderDetail<T0, T1, T2>>(&mut borrow_mut_orders<T0, T1, T2>(arg1).list, arg4);
        assert!(v0.status == 101, 10006);
        assert!(v0.expired > 0x2::clock::timestamp_ms(arg2), 100010);
        if (!v0.is_reverse) {
            let v1 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::swap_exact_coin_x_for_coin_y<T0, T1, T2>(arg3, 0x2::coin::take<T0>(&mut v0.coin_x, 0x2::balance::value<T0>(&v0.coin_x), arg5), v0.min_out_y, arg5);
            let v2 = 0x2::coin::value<T1>(&v1);
            assert!(v2 >= v0.min_out_y, 10004);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v0.owner);
            let v3 = EventExecutedSwapOrder<T0, T1, T2>{
                executor    : 0x2::tx_context::sender(arg5),
                order_owner : v0.owner,
                order_id    : 0x2::object::uid_to_inner(&v0.id),
                swapped_x   : 0,
                swapped_y   : v2,
            };
            0x2::event::emit<EventExecutedSwapOrder<T0, T1, T2>>(v3);
        } else {
            let v4 = 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::router::swap_exact_coin_y_for_coin_x<T0, T1, T2>(arg3, 0x2::coin::take<T1>(&mut v0.coin_y, 0x2::balance::value<T1>(&v0.coin_y), arg5), v0.min_out_x, arg5);
            let v5 = 0x2::coin::value<T0>(&v4);
            assert!(v5 >= v0.min_out_x, 10005);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v0.owner);
            let v6 = EventExecutedSwapOrder<T0, T1, T2>{
                executor    : 0x2::tx_context::sender(arg5),
                order_owner : v0.owner,
                order_id    : 0x2::object::uid_to_inner(&v0.id),
                swapped_x   : v5,
                swapped_y   : 0,
            };
            0x2::event::emit<EventExecutedSwapOrder<T0, T1, T2>>(v6);
        };
        v0.status = 102;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalStorage{
            id                  : 0x2::object::new(arg0),
            swap_order_managers : 0x2::object_bag::new(arg0),
        };
        let v1 = ExecutorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ExecutorCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalStorage>(v0);
    }

    fun is_existed_orders_for_pool<T0, T1, T2>(arg0: &GlobalStorage) : bool {
        0x2::object_bag::contains_with_type<0x1::type_name::TypeName, SwapOrderManager<T0, T1, T2>>(&arg0.swap_order_managers, 0x1::type_name::get<SwapOrderManager<T0, T1, T2>>())
    }

    public fun order_detail_coin_x_val<T0, T1, T2>(arg0: &SwapOrderDetail<T0, T1, T2>) : u64 {
        0x2::balance::value<T0>(&arg0.coin_x)
    }

    public fun order_detail_coin_y_val<T0, T1, T2>(arg0: &SwapOrderDetail<T0, T1, T2>) : u64 {
        0x2::balance::value<T1>(&arg0.coin_y)
    }

    public fun order_detail_expired<T0, T1, T2>(arg0: &SwapOrderDetail<T0, T1, T2>) : u64 {
        arg0.expired
    }

    public fun order_detail_is_reverse<T0, T1, T2>(arg0: &SwapOrderDetail<T0, T1, T2>) : bool {
        arg0.is_reverse
    }

    public fun order_detail_min_out_x<T0, T1, T2>(arg0: &SwapOrderDetail<T0, T1, T2>) : u64 {
        arg0.min_out_x
    }

    public fun order_detail_min_out_y<T0, T1, T2>(arg0: &SwapOrderDetail<T0, T1, T2>) : u64 {
        arg0.min_out_y
    }

    public fun order_detail_owner<T0, T1, T2>(arg0: &SwapOrderDetail<T0, T1, T2>) : address {
        arg0.owner
    }

    public fun order_detail_status<T0, T1, T2>(arg0: &SwapOrderDetail<T0, T1, T2>) : u64 {
        arg0.status
    }

    public fun place_swap_order_from_x_to_y<T0, T1, T2>(arg0: &mut GlobalStorage, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_coin_pair_sorted<T0, T1>();
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 < arg4, 10009);
        assert!(0x2::coin::value<T0>(&arg2) > 0, 10002);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = SwapOrderDetail<T0, T1, T2>{
            id         : 0x2::object::new(arg5),
            owner      : 0x2::tx_context::sender(arg5),
            expired    : arg4,
            status     : 101,
            min_out_x  : 0,
            min_out_y  : arg3,
            coin_x     : 0x2::coin::into_balance<T0>(arg2),
            coin_y     : 0x2::balance::zero<T1>(),
            coin_x_val : v1,
            coin_y_val : 0,
            is_reverse : false,
            timestamp  : v0,
        };
        let v3 = EventPlacedSwapOrder<T0, T1, T2>{
            detail_id  : 0x2::object::uid_to_inner(&v2.id),
            owner      : 0x2::tx_context::sender(arg5),
            min_out_x  : 0,
            min_out_y  : arg3,
            coin_x     : v1,
            coin_y     : 0,
            is_reverse : false,
            timestamp  : v0,
        };
        if (!is_existed_orders_for_pool<T0, T1, T2>(arg0)) {
            let v4 = SwapOrderManager<T0, T1, T2>{
                id   : 0x2::object::new(arg5),
                list : 0x2::object_table::new<0x2::object::ID, SwapOrderDetail<T0, T1, T2>>(arg5),
            };
            0x2::object_bag::add<0x1::type_name::TypeName, SwapOrderManager<T0, T1, T2>>(&mut arg0.swap_order_managers, 0x1::type_name::get<SwapOrderManager<T0, T1, T2>>(), v4);
            let v5 = EventRegisterSwapOrderManager<T0, T1, T2>{
                order_manager_id : 0x2::object::uid_to_inner(&v4.id),
                list_id          : 0x2::object::id<0x2::object_table::ObjectTable<0x2::object::ID, SwapOrderDetail<T0, T1, T2>>>(&v4.list),
            };
            0x2::event::emit<EventRegisterSwapOrderManager<T0, T1, T2>>(v5);
        };
        0x2::object_table::add<0x2::object::ID, SwapOrderDetail<T0, T1, T2>>(&mut borrow_mut_orders<T0, T1, T2>(arg0).list, 0x2::object::uid_to_inner(&v2.id), v2);
        0x2::event::emit<EventPlacedSwapOrder<T0, T1, T2>>(v3);
    }

    public fun place_swap_order_from_y_to_x<T0, T1, T2>(arg0: &mut GlobalStorage, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_coin_pair_sorted<T0, T1>();
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 < arg4, 10009);
        assert!(0x2::coin::value<T1>(&arg2) > 0, 10002);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = SwapOrderDetail<T0, T1, T2>{
            id         : 0x2::object::new(arg5),
            owner      : 0x2::tx_context::sender(arg5),
            expired    : arg4,
            status     : 101,
            min_out_x  : arg3,
            min_out_y  : 0,
            coin_x     : 0x2::balance::zero<T0>(),
            coin_y     : 0x2::coin::into_balance<T1>(arg2),
            coin_x_val : 0,
            coin_y_val : v1,
            is_reverse : true,
            timestamp  : v0,
        };
        let v3 = EventPlacedSwapOrder<T0, T1, T2>{
            detail_id  : 0x2::object::uid_to_inner(&v2.id),
            owner      : 0x2::tx_context::sender(arg5),
            min_out_x  : arg3,
            min_out_y  : 0,
            coin_x     : 0,
            coin_y     : v1,
            is_reverse : true,
            timestamp  : v0,
        };
        if (!is_existed_orders_for_pool<T0, T1, T2>(arg0)) {
            let v4 = SwapOrderManager<T0, T1, T2>{
                id   : 0x2::object::new(arg5),
                list : 0x2::object_table::new<0x2::object::ID, SwapOrderDetail<T0, T1, T2>>(arg5),
            };
            0x2::object_bag::add<0x1::type_name::TypeName, SwapOrderManager<T0, T1, T2>>(&mut arg0.swap_order_managers, 0x1::type_name::get<SwapOrderManager<T0, T1, T2>>(), v4);
            let v5 = EventRegisterSwapOrderManager<T0, T1, T2>{
                order_manager_id : 0x2::object::uid_to_inner(&v4.id),
                list_id          : 0x2::object::id<0x2::object_table::ObjectTable<0x2::object::ID, SwapOrderDetail<T0, T1, T2>>>(&v4.list),
            };
            0x2::event::emit<EventRegisterSwapOrderManager<T0, T1, T2>>(v5);
        };
        0x2::object_table::add<0x2::object::ID, SwapOrderDetail<T0, T1, T2>>(&mut borrow_mut_orders<T0, T1, T2>(arg0).list, 0x2::object::uid_to_inner(&v2.id), v2);
        0x2::event::emit<EventPlacedSwapOrder<T0, T1, T2>>(v3);
    }

    // decompiled from Move bytecode v6
}

