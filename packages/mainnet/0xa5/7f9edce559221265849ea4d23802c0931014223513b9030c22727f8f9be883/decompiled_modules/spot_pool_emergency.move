module 0xa57f9edce559221265849ea4d23802c0931014223513b9030c22727f8f9be883::spot_pool_emergency {
    public entry fun emergency_withdraw_protocol_fees_to_sender<T0, T1, T2>(arg0: &mut 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::emergency_cap::EmergencyCap, arg5: &mut 0x2::tx_context::TxContext) {
        0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::emergency_cap::assert_ready(arg4, arg3);
        let (v0, v1) = 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::emergency_withdraw_protocol_fees<T0, T1, T2>(arg0, arg1, arg2, arg4, arg3, arg5);
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

    public entry fun emergency_withdraw_reserves_to_sender<T0, T1, T2>(arg0: &mut 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::emergency_cap::EmergencyCap, arg5: &mut 0x2::tx_context::TxContext) {
        0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::emergency_cap::assert_ready(arg4, arg3);
        let (v0, v1) = 0x39eeb775b5abe9f68786c20935c594946149eed6dfc28bcce1d83c0705a767b8::unified_spot_pool::emergency_withdraw_reserves<T0, T1, T2>(arg0, arg1, arg2, arg4, arg3, arg5);
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

