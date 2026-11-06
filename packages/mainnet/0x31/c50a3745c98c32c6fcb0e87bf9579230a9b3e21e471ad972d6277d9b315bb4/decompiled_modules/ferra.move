module 0x31c50a3745c98c32c6fcb0e87bf9579230a9b3e21e471ad972d6277d9b315bb4::ferra {
    fun check<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>) {
        version_gate(0x2::bcs::to_bytes<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig>(arg0));
        0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::checked_package_version(arg0);
        assert!(!0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::global_paused(arg0), 5);
        let v0 = 0x2::bcs::new(0x2::bcs::to_bytes<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>>(arg1));
        0x2::bcs::peel_address(&mut v0);
        assert!(!0x2::bcs::peel_bool(&mut v0), 5);
    }

    public fun quote<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T1, T2>, arg2: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: bool) {
        check<T1, T2>(arg2, arg1);
        let v0 = vector[];
        let v1 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::quote_inputs<T0>(arg0);
        0x1::vector::reverse<u64>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            let v3 = 0x1::vector::pop_back<u64>(&mut v1);
            let v4 = if (v3 == 0) {
                0
            } else {
                let (v5, v6, _) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_swap_out<T1, T2>(arg1, v3, arg4, arg3);
                if (v5 == 0) {
                    v6
                } else {
                    0
                }
            };
            0x1::vector::push_back<u64>(&mut v0, v4);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(v1);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_quote<T0>(arg0, 0x2::object::id<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T1, T2>>(arg1), arg4, v0, vector[], vector[]);
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T1, T2>, arg2: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        check<T1, T2>(arg2, arg1);
        assert!(0x2::balance::value<T1>(&arg4) > 0, 1);
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T1, T2>(arg2, arg1, true, 1, 0x2::coin::from_balance<T1>(arg4, arg5), 0x2::coin::zero<T2>(arg5), arg3, arg5);
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::coin::value<T1>(&v3) == 0, 2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T1, T2>>(arg1), true, 0x2::coin::value<T2>(&v2));
        (0x2::coin::into_balance<T2>(v2), 0x2::coin::into_balance<T1>(v3))
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T1, T2>, arg2: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T2>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        check<T1, T2>(arg2, arg1);
        assert!(0x2::balance::value<T2>(&arg4) > 0, 1);
        let (v0, v1) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::swap<T1, T2>(arg2, arg1, false, 1, 0x2::coin::zero<T1>(arg5), 0x2::coin::from_balance<T2>(arg4, arg5), arg3, arg5);
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::coin::value<T2>(&v2) == 0, 2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T1, T2>>(arg1), false, 0x2::coin::value<T1>(&v3));
        (0x2::coin::into_balance<T1>(v3), 0x2::coin::into_balance<T2>(v2))
    }

    fun version_gate(arg0: vector<u8>) {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 >= 41, 4);
        let v1 = b"";
        let v2 = v0 - 8;
        while (v2 < v0) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg0, v2));
            v2 = v2 + 1;
        };
        let v3 = 0x2::bcs::new(v1);
        assert!(0x2::bcs::peel_u64(&mut v3) == 2, 3);
    }

    // decompiled from Move bytecode v7
}

