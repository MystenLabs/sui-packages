module 0x2ec631cb49306cdb90cd1c05117b453ea6fd9a85833a8a2a596d7d156eb0abfb::cetus_dlmm {
    fun check_gate(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        gate(0x2::bcs::to_bytes<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned>(arg0));
    }

    public fun flash_a2b<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>) {
        check_gate(arg3);
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T0>(arg0);
        let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg1, true, true, v0, arg2, arg3, arg4, arg5);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v4) == v0, 2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1), true, 0x2::balance::value<T1>(&v5));
        (v5, v4)
    }

    public fun flash_a2b_partner<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>) {
        check_gate(arg4);
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T0>(arg0);
        let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap_with_partner<T0, T1>(arg1, arg2, true, true, v0, arg3, arg4, arg5, arg6);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T0>(v1);
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v4) == v0, 2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1), true, 0x2::balance::value<T1>(&v5));
        (v5, v4)
    }

    public fun flash_b2a<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>) {
        check_gate(arg3);
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T1>(arg0);
        let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg1, false, true, v0, arg2, arg3, arg4, arg5);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v4) == v0, 2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T1>(arg0, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1), false, 0x2::balance::value<T0>(&v5));
        (v5, v4)
    }

    public fun flash_b2a_partner<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>) {
        check_gate(arg4);
        let v0 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::open_loan<T1>(arg0);
        let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap_with_partner<T0, T1>(arg1, arg2, false, true, v0, arg3, arg4, arg5, arg6);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T1>(v2);
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v4) == v0, 2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T1>(arg0, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1), false, 0x2::balance::value<T0>(&v5));
        (v5, v4)
    }

    fun gate(arg0: vector<u8>) {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_address(&mut v0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 4);
        assert!(0x2::bcs::peel_u64(&mut v0) == 10, 3);
    }

    public fun repay_a2b<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: 0x2::balance::Balance<T0>, arg4: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T0> {
        check_gate(arg2);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg1, 0x2::balance::split<T0>(&mut arg3, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_loan<T0>(arg0, &mut arg3)), 0x2::balance::zero<T1>(), arg4, arg2);
        arg3
    }

    public fun repay_a2b_partner<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: 0x2::balance::Balance<T0>, arg5: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T0> {
        check_gate(arg3);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap_with_partner<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut arg4, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_loan<T0>(arg0, &mut arg4)), 0x2::balance::zero<T1>(), arg5, arg3);
        arg4
    }

    public fun repay_b2a<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: 0x2::balance::Balance<T1>, arg4: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T1> {
        check_gate(arg2);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_loan<T1>(arg0, &mut arg3)), arg4, arg2);
        arg3
    }

    public fun repay_b2a_partner<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: 0x2::balance::Balance<T1>, arg5: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T1> {
        check_gate(arg3);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap_with_partner<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg4, 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::close_loan<T1>(arg0, &mut arg4)), arg5, arg3);
        arg4
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T1, T2>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        check_gate(arg3);
        let v0 = 0x2::balance::value<T1>(&arg5);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T1, T2>(arg1, true, true, v0, arg2, arg3, arg4, arg6);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T1, T2>(arg1, 0x2::balance::split<T1>(&mut arg5, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T1, T2>(&v4)), 0x2::balance::zero<T2>(), v4, arg3);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T1, T2>>(arg1), true, 0x2::balance::value<T2>(&v5));
        (v5, arg5)
    }

    public fun swap_a2b_partner<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T1, T2>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: 0x2::balance::Balance<T1>, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        check_gate(arg4);
        let v0 = 0x2::balance::value<T1>(&arg6);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap_with_partner<T1, T2>(arg1, arg2, true, true, v0, arg3, arg4, arg5, arg7);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::destroy_zero<T1>(v1);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap_with_partner<T1, T2>(arg1, arg2, 0x2::balance::split<T1>(&mut arg6, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T1, T2>(&v4)), 0x2::balance::zero<T2>(), v4, arg4);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T1, T2>>(arg1), true, 0x2::balance::value<T2>(&v5));
        (v5, arg6)
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T1, T2>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T2>, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        check_gate(arg3);
        let v0 = 0x2::balance::value<T2>(&arg5);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T1, T2>(arg1, false, true, v0, arg2, arg3, arg4, arg6);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T2>(v2);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T1, T2>(arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut arg5, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T1, T2>(&v4)), v4, arg3);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T1, T2>>(arg1), false, 0x2::balance::value<T1>(&v5));
        (v5, arg5)
    }

    public fun swap_b2a_partner<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T1, T2>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: 0x2::balance::Balance<T2>, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        check_gate(arg4);
        let v0 = 0x2::balance::value<T2>(&arg6);
        assert!(v0 > 0, 1);
        let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap_with_partner<T1, T2>(arg1, arg2, false, true, v0, arg3, arg4, arg5, arg7);
        let v4 = v3;
        let v5 = v1;
        0x2::balance::destroy_zero<T2>(v2);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap_with_partner<T1, T2>(arg1, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut arg6, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T1, T2>(&v4)), v4, arg4);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T1, T2>>(arg1), false, 0x2::balance::value<T1>(&v5));
        (v5, arg6)
    }

    // decompiled from Move bytecode v7
}

