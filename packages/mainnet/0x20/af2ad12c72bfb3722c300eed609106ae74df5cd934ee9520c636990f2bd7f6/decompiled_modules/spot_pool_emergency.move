module 0x20af2ad12c72bfb3722c300eed609106ae74df5cd934ee9520c636990f2bd7f6::spot_pool_emergency {
    public entry fun emergency_withdraw_protocol_fees_to_sender<T0, T1, T2>(arg0: &mut 0x856b2a3baae5da810beaefb8d6c8a26d24a884498e4ed4d549232e83a840020::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::emergency_cap::EmergencyCap, arg5: &mut 0x2::tx_context::TxContext) {
        0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::emergency_cap::assert_ready(arg4, arg3);
        let (v0, v1) = 0x856b2a3baae5da810beaefb8d6c8a26d24a884498e4ed4d549232e83a840020::unified_spot_pool::emergency_withdraw_protocol_fees<T0, T1, T2>(arg0, arg1, arg2, arg4, arg3, arg5);
        let v2 = v1;
        let v3 = v0;
        if (0x2::coin::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        if (0x2::coin::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T1>(v2);
        };
    }

    public entry fun emergency_withdraw_reserves_to_sender<T0, T1, T2>(arg0: &mut 0x856b2a3baae5da810beaefb8d6c8a26d24a884498e4ed4d549232e83a840020::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::emergency_cap::EmergencyCap, arg5: &mut 0x2::tx_context::TxContext) {
        0x5733b07a4ec3f22fa7e0e1420d9493766307009dadbe2265324d3b79a5880758::emergency_cap::assert_ready(arg4, arg3);
        let (v0, v1) = 0x856b2a3baae5da810beaefb8d6c8a26d24a884498e4ed4d549232e83a840020::unified_spot_pool::emergency_withdraw_reserves<T0, T1, T2>(arg0, arg1, arg2, arg4, arg3, arg5);
        let v2 = v1;
        let v3 = v0;
        if (0x2::coin::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        if (0x2::coin::value<T1>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T1>(v2);
        };
    }

    // decompiled from Move bytecode v6
}

