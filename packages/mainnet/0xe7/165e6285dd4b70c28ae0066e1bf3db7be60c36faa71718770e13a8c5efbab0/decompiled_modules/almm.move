module 0xe7165e6285dd4b70c28ae0066e1bf3db7be60c36faa71718770e13a8c5efbab0::almm {
    public fun swap<T0, T1>(arg0: &mut 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::SwapContext, arg1: &0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &mut 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::SwapContext, arg1: &0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &mut 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::take_balance<T0>(arg0, arg4);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<T0>(arg0, arg6, arg7);
            return
        };
        let (v2, v3, _) = 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::swap<T0, T1>(arg3, arg1, arg2, 0x2::coin::from_balance<T0>(v0, arg7), 0x2::coin::zero<T1>(arg7), v1, 0, true, @0x0, arg5, arg7);
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::merge_balance<T0>(arg0, v2);
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<T0>(arg0, arg6, arg7);
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::merge_balance<T1>(arg0, v3);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::SwapContext, arg1: &0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &mut 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::take_balance<T1>(arg0, arg4);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<T1>(arg0, arg6, arg7);
            return
        };
        let (v2, v3, _) = 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::swap<T0, T1>(arg3, arg1, arg2, 0x2::coin::zero<T0>(arg7), 0x2::coin::from_balance<T1>(v0, arg7), v1, 0, false, @0x0, arg5, arg7);
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::merge_balance<T1>(arg0, v3);
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::sweep_if_last<T1>(arg0, arg6, arg7);
        0x452e3f18946ae8de3f7f2e00a4bc64a043490ab2957a0c55de228678253d3d0e::router::merge_balance<T0>(arg0, v2);
    }

    // decompiled from Move bytecode v7
}

