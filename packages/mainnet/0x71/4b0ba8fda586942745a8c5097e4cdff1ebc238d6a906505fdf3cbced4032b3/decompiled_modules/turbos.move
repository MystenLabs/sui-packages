module 0xd88ebdabeaead893d6ce24259bf596627ff4d209b9e1541c2eb7997fa90651d2::turbos {
    struct TurbosPoolTick has copy, drop {
        data: vector<u8>,
    }

    struct TurbosPoolTickV2 has copy, drop {
        index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        data: vector<u8>,
    }

    struct TurbosPoolStatus has copy, drop {
        index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        sqrt_price: u128,
    }

    public entry fun fetcher<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>) {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_tick_spacing<T0, T1, T2>(arg0);
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::get_min_tick(v0);
        while (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lte(v1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::get_max_tick(v0))) {
            let v2 = TurbosPoolTickV2{
                index : v1,
                data  : 0x1::bcs::to_bytes<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Tick>(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick<T0, T1, T2>(arg0, v1)),
            };
            0x2::event::emit<TurbosPoolTickV2>(v2);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::add(v1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(v0));
        };
    }

    public entry fun fetcher_v2<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: vector<u32>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u32>(&arg1)) {
            let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(*0x1::vector::borrow<u32>(&arg1, v0));
            let v2 = TurbosPoolTickV2{
                index : v1,
                data  : 0x1::bcs::to_bytes<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Tick>(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick<T0, T1, T2>(arg0, v1)),
            };
            0x2::event::emit<TurbosPoolTickV2>(v2);
            v0 = v0 + 1;
        };
        let v3 = TurbosPoolStatus{
            index      : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg0),
            sqrt_price : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0),
        };
        0x2::event::emit<TurbosPoolStatus>(v3);
    }

    // decompiled from Move bytecode v6
}

