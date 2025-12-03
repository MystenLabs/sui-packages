module 0x7f840c900d2407ef5f4e1af37b88a00d6a4756bf70da7d0ac1e3dbd11ecd32d0::magma {
    struct TicksFetchedEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        current_tick_index: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32,
        current_sqrt_price: u128,
        left_ticks_count: u64,
        left_ticks_vector: vector<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>,
        right_ticks_count: u64,
        right_ticks_vector: vector<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>,
        total_fetched: u64,
    }

    public fun fetch_left_ticks<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: u64) : vector<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick> {
        if (arg1 == 0) {
            return 0x1::vector::empty<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>()
        };
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::first_score_for_swap(v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0), true);
        let v2 = 0x1::vector::empty<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>();
        let v3 = 0;
        while (0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_some(&v1) && v3 < arg1) {
            let (v4, v5) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::borrow_tick_for_swap(v0, 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::borrow(&v1), true);
            0x1::vector::push_back<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>(&mut v2, *v4);
            v3 = v3 + 1;
            v1 = v5;
        };
        v2
    }

    public fun fetch_right_ticks<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: u64) : vector<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick> {
        if (arg1 == 0) {
            return 0x1::vector::empty<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>()
        };
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::first_score_for_swap(v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0), false);
        let v2 = 0x1::vector::empty<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>();
        let v3 = 0;
        while (0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_some(&v1) && v3 < arg1) {
            let (v4, v5) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::borrow_tick_for_swap(v0, 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::borrow(&v1), false);
            0x1::vector::push_back<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>(&mut v2, *v4);
            v3 = v3 + 1;
            v1 = v5;
        };
        v2
    }

    public fun fetch_ticks_around_current<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : (vector<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>, vector<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>) {
        (fetch_left_ticks<T0, T1>(arg0, arg1), fetch_right_ticks<T0, T1>(arg0, arg2))
    }

    public entry fun fetch_ticks_entry<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: u64, arg2: u64) {
        let (_, _) = fetch_ticks_with_event<T0, T1>(arg0, arg1, arg2);
    }

    public fun fetch_ticks_sorted<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : vector<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick> {
        let (v0, v1) = fetch_ticks_around_current<T0, T1>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::empty<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>();
        let v5 = 0x1::vector::length<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>(&v3);
        while (v5 > 0) {
            let v6 = v5 - 1;
            v5 = v6;
            0x1::vector::push_back<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>(&mut v4, *0x1::vector::borrow<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>(&v3, v6));
        };
        v5 = 0;
        while (v5 < 0x1::vector::length<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>(&v2)) {
            0x1::vector::push_back<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>(&mut v4, *0x1::vector::borrow<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>(&v2, v5));
            v5 = v5 + 1;
        };
        v4
    }

    public fun fetch_ticks_with_event<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : (vector<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>, vector<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>) {
        let (v0, v1) = fetch_ticks_around_current<T0, T1>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::length<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>(&v3);
        let v5 = 0x1::vector::length<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::Tick>(&v2);
        let v6 = TicksFetchedEvent{
            pool_id            : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg0),
            current_tick_index : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0),
            current_sqrt_price : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0),
            left_ticks_count   : v4,
            left_ticks_vector  : v3,
            right_ticks_count  : v5,
            right_ticks_vector : v2,
            total_fetched      : v4 + v5,
        };
        0x2::event::emit<TicksFetchedEvent>(v6);
        (v3, v2)
    }

    // decompiled from Move bytecode v6
}

