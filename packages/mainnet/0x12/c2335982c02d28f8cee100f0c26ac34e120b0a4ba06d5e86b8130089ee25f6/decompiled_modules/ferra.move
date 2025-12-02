module 0x12c2335982c02d28f8cee100f0c26ac34e120b0a4ba06d5e86b8130089ee25f6::ferra {
    struct TicksFetchedEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        current_tick_index: 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i32::I32,
        current_sqrt_price: u128,
        left_ticks_count: u64,
        left_ticks_vector: vector<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>,
        right_ticks_count: u64,
        right_ticks_vector: vector<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>,
        total_fetched: u64,
    }

    public fun fetch_left_ticks<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg1: u64) : vector<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick> {
        if (arg1 == 0) {
            return 0x1::vector::empty<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>()
        };
        let v0 = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::first_score_for_swap(v0, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::current_tick_index<T0, T1>(arg0), true);
        let v2 = 0x1::vector::empty<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>();
        let v3 = 0;
        while (0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::option_u64::is_some(&v1) && v3 < arg1) {
            let (v4, v5) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::borrow_tick_for_swap(v0, 0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::option_u64::borrow(&v1), true);
            0x1::vector::push_back<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>(&mut v2, *v4);
            v3 = v3 + 1;
            v1 = v5;
        };
        v2
    }

    public fun fetch_right_ticks<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg1: u64) : vector<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick> {
        if (arg1 == 0) {
            return 0x1::vector::empty<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>()
        };
        let v0 = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::first_score_for_swap(v0, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::current_tick_index<T0, T1>(arg0), false);
        let v2 = 0x1::vector::empty<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>();
        let v3 = 0;
        while (0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::option_u64::is_some(&v1) && v3 < arg1) {
            let (v4, v5) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::borrow_tick_for_swap(v0, 0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::option_u64::borrow(&v1), false);
            0x1::vector::push_back<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>(&mut v2, *v4);
            v3 = v3 + 1;
            v1 = v5;
        };
        v2
    }

    public fun fetch_ticks_around_current<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : (vector<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>, vector<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>) {
        (fetch_left_ticks<T0, T1>(arg0, arg1), fetch_right_ticks<T0, T1>(arg0, arg2))
    }

    public entry fun fetch_ticks_entry<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg1: u64, arg2: u64) {
        let (_, _) = fetch_ticks_with_event<T0, T1>(arg0, arg1, arg2);
    }

    public fun fetch_ticks_sorted<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : vector<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick> {
        let (v0, v1) = fetch_ticks_around_current<T0, T1>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::empty<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>();
        let v5 = 0x1::vector::length<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>(&v3);
        while (v5 > 0) {
            let v6 = v5 - 1;
            v5 = v6;
            0x1::vector::push_back<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>(&mut v4, *0x1::vector::borrow<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>(&v3, v6));
        };
        v5 = 0;
        while (v5 < 0x1::vector::length<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>(&v2)) {
            0x1::vector::push_back<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>(&mut v4, *0x1::vector::borrow<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>(&v2, v5));
            v5 = v5 + 1;
        };
        v4
    }

    public fun fetch_ticks_with_event<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : (vector<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>, vector<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>) {
        let (v0, v1) = fetch_ticks_around_current<T0, T1>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::length<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>(&v3);
        let v5 = 0x1::vector::length<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::Tick>(&v2);
        let v6 = TicksFetchedEvent{
            pool_id            : 0x2::object::id<0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>>(arg0),
            current_tick_index : 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::current_tick_index<T0, T1>(arg0),
            current_sqrt_price : 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::current_sqrt_price<T0, T1>(arg0),
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

