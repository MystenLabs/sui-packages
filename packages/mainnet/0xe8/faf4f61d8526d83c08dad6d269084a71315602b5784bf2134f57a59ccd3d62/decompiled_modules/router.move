module 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::router {
    struct MultiHopSwapped has copy, drop {
        trader: address,
        path_type: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        num_hops: u64,
    }

    public entry fun entry_swap_2_hop<T0, T1>(arg0: &mut 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<T0, 0x2::sui::SUI>, arg1: &mut 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<0x2::sui::SUI, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_2_hop<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg6));
    }

    public entry fun entry_swap_2_hop_reverse<T0, T1>(arg0: &mut 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<T0, 0x2::sui::SUI>, arg1: &mut 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<0x2::sui::SUI, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_2_hop_reverse<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun quote_2_hop<T0, T1>(arg0: &0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<T0, 0x2::sui::SUI>, arg1: &0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<0x2::sui::SUI, T1>, arg2: u64) : u64 {
        0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::get_amount_out_a_to_b<0x2::sui::SUI, T1>(arg1, 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::get_amount_out_a_to_b<T0, 0x2::sui::SUI>(arg0, arg2))
    }

    public fun quote_2_hop_reverse<T0, T1>(arg0: &0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<T0, 0x2::sui::SUI>, arg1: &0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<0x2::sui::SUI, T1>, arg2: u64) : u64 {
        0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::get_amount_out_b_to_a<T0, 0x2::sui::SUI>(arg0, 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::get_amount_out_b_to_a<0x2::sui::SUI, T1>(arg1, arg2))
    }

    public fun quote_3_hop<T0, T1, T2>(arg0: &0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<T0, T1>, arg1: &0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<T1, T2>, arg2: u64) : u64 {
        0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::get_amount_out_a_to_b<T1, T2>(arg1, 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::get_amount_out_a_to_b<T0, T1>(arg0, arg2))
    }

    public fun quote_via_sui_3_hop<T0, T1, T2>(arg0: &0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<T0, 0x2::sui::SUI>, arg1: &0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<0x2::sui::SUI, T1>, arg2: &0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<T1, T2>, arg3: u64) : u64 {
        0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::get_amount_out_a_to_b<T1, T2>(arg2, 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::get_amount_out_a_to_b<0x2::sui::SUI, T1>(arg1, 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::get_amount_out_a_to_b<T0, 0x2::sui::SUI>(arg0, arg3)))
    }

    public fun swap_2_hop<T0, T1>(arg0: &mut 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<T0, 0x2::sui::SUI>, arg1: &mut 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<0x2::sui::SUI, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2);
        let v1 = 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::swap_a_for_b<0x2::sui::SUI, T1>(arg1, 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::swap_a_for_b<T0, 0x2::sui::SUI>(arg0, arg2, 0, arg4, arg5, arg6), arg3, arg4, arg5, arg6);
        let v2 = MultiHopSwapped{
            trader     : 0x2::tx_context::sender(arg6),
            path_type  : b"X-SUI-Y",
            amount_in  : v0,
            amount_out : 0x2::coin::value<T1>(&v1),
            num_hops   : 2,
        };
        0x2::event::emit<MultiHopSwapped>(v2);
        v1
    }

    public fun swap_2_hop_reverse<T0, T1>(arg0: &mut 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<T0, 0x2::sui::SUI>, arg1: &mut 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<0x2::sui::SUI, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0, 2);
        let v1 = 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::swap_b_for_a<T0, 0x2::sui::SUI>(arg0, 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::swap_b_for_a<0x2::sui::SUI, T1>(arg1, arg2, 0, arg4, arg5, arg6), arg3, arg4, arg5, arg6);
        let v2 = MultiHopSwapped{
            trader     : 0x2::tx_context::sender(arg6),
            path_type  : b"Y-SUI-X",
            amount_in  : v0,
            amount_out : 0x2::coin::value<T0>(&v1),
            num_hops   : 2,
        };
        0x2::event::emit<MultiHopSwapped>(v2);
        v1
    }

    public fun swap_3_hop<T0, T1, T2>(arg0: &mut 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<T0, T1>, arg1: &mut 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2);
        let v1 = 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::swap_a_for_b<T1, T2>(arg1, 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::swap_a_for_b<T0, T1>(arg0, arg2, 0, arg4, arg5, arg6), arg3, arg4, arg5, arg6);
        let v2 = MultiHopSwapped{
            trader     : 0x2::tx_context::sender(arg6),
            path_type  : b"A-B-C",
            amount_in  : v0,
            amount_out : 0x2::coin::value<T2>(&v1),
            num_hops   : 2,
        };
        0x2::event::emit<MultiHopSwapped>(v2);
        v1
    }

    public fun swap_via_sui_3_hop<T0, T1, T2>(arg0: &mut 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<T0, 0x2::sui::SUI>, arg1: &mut 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<0x2::sui::SUI, T1>, arg2: &mut 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::Pool<T1, T2>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 2);
        let v1 = 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::swap_a_for_b<T1, T2>(arg2, 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::swap_a_for_b<0x2::sui::SUI, T1>(arg1, 0xe8faf4f61d8526d83c08dad6d269084a71315602b5784bf2134f57a59ccd3d62::pool::swap_a_for_b<T0, 0x2::sui::SUI>(arg0, arg3, 0, arg5, arg6, arg7), 0, arg5, arg6, arg7), arg4, arg5, arg6, arg7);
        let v2 = MultiHopSwapped{
            trader     : 0x2::tx_context::sender(arg7),
            path_type  : b"A-SUI-B-C",
            amount_in  : v0,
            amount_out : 0x2::coin::value<T2>(&v1),
            num_hops   : 3,
        };
        0x2::event::emit<MultiHopSwapped>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

