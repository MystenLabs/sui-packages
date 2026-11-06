module 0xb2be3ddc0321bcfb77236673c370adea494a6ba8e0e9cbe7d199c60d04a75451::suidex_v2 {
    fun output(arg0: u64, arg1: u256, arg2: u256, arg3: u64, arg4: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg1 > 18446744073709551615) {
            true
        } else {
            arg2 > 18446744073709551615
        };
        if (v0) {
            return 0
        };
        let v1 = (arg0 as u256);
        let v2 = v1 * 9970;
        let v3 = v2 * arg2 / (arg1 * 10000 + v2);
        let v4 = v1 * 30 / 10000;
        let v5 = (arg3 as u256) + v1;
        let v6 = if (v5 > 18446744073709551615) {
            true
        } else if (v3 == 0) {
            true
        } else if (v3 >= arg2) {
            true
        } else {
            v3 > (arg4 as u256)
        };
        if (v6) {
            return 0
        };
        let v7 = v5 - v4 * 9 / 30 + v4 * 3 / 30 + v4 * 3 / 30;
        let v8 = (arg4 as u256) - v3;
        let v9 = if (v7 < 1000) {
            true
        } else if (v8 < 1000) {
            true
        } else {
            v7 * v8 < arg1 * arg2
        };
        if (v9) {
            return 0
        };
        (v3 as u64)
    }

    public fun quote<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T1, T2>, arg2: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::factory::Factory, arg3: &0x2::clock::Clock, arg4: bool) {
        let (v0, v1, v2) = 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::get_reserves<T1, T2>(arg1);
        let v3 = 0x2::bcs::new(0x2::bcs::to_bytes<0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T1, T2>>(arg1));
        0x2::bcs::peel_address(&mut v3);
        let v4 = !0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::factory::is_paused(arg2) && v2 <= 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::get_token_position<T1, T2>(arg2), 1);
        let v5 = vector[];
        let v6 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::quote_inputs<T0>(arg0);
        0x1::vector::reverse<u64>(&mut v6);
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&v6)) {
            let v8 = if (!v4) {
                0
            } else if (arg4) {
                output(0x1::vector::pop_back<u64>(&mut v6), v0, v1, 0x2::bcs::peel_u64(&mut v3), 0x2::bcs::peel_u64(&mut v3))
            } else {
                output(0x1::vector::pop_back<u64>(&mut v6), v1, v0, 0x2::bcs::peel_u64(&mut v3), 0x2::bcs::peel_u64(&mut v3))
            };
            0x1::vector::push_back<u64>(&mut v5, v8);
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<u64>(v6);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_quote<T0>(arg0, 0x2::object::id<0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T1, T2>>(arg1), arg4, v5, vector[], vector[]);
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T1, T2>, arg2: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::factory::Factory, arg3: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::Router, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::coin::into_balance<T2>(0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::swap_exact_tokens0_for_tokens1_composable<T1, T2>(arg3, arg2, arg1, 0x2::coin::from_balance<T1>(arg5, arg6), 1, arg4, arg6));
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T1, T2>>(arg1), true, 0x2::balance::value<T2>(&v0));
        (v0, 0x2::balance::zero<T1>())
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T1, T2>, arg2: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::factory::Factory, arg3: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::Router, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T2>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x2::coin::into_balance<T1>(0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::router::swap_exact_tokens1_for_tokens0_composable<T1, T2>(arg3, arg2, arg1, 0x2::coin::from_balance<T2>(arg5, arg6), 1, arg4, arg6));
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T1, T2>>(arg1), false, 0x2::balance::value<T1>(&v0));
        (v0, 0x2::balance::zero<T2>())
    }

    // decompiled from Move bytecode v7
}

