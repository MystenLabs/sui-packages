module 0xb90e42b6127f512624bdc405be55abedc768b8e4779c693795019fb24571af56::fetcher {
    public fun fetch_ticks<T0, T1>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, arg1: u32, arg2: u64) : vector<0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::Tick> {
        let v0 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::borrow_tick_table<T0, T1>(arg0);
        let v1 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::borrow_tick_bitmap<T0, T1>(arg0);
        let v2 = 0x1::vector::empty<0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::Tick>();
        let v3 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from_u32(arg1);
        if (0x2::table::contains<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::Tick>(v0, v3)) {
            0x1::vector::push_back<0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::Tick>(&mut v2, *0x2::table::borrow<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::Tick>(v0, v3));
        };
        while (0x1::vector::length<0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::Tick>(&v2) < arg2 && 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lt(v3, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::max_tick())) {
            let (v4, v5) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_bitmap::next_initialized_tick_within_one_word(v1, v3, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::tick_spacing<T0, T1>(arg0), false);
            if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::lte(v4, v3)) {
                break
            };
            if (v5 && 0x2::table::contains<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::Tick>(v0, v4)) {
                0x1::vector::push_back<0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::Tick>(&mut v2, *0x2::table::borrow<0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::I32, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick::Tick>(v0, v4));
            };
            v3 = v4;
        };
        v2
    }

    // decompiled from Move bytecode v7
}

