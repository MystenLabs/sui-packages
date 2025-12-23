module 0xc588673bbcac634a497919288250813f7488d7361d1a3b107e349dbed89a90a4::cetus_dlmm {
    public fun swap<T0, T1>(arg0: &mut 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::SwapContext, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg4: bool, arg5: u64, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8);
        };
    }

    fun flash_swap<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg3: u64, arg4: bool, arg5: bool, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>, u64) {
        let (v0, v1, v2) = if (0x2::object::id_address<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner>(arg2) == @0x59ae16f6c42f578063c2da9b9c0173fe58120ceae08e40fd8212c8eceb80bb86) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg1, arg4, arg5, arg3, arg0, arg6, arg7, arg8)
        } else {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap_with_partner<T0, T1>(arg1, arg2, arg4, arg5, arg3, arg0, arg6, arg7, arg8)
        };
        let v3 = v2;
        (v0, v1, v3, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v3))
    }

    fun repay_flash_swap<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg2: bool, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>, arg6: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = if (arg2) {
            (0x2::balance::split<T0>(&mut arg3, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&arg5)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg4, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&arg5)))
        };
        if (0x2::object::id_address<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner>(arg1) == @0x59ae16f6c42f578063c2da9b9c0173fe58120ceae08e40fd8212c8eceb80bb86) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg0, v0, v1, arg5, arg6);
        } else {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, v0, v1, arg5, arg6);
        };
        (arg3, arg4)
    }

    public fun flash_swap_fixed_output<T0, T1>(arg0: &mut 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::SwapContext, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg4: u64, arg5: bool, arg6: bool, arg7: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>, u64) {
        let (v0, v1, v2, v3) = flash_swap<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v4 = v1;
        let v5 = v0;
        if (0x2::balance::value<T0>(&v5) > 0) {
            0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::merge_balance<T0>(arg0, v5);
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        if (0x2::balance::value<T1>(&v4) > 0) {
            0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::merge_balance<T1>(arg0, v4);
        } else {
            0x2::balance::destroy_zero<T1>(v4);
        };
        if (arg5) {
            0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::emit_swap_event<T0, T1>(arg0, b"CETUSDLMM", 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg2), v3, arg4, 0);
        } else {
            0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::emit_swap_event<T1, T0>(arg0, b"CETUSDLMM", 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg2), v3, arg4, 0);
        };
        (v2, v3)
    }

    public fun repay_flash_swap_fixed_output<T0, T1>(arg0: &mut 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::SwapContext, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg3: bool, arg4: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::FlashSwapReceipt<T0, T1>, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        let (v0, v1) = if (arg3) {
            (0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::take_balance<T0>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&arg4)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::take_balance<T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&arg4)))
        };
        let (v2, v3) = repay_flash_swap<T0, T1>(arg1, arg2, arg3, v0, v1, arg4, arg5);
        let v4 = v3;
        let v5 = v2;
        if (0x2::balance::value<T0>(&v5) > 0) {
            0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::merge_balance<T0>(arg0, v5);
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        if (0x2::balance::value<T1>(&v4) > 0) {
            0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::merge_balance<T1>(arg0, v4);
        } else {
            0x2::balance::destroy_zero<T1>(v4);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::SwapContext, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg4: u64, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::take_balance<T0>(arg0, arg4);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, v4, _) = flash_swap<T0, T1>(arg1, arg2, arg3, v1, true, true, arg5, arg6, arg7);
        let v6 = v3;
        let (v7, v8) = repay_flash_swap<T0, T1>(arg2, arg3, true, v0, 0x2::balance::zero<T1>(), v4, arg5);
        let v9 = v7;
        0x2::balance::destroy_zero<T0>(v2);
        0x2::balance::destroy_zero<T1>(v8);
        let v10 = 0x2::balance::value<T0>(&v9);
        if (arg4 == 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::max_amount_in()) {
            0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::transfer_balance<T0>(v9, 0x2::tx_context::sender(arg7), arg7);
        } else {
            0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::merge_balance<T0>(arg0, v9);
        };
        0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::merge_balance<T1>(arg0, v6);
        0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::emit_swap_event<T0, T1>(arg0, b"CETUSDLMM", 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg2), v1 - v10, 0x2::balance::value<T1>(&v6), v10);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::SwapContext, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::partner::Partner, arg4: u64, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::take_balance<T1>(arg0, arg4);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, v4, _) = flash_swap<T0, T1>(arg1, arg2, arg3, v1, false, true, arg5, arg6, arg7);
        let v6 = v2;
        let (v7, v8) = repay_flash_swap<T0, T1>(arg2, arg3, false, 0x2::balance::zero<T0>(), v0, v4, arg5);
        let v9 = v8;
        0x2::balance::destroy_zero<T1>(v3);
        0x2::balance::destroy_zero<T0>(v7);
        let v10 = 0x2::balance::value<T1>(&v9);
        if (arg4 == 0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::max_amount_in()) {
            0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::transfer_balance<T1>(v9, 0x2::tx_context::sender(arg7), arg7);
        } else {
            0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::merge_balance<T1>(arg0, v9);
        };
        0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::merge_balance<T0>(arg0, v6);
        0x422e3239f174320760dd675ba3835cf4b1c511be4a36e819cb61fab7d5d404a::router::emit_swap_event<T1, T0>(arg0, b"CETUSDLMM", 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg2), v1 - v10, 0x2::balance::value<T0>(&v6), v10);
    }

    // decompiled from Move bytecode v6
}

