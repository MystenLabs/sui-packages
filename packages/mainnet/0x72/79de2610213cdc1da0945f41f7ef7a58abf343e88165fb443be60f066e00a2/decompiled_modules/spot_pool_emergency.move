module 0x7279de2610213cdc1da0945f41f7ef7a58abf343e88165fb443be60f066e00a2::spot_pool_emergency {
    public entry fun emergency_withdraw_protocol_fees_to_sender<T0, T1, T2>(arg0: &mut 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::emergency_cap::EmergencyCap, arg5: &mut 0x2::tx_context::TxContext) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::emergency_cap::assert_ready(arg4, arg3);
        let (v0, v1) = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::emergency_withdraw_protocol_fees<T0, T1, T2>(arg0, arg1, arg2, arg4, arg3, arg5);
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

    public entry fun emergency_withdraw_reserves_to_sender<T0, T1, T2>(arg0: &mut 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::emergency_cap::EmergencyCap, arg5: &mut 0x2::tx_context::TxContext) {
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::emergency_cap::assert_ready(arg4, arg3);
        let (v0, v1) = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::emergency_withdraw_reserves<T0, T1, T2>(arg0, arg1, arg2, arg4, arg3, arg5);
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

