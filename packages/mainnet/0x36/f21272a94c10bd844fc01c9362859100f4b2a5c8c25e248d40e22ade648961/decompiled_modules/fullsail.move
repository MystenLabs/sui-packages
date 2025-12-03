module 0x36f21272a94c10bd844fc01c9362859100f4b2a5c8c25e248d40e22ade648961::fullsail {
    struct TickData has copy, drop, store {
        index: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32,
        liquidity_gross: u128,
        liquidity_net: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i128::I128,
        initialized: bool,
        sqrt_price: u128,
    }

    struct TicksFetchedEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        fee_rate: u64,
        coin_a: u64,
        coin_b: u64,
        liquidity: u128,
        current_tick_index: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32,
        current_sqrt_price: u128,
        left_ticks_count: u64,
        left_ticks_vector: vector<TickData>,
        right_ticks_count: u64,
        right_ticks_vector: vector<TickData>,
        total_fetched: u64,
    }

    public fun fetch_left_ticks<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: u64) : vector<TickData> {
        if (arg1 == 0) {
            return 0x1::vector::empty<TickData>()
        };
        let v0 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick::first_score_for_swap(v0, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_tick_index<T0, T1>(arg0), true);
        let v2 = 0x1::vector::empty<TickData>();
        let v3 = 0;
        while (0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::option_u64::is_some(&v1) && v3 < arg1) {
            let (v4, v5) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick::borrow_tick_for_swap(v0, 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::option_u64::borrow(&v1), true);
            let v6 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick::index(v4);
            let v7 = TickData{
                index           : v6,
                liquidity_gross : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick::liquidity_gross(v4),
                liquidity_net   : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick::liquidity_net(v4),
                initialized     : true,
                sqrt_price      : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick_math::get_sqrt_price_at_tick(v6),
            };
            0x1::vector::push_back<TickData>(&mut v2, v7);
            v3 = v3 + 1;
            v1 = v5;
        };
        v2
    }

    public fun fetch_right_ticks<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: u64) : vector<TickData> {
        if (arg1 == 0) {
            return 0x1::vector::empty<TickData>()
        };
        let v0 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick::first_score_for_swap(v0, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_tick_index<T0, T1>(arg0), false);
        let v2 = 0x1::vector::empty<TickData>();
        let v3 = 0;
        while (0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::option_u64::is_some(&v1) && v3 < arg1) {
            let (v4, v5) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick::borrow_tick_for_swap(v0, 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::option_u64::borrow(&v1), false);
            let v6 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick::index(v4);
            let v7 = TickData{
                index           : v6,
                liquidity_gross : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick::liquidity_gross(v4),
                liquidity_net   : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick::liquidity_net(v4),
                initialized     : true,
                sqrt_price      : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::tick_math::get_sqrt_price_at_tick(v6),
            };
            0x1::vector::push_back<TickData>(&mut v2, v7);
            v3 = v3 + 1;
            v1 = v5;
        };
        v2
    }

    public fun fetch_ticks_around_current<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : (vector<TickData>, vector<TickData>) {
        (fetch_left_ticks<T0, T1>(arg0, arg1), fetch_right_ticks<T0, T1>(arg0, arg2))
    }

    public entry fun fetch_ticks_entry<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: u64, arg2: u64) {
        let (_, _) = fetch_ticks_with_event<T0, T1>(arg0, arg1, arg2);
    }

    public fun fetch_ticks_sorted<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : vector<TickData> {
        let (v0, v1) = fetch_ticks_around_current<T0, T1>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::empty<TickData>();
        let v5 = 0x1::vector::length<TickData>(&v3);
        while (v5 > 0) {
            let v6 = v5 - 1;
            v5 = v6;
            0x1::vector::push_back<TickData>(&mut v4, *0x1::vector::borrow<TickData>(&v3, v6));
        };
        v5 = 0;
        while (v5 < 0x1::vector::length<TickData>(&v2)) {
            0x1::vector::push_back<TickData>(&mut v4, *0x1::vector::borrow<TickData>(&v2, v5));
            v5 = v5 + 1;
        };
        v4
    }

    public fun fetch_ticks_with_event<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : (vector<TickData>, vector<TickData>) {
        let (v0, v1) = fetch_ticks_around_current<T0, T1>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::vector::length<TickData>(&v3);
        let v5 = 0x1::vector::length<TickData>(&v2);
        let (v6, v7) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::balances<T0, T1>(arg0);
        let v8 = TicksFetchedEvent{
            pool_id            : 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>>(arg0),
            fee_rate           : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::fee_rate<T0, T1>(arg0),
            coin_a             : v6,
            coin_b             : v7,
            liquidity          : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::liquidity<T0, T1>(arg0),
            current_tick_index : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_tick_index<T0, T1>(arg0),
            current_sqrt_price : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg0),
            left_ticks_count   : v4,
            left_ticks_vector  : v3,
            right_ticks_count  : v5,
            right_ticks_vector : v2,
            total_fetched      : v4 + v5,
        };
        0x2::event::emit<TicksFetchedEvent>(v8);
        (v3, v2)
    }

    // decompiled from Move bytecode v6
}

