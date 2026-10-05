module 0xbac31aa490f7c56e62d0d5d0f38866a17cd2fde15317e5469e3130b2894a5a91::w {
    public fun swap_x_for_y<T0, T1>(arg0: &0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, _) = 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::swap<T0, T1>(arg2, arg0, arg1, arg4, 0x2::coin::zero<T1>(arg5), 0x2::coin::value<T0>(&arg4), 0, true, 0x2::tx_context::sender(arg5), arg3, arg5);
        0x2::coin::destroy_zero<T0>(0x2::coin::from_balance<T0>(v0, arg5));
        0x2::coin::from_balance<T1>(v1, arg5)
    }

    public fun swap_y_for_x<T0, T1>(arg0: &0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, _) = 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::swap<T0, T1>(arg2, arg0, arg1, 0x2::coin::zero<T0>(arg5), arg4, 0x2::coin::value<T1>(&arg4), 0, false, 0x2::tx_context::sender(arg5), arg3, arg5);
        0x2::coin::destroy_zero<T1>(0x2::coin::from_balance<T1>(v1, arg5));
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    // decompiled from Move bytecode v7
}

