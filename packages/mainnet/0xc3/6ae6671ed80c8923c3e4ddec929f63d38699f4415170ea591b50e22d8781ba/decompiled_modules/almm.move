module 0x53fd629a368bf91d30079fc91a7b596ad7bbbbdf6d171e40e0605b82a92726cd::almm {
    public fun swap<T0, T1>(arg0: &mut 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::SwapContext, arg1: &0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &mut 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::SwapContext, arg1: &0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &mut 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::take_balance<T0>(arg0, arg4);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, _) = 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::swap<T0, T1>(arg3, arg1, arg2, 0x2::coin::from_balance<T0>(v0, arg6), 0x2::coin::zero<T1>(arg6), v1, 0, true, 0x2::tx_context::sender(arg6), arg5, arg6);
        if (arg4 == 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::max_amount_in()) {
            0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::transfer_remaining_balance<T0>(arg0, v2, arg6);
        } else {
            0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::merge_balance<T0>(arg0, v2);
        };
        0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::merge_balance<T1>(arg0, v3);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::SwapContext, arg1: &0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory::Factory, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &mut 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::AlmmPair<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::take_balance<T1>(arg0, arg4);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, _) = 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_pair::swap<T0, T1>(arg3, arg1, arg2, 0x2::coin::zero<T0>(arg6), 0x2::coin::from_balance<T1>(v0, arg6), v1, 0, false, 0x2::tx_context::sender(arg6), arg5, arg6);
        if (arg4 == 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::max_amount_in()) {
            0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::transfer_remaining_balance<T1>(arg0, v3, arg6);
        } else {
            0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::merge_balance<T1>(arg0, v3);
        };
        0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::router::merge_balance<T0>(arg0, v2);
    }

    // decompiled from Move bytecode v7
}

