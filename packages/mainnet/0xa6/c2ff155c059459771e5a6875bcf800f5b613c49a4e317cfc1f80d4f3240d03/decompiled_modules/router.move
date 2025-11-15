module 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::router {
    struct MultiHopSwapped has copy, drop {
        trader: address,
        path_type: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        total_fee_sui: u64,
        num_hops: u64,
    }

    public fun get_amount_out_2_hop<T0, T1>(arg0: &0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::Pool<T0, 0x2::sui::SUI>, arg1: &0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::Pool<0x2::sui::SUI, T1>, arg2: u64) : u64 {
        0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::get_amount_out_a_to_b<0x2::sui::SUI, T1>(arg1, 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::get_amount_out_a_to_b<T0, 0x2::sui::SUI>(arg0, arg2))
    }

    public fun get_amount_out_2_pool_swap<T0, T1, T2>(arg0: &0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::Pool<T0, T1>, arg1: &0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::Pool<T1, T2>, arg2: u64) : u64 {
        0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::get_amount_out_a_to_b<T1, T2>(arg1, 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::get_amount_out_a_to_b<T0, T1>(arg0, arg2))
    }

    public fun get_amount_out_3_hop_via_sui<T0, T1, T2>(arg0: &0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::Pool<T0, 0x2::sui::SUI>, arg1: &0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::Pool<0x2::sui::SUI, T1>, arg2: &0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::Pool<T1, T2>, arg3: u64) : u64 {
        0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::get_amount_out_a_to_b<T1, T2>(arg2, 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::get_amount_out_a_to_b<0x2::sui::SUI, T1>(arg1, 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::get_amount_out_a_to_b<T0, 0x2::sui::SUI>(arg0, arg3)))
    }

    public fun get_swap_fee_fixed() : u64 {
        1000000000
    }

    public fun get_total_fee_any_swap() : u64 {
        1000000000
    }

    public fun swap_exact_tokens_for_tokens_2_hop<T0, T1>(arg0: &mut 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::Pool<T0, 0x2::sui::SUI>, arg1: &mut 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::Pool<0x2::sui::SUI, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 1000000000, 2);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v0 = 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::swap_a_for_b_with_fee<0x2::sui::SUI, T1>(arg1, 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::swap_a_for_b_with_fee<T0, 0x2::sui::SUI>(arg0, arg2, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, 1000000000 / 2, arg5), 0, arg5), 0x2::coin::split<0x2::sui::SUI>(&mut arg3, 1000000000 / 2, arg5), arg4, arg5);
        let v1 = MultiHopSwapped{
            trader        : 0x2::tx_context::sender(arg5),
            path_type     : b"2-hop",
            amount_in     : 0x2::coin::value<T0>(&arg2),
            amount_out    : 0x2::coin::value<T1>(&v0),
            total_fee_sui : 1000000000,
            num_hops      : 2,
        };
        0x2::event::emit<MultiHopSwapped>(v1);
        v0
    }

    public fun swap_exact_tokens_for_tokens_2_hop_reverse<T0, T1>(arg0: &mut 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::Pool<T0, 0x2::sui::SUI>, arg1: &mut 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::Pool<0x2::sui::SUI, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 1000000000, 2);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v0 = 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::swap_b_for_a_with_fee<T0, 0x2::sui::SUI>(arg0, 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::swap_b_for_a_with_fee<0x2::sui::SUI, T1>(arg1, arg2, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, 1000000000 / 2, arg5), 0, arg5), 0x2::coin::split<0x2::sui::SUI>(&mut arg3, 1000000000 / 2, arg5), arg4, arg5);
        let v1 = MultiHopSwapped{
            trader        : 0x2::tx_context::sender(arg5),
            path_type     : b"2-hop-reverse",
            amount_in     : 0x2::coin::value<T1>(&arg2),
            amount_out    : 0x2::coin::value<T0>(&v0),
            total_fee_sui : 1000000000,
            num_hops      : 2,
        };
        0x2::event::emit<MultiHopSwapped>(v1);
        v0
    }

    public fun swap_exact_tokens_for_tokens_3_hop<T0, T1, T2>(arg0: &mut 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::Pool<T0, T1>, arg1: &mut 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::Pool<T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 1000000000, 2);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v0 = 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::swap_a_for_b_with_fee<T1, T2>(arg1, 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::swap_a_for_b_with_fee<T0, T1>(arg0, arg2, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, 1000000000 / 2, arg5), 0, arg5), 0x2::coin::split<0x2::sui::SUI>(&mut arg3, 1000000000 / 2, arg5), arg4, arg5);
        let v1 = MultiHopSwapped{
            trader        : 0x2::tx_context::sender(arg5),
            path_type     : b"2-pool-swap",
            amount_in     : 0x2::coin::value<T0>(&arg2),
            amount_out    : 0x2::coin::value<T2>(&v0),
            total_fee_sui : 1000000000,
            num_hops      : 2,
        };
        0x2::event::emit<MultiHopSwapped>(v1);
        v0
    }

    public fun swap_via_sui_3_hop<T0, T1, T2>(arg0: &mut 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::Pool<T0, 0x2::sui::SUI>, arg1: &mut 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::Pool<0x2::sui::SUI, T1>, arg2: &mut 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::Pool<T1, T2>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= 1000000000, 2);
        let v0 = 1000000000 / 3;
        if (0x2::coin::value<0x2::sui::SUI>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        };
        let v1 = 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::swap_a_for_b_with_fee<T1, T2>(arg2, 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::swap_a_for_b_with_fee<0x2::sui::SUI, T1>(arg1, 0xbcf1564932be855733bd9c1b13e4926206729e685f44bfbb9907a46074ea3bf3::pool::swap_a_for_b_with_fee<T0, 0x2::sui::SUI>(arg0, arg3, 0x2::coin::split<0x2::sui::SUI>(&mut arg4, v0, arg6), 0, arg6), 0x2::coin::split<0x2::sui::SUI>(&mut arg4, v0, arg6), 0, arg6), 0x2::coin::split<0x2::sui::SUI>(&mut arg4, v0, arg6), arg5, arg6);
        let v2 = MultiHopSwapped{
            trader        : 0x2::tx_context::sender(arg6),
            path_type     : b"3-pool-swap",
            amount_in     : 0x2::coin::value<T0>(&arg3),
            amount_out    : 0x2::coin::value<T2>(&v1),
            total_fee_sui : 1000000000,
            num_hops      : 3,
        };
        0x2::event::emit<MultiHopSwapped>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

