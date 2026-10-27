module 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::walk {
    public fun centered_sum(arg0: u256) : (bool, u128) {
        let v0 = ((arg0 & 18446744073709551615) as u128) + ((arg0 >> 64 & 18446744073709551615) as u128) + ((arg0 >> 128 & 18446744073709551615) as u128) + ((arg0 >> 192) as u128);
        let v1 = 2 * 18446744073709551615;
        let v2 = v0 >= v1;
        let v3 = if (v2) {
            v0 - v1
        } else {
            v1 - v0
        };
        (v2, v3)
    }

    public fun price_one() : u64 {
        1000000000
    }

    public fun start_price() : u64 {
        1000000000000
    }

    public fun step(arg0: u64, arg1: u256, arg2: u64) : u64 {
        let (v0, v1) = centered_sum(arg1);
        let v2 = (((arg0 as u256) * ((arg2 as u256) * (v1 as u256) >> 64) + 9223372036854775808 >> 64) as u64);
        let v3 = if (arg0 > 1000000000000000000 - v2) {
            1000000000000000000
        } else {
            arg0 + v2
        };
        let v4 = if (arg0 <= v2) {
            1
        } else {
            arg0 - v2
        };
        if (v0) {
            v3
        } else {
            v4
        }
    }

    public fun step_q64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::isqrt((arg1 as u128) * 3 * 340282366920938463);
        assert!(v0 <= (4611686018427387904 as u128), 0);
        (v0 as u64)
    }

    // decompiled from Move bytecode v7
}

