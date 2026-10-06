module 0x70148e5327abd44eb6d88d816a413dfec6bc54dcfc8a2561ddd9bc845f2c5f3c::deepbook {
    public fun assert_best_ask_le<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1 >= 1 && arg1 <= 9223372036854775807, 503);
        let (_, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_range<T0, T1>(arg0, 1, arg1, false, arg3);
        let v2 = v1;
        assert!(enough(&v2, arg2), 501);
    }

    public fun assert_best_bid_ge<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1 >= 1 && arg1 <= 9223372036854775807, 503);
        let (_, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_range<T0, T1>(arg0, arg1, 9223372036854775807, true, arg3);
        let v2 = v1;
        assert!(enough(&v2, arg2), 502);
    }

    fun enough(arg0: &vector<u64>, arg1: u64) : bool {
        let v0 = if (arg1 == 0) {
            1
        } else {
            (arg1 as u128)
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(arg0)) {
            let v3 = v1 + (*0x1::vector::borrow<u64>(arg0, v2) as u128);
            v1 = v3;
            if (v3 >= v0) {
                return true
            };
            v2 = v2 + 1;
        };
        false
    }

    // decompiled from Move bytecode v7
}

