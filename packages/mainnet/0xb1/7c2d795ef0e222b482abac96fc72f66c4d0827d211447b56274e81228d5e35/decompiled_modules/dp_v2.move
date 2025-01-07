module 0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::dp_v2 {
    public fun dp_swap_ab<T0, T1>(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Permits, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0xdee9::custodian_v2::AccountCap, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64, u64) {
        0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::valid(arg0, 0x2::tx_context::sender(arg6));
        let v0 = 0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::help::merge_all<T0>(arg3, arg6);
        let (v1, v2, v3) = 0xdee9::clob_v2::swap_exact_base_for_quote<T0, T1>(arg1, 8235, arg2, arg4, 0x2::coin::split<T0>(&mut v0, arg4, arg6), 0x2::coin::zero<T1>(arg6), arg5, arg6);
        0x2::coin::join<T0>(&mut v0, v1);
        0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::help::transfer<T0>(v0, 0x2::tx_context::sender(arg6));
        (v2, 0x2::coin::value<T0>(&v0) - 0x2::coin::value<T0>(&v0), v3)
    }

    public fun dp_swap_ab1<T0, T1>(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Permits, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0xdee9::custodian_v2::AccountCap, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T1>>, u64, u64) {
        let (v0, v1, v2) = dp_swap_ab<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v3 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v3, v0);
        (v3, v1, v2)
    }

    public fun dp_swap_ba<T0, T1>(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Permits, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0xdee9::custodian_v2::AccountCap, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, u64) {
        0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::valid(arg0, 0x2::tx_context::sender(arg6));
        let v0 = 0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::help::merge_all<T1>(arg3, arg6);
        let (v1, v2, v3) = 0xdee9::clob_v2::swap_exact_quote_for_base<T0, T1>(arg1, 8235, arg2, arg4, arg5, 0x2::coin::split<T1>(&mut v0, arg4, arg6), arg6);
        0x2::coin::join<T1>(&mut v0, v2);
        0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::help::transfer<T1>(v0, 0x2::tx_context::sender(arg6));
        (v1, 0x2::coin::value<T1>(&v0) - 0x2::coin::value<T1>(&v0), v3)
    }

    public fun dp_swap_ba1<T0, T1>(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Permits, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0xdee9::custodian_v2::AccountCap, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, u64, u64) {
        let (v0, v1, v2) = dp_swap_ba<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v3 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v3, v0);
        (v3, v1, v2)
    }

    // decompiled from Move bytecode v6
}

