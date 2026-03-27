module 0xe4d5d33ea6f4bbd823bb454416dc6bbdbcad0a915d181a9e7eef14ed76698a0c::spot_pool_emergency {
    public entry fun emergency_withdraw_protocol_fees_to_sender<T0, T1, T2>(arg0: &mut 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::emergency_cap::EmergencyCap, arg5: &mut 0x2::tx_context::TxContext) {
        0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::emergency_cap::assert_ready(arg4, arg3);
        let (v0, v1) = 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::emergency_withdraw_protocol_fees<T0, T1, T2>(arg0, arg1, arg2, arg4, arg3, arg5);
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

    public entry fun emergency_withdraw_reserves_to_sender<T0, T1, T2>(arg0: &mut 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::emergency_cap::EmergencyCap, arg5: &mut 0x2::tx_context::TxContext) {
        0x114056e12dc74d45933f12b3e4ecbe797dad06610b42c9b1af46fd885c3e6f3::emergency_cap::assert_ready(arg4, arg3);
        let (v0, v1) = 0x97b3643b2225f09904b8658aa580c01c922b226f861a87cc0e93a752182b852e::unified_spot_pool::emergency_withdraw_reserves<T0, T1, T2>(arg0, arg1, arg2, arg4, arg3, arg5);
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

