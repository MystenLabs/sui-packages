module 0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::ky {
    public fun swap_ab<T0, T1>(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Permits, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::valid(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::help::merge_all<T0>(arg2, arg4);
        let v1 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg1, 0x2::coin::split<T0>(&mut v0, arg3, arg4), arg3, 0, arg4);
        0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::help::transfer<T0>(v0, 0x2::tx_context::sender(arg4));
        (v1, 0x2::coin::value<T1>(&v1))
    }

    public fun swap_ab1<T0, T1>(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Permits, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T1>>, u64) {
        let (v0, v1) = swap_ab<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, v0);
        (v2, v1)
    }

    public fun swap_ba<T0, T1>(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Permits, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::valid(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::help::merge_all<T1>(arg2, arg4);
        let v1 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg1, 0x2::coin::split<T1>(&mut v0, arg3, arg4), arg3, 0, arg4);
        0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::help::transfer<T1>(v0, 0x2::tx_context::sender(arg4));
        (v1, 0x2::coin::value<T0>(&v1))
    }

    public fun swap_ba1<T0, T1>(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Permits, arg1: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, u64) {
        let (v0, v1) = swap_ba<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, v0);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

