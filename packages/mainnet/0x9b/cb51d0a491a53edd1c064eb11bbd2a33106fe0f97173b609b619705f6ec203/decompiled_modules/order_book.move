module 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::order_book {
    struct PriceLevel has store {
        orders: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>,
    }

    struct OrderBook has store {
        levels: 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::KeyedBigVector,
    }

    public(friend) fun push_back(arg0: &mut PriceLevel, arg1: 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order) {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::push_back<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&mut arg0.orders, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::get_order_id(&arg1), arg1);
    }

    public fun destroy_empty(arg0: OrderBook) {
        let OrderBook { levels: v0 } = arg0;
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::destroy_empty(v0);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : OrderBook {
        OrderBook{levels: 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::new<u128, PriceLevel>(256, arg0)}
    }

    public fun add_order(arg0: &mut OrderBook, arg1: u128, arg2: 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<u128>(&arg0.levels, arg1)) {
            let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::new<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(arg3);
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::push_back<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&mut v0, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::get_order_id(&arg2), arg2);
            let v1 = PriceLevel{orders: v0};
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::push_back<u128, PriceLevel>(&mut arg0.levels, arg1, v1);
            return
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::push_back<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&mut 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key_mut<u128, PriceLevel>(&mut arg0.levels, arg1).orders, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::get_order_id(&arg2), arg2);
    }

    public fun borrow_level_by_index(arg0: &OrderBook, arg1: u64) : (u128, &PriceLevel) {
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow<u128, PriceLevel>(&arg0.levels, arg1)
    }

    public(friend) fun borrow_level_order(arg0: &PriceLevel, arg1: u64) : &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::borrow<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&arg0.orders, arg1)
    }

    public fun borrow_order(arg0: &OrderBook, arg1: u128, arg2: u64) : &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::borrow<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key<u128, PriceLevel>(&arg0.levels, arg1).orders, arg2)
    }

    public fun contains_level(arg0: &OrderBook, arg1: u128) : bool {
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<u128>(&arg0.levels, arg1)
    }

    public(friend) fun contains_order(arg0: &OrderBook, arg1: u128, arg2: u64) : bool {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<u128>(&arg0.levels, arg1)) {
            return false
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::contains<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key<u128, PriceLevel>(&arg0.levels, arg1).orders, arg2)
    }

    public(friend) fun destroy_empty_level(arg0: PriceLevel) {
        let PriceLevel { orders: v0 } = arg0;
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::destroy_empty<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(v0);
    }

    public(friend) fun level_count(arg0: &OrderBook) : u64 {
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::length(&arg0.levels)
    }

    public(friend) fun level_front_order_id(arg0: &PriceLevel) : 0x1::option::Option<u64> {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::front<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&arg0.orders);
        if (0x1::option::is_some<u64>(v0)) {
            0x1::option::some<u64>(*0x1::option::borrow<u64>(v0))
        } else {
            0x1::option::none<u64>()
        }
    }

    public(friend) fun level_is_empty(arg0: &PriceLevel) : bool {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::is_empty<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&arg0.orders)
    }

    public(friend) fun level_next_order_id(arg0: &PriceLevel, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::next<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&arg0.orders, arg1);
        if (0x1::option::is_some<u64>(v0)) {
            0x1::option::some<u64>(*0x1::option::borrow<u64>(v0))
        } else {
            0x1::option::none<u64>()
        }
    }

    public(friend) fun level_order_count(arg0: &PriceLevel) : u64 {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::length<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&arg0.orders)
    }

    public(friend) fun order_count_at(arg0: &OrderBook, arg1: u128) : u64 {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<u128>(&arg0.levels, arg1)) {
            return 0
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::length<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key<u128, PriceLevel>(&arg0.levels, arg1).orders)
    }

    public(friend) fun pop_front(arg0: &mut PriceLevel) : 0x1::option::Option<0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order> {
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::is_empty<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&arg0.orders)) {
            return 0x1::option::none<0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>()
        };
        let (_, v1) = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::pop_front<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&mut arg0.orders);
        0x1::option::some<0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(v1)
    }

    public fun pop_order_for_match(arg0: &mut OrderBook, arg1: u128) : 0x1::option::Option<0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order> {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<u128>(&arg0.levels, arg1)) {
            return 0x1::option::none<0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>()
        };
        let v0 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key_mut<u128, PriceLevel>(&mut arg0.levels, arg1);
        let (_, v2) = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::pop_front<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&mut v0.orders);
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::is_empty<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&v0.orders)) {
            let PriceLevel { orders: v3 } = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::swap_remove_by_key<u128, PriceLevel>(&mut arg0.levels, arg1);
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::destroy_empty<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(v3);
        };
        0x1::option::some<0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(v2)
    }

    public(friend) fun push_front(arg0: &mut PriceLevel, arg1: 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order) {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::push_front<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&mut arg0.orders, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::get_order_id(&arg1), arg1);
    }

    public fun remove_order(arg0: &mut OrderBook, arg1: u128, arg2: u64) : 0x1::option::Option<0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order> {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<u128>(&arg0.levels, arg1)) {
            return 0x1::option::none<0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>()
        };
        if (!0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::contains<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key<u128, PriceLevel>(&arg0.levels, arg1).orders, arg2)) {
            return 0x1::option::none<0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>()
        };
        let v0 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key_mut<u128, PriceLevel>(&mut arg0.levels, arg1);
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::is_empty<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&v0.orders)) {
            let PriceLevel { orders: v1 } = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::swap_remove_by_key<u128, PriceLevel>(&mut arg0.levels, arg1);
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::destroy_empty<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(v1);
        };
        0x1::option::some<0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::remove<u64, 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::position::Order>(&mut v0.orders, arg2))
    }

    public(friend) fun restore_level(arg0: &mut OrderBook, arg1: u128, arg2: PriceLevel) {
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::push_back<u128, PriceLevel>(&mut arg0.levels, arg1, arg2);
    }

    public(friend) fun take_level(arg0: &mut OrderBook, arg1: u128) : 0x1::option::Option<PriceLevel> {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<u128>(&arg0.levels, arg1)) {
            return 0x1::option::none<PriceLevel>()
        };
        0x1::option::some<PriceLevel>(0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::swap_remove_by_key<u128, PriceLevel>(&mut arg0.levels, arg1))
    }

    // decompiled from Move bytecode v7
}

