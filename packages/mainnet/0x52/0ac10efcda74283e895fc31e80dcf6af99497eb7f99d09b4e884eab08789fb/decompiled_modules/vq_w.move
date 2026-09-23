module 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::vq_w {
    fun r(arg0: vector<u8>, arg1: bool, arg2: u64) : u64 {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_u128(&mut v0);
        0x2::bcs::peel_u128(&mut v0);
        0x2::bcs::peel_u32(&mut v0);
        0x2::bcs::peel_u128(&mut v0);
        0x2::bcs::peel_u128(&mut v0);
        0x2::bcs::peel_u128(&mut v0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 180);
        let (v2, v3) = if (arg1) {
            (0x2::bcs::peel_u128(&mut v0), 0x2::bcs::peel_u128(&mut v0))
        } else {
            (0x2::bcs::peel_u128(&mut v0), 0x2::bcs::peel_u128(&mut v0))
        };
        let v4 = if (0x2::bcs::peel_u128(&mut v0) != 0) {
            true
        } else if (v2 != (arg2 as u128)) {
            true
        } else if (0x2::bcs::peel_u128(&mut v0) == 0) {
            true
        } else {
            v3 > 18446744073709551615
        };
        if (v4) {
            return 0
        };
        (v3 as u64)
    }

    public fun w<T0, T1, T2>(arg0: &mut 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::Ht, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v1 = 0;
        while (v1 < 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::cn(arg0)) {
            let v2 = 0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::ra(arg0, v1);
            if (v2 > 0) {
                let v3 = if (!0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_unlocked<T0, T1, T2>(arg1)) {
                    0
                } else {
                    let v4 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool_fetcher::compute_swap_result<T0, T1, T2>(arg1, arg2, (v2 as u128), true, v0, arg3, arg4, arg5);
                    r(0x2::bcs::to_bytes<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::ComputeSwapState>(&v4), arg2, v2)
                };
                0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::sr(arg0, v1, v3);
            };
            v1 = v1 + 1;
        };
        0x520ac10efcda74283e895fc31e80dcf6af99497eb7f99d09b4e884eab08789fb::hz::np(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), arg2);
    }

    // decompiled from Move bytecode v7
}

