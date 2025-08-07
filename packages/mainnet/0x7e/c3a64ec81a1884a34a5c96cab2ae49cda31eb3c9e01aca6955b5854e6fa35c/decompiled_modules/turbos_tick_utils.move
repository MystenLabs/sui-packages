module 0x7ec3a64ec81a1884a34a5c96cab2ae49cda31eb3c9e01aca6955b5854e6fa35c::turbos_tick_utils {
    public entry fun fetch_ticks_around_center<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned) {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_tick_spacing<T0, T1, T2>(arg0);
        let v1 = 0x1::vector::empty<u32>();
        0x1::vector::push_back<u32>(&mut v1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg0), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(400 / v0 * v0))));
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool_fetcher::fetch_ticks<T0, T1, T2>(arg0, v1, false, 800 / (v0 as u64) + 1, arg1);
    }

    // decompiled from Move bytecode v6
}

