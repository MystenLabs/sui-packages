module 0x37214aae266dba907ddbbd342d0841a3bbad098f7ab67428be598e58118de8fd::magma_almm {
    public fun swap<T0, T1>(arg0: &mut 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext, arg1: &mut 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>, arg2: &0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8);
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext, arg1: &mut 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>, arg2: &0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::take_balance<T0>(arg0, arg5);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0x28d548c72cf8271667c6282b6988f0af6f66fca4bb33778cf1d9d43fed7a52d7::magma_almm::swap_a2b<T0, T1>(arg2, arg3, arg1, arg4, 0x2::coin::from_balance<T0>(v0, arg7), arg6, arg7);
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::emit_swap_event<T0, T1>(arg0, b"MAGMAALMM", 0x2::object::id<0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>>(arg1), v1, 0x2::coin::value<T1>(&v2), 0);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext, arg1: &mut 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>, arg2: &0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::take_balance<T1>(arg0, arg5);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0x28d548c72cf8271667c6282b6988f0af6f66fca4bb33778cf1d9d43fed7a52d7::magma_almm::swap_b2a<T0, T1>(arg2, arg3, arg1, arg4, 0x2::coin::from_balance<T1>(v0, arg7), arg6, arg7);
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::emit_swap_event<T1, T0>(arg0, b"MAGMAALMM", 0x2::object::id<0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>>(arg1), v1, 0x2::coin::value<T0>(&v2), 0);
    }

    // decompiled from Move bytecode v6
}

