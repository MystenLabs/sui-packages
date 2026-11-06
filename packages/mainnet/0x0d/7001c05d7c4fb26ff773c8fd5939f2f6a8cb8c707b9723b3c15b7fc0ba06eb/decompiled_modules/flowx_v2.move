module 0xd7001c05d7c4fb26ff773c8fd5939f2f6a8cb8c707b9723b3c15b7fc0ba06eb::flowx_v2 {
    public fun quote<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: bool) {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_pair<T1, T2>(arg1);
        let (v1, v2) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T1, T2>(v0);
        let v3 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::fee_rate<T1, T2>(v0);
        let (v4, v5) = if (arg2) {
            (v1, v2)
        } else {
            (v2, v1)
        };
        let v6 = vector[];
        let v7 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::quote_inputs<T0>(arg0);
        0x1::vector::reverse<u64>(&mut v7);
        let v8 = 0;
        while (v8 < 0x1::vector::length<u64>(&v7)) {
            let v9 = 0x1::vector::pop_back<u64>(&mut v7);
            let v10 = if (v9 == 0) {
                true
            } else if (v4 == 0) {
                true
            } else if (v5 == 0) {
                true
            } else if (v3 >= 10000) {
                true
            } else {
                (v4 as u128) + (v9 as u128) > 18446744073709551615
            };
            let v11 = if (v10) {
                0
            } else {
                0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::get_amount_out(v9, v4, v5, v3)
            };
            0x1::vector::push_back<u64>(&mut v6, v11);
            v8 = v8 + 1;
        };
        0x1::vector::destroy_empty<u64>(v7);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_quote<T0>(arg0, 0x2::object::id<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T1, T2>>(v0), arg2, v6, vector[], vector[]);
    }

    public fun swap_x2y<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair<T1, T2>(arg1);
        let v1 = 0x2::coin::into_balance<T2>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_x_to_y_direct<T1, T2>(v0, 0x2::coin::from_balance<T1>(arg2, arg3), arg3));
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T1, T2>>(v0), true, 0x2::balance::value<T2>(&v1));
        (v1, 0x2::balance::zero<T1>())
    }

    public fun swap_y2x<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: 0x2::balance::Balance<T2>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_mut_pair<T1, T2>(arg1);
        let v1 = 0x2::coin::into_balance<T1>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_y_to_x_direct<T1, T2>(v0, 0x2::coin::from_balance<T2>(arg2, arg3), arg3));
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::PairMetadata<T1, T2>>(v0), false, 0x2::balance::value<T1>(&v1));
        (v1, 0x2::balance::zero<T2>())
    }

    // decompiled from Move bytecode v7
}

