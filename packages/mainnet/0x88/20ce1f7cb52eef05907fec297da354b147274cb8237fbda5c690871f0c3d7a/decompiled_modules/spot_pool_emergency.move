module 0x8820ce1f7cb52eef05907fec297da354b147274cb8237fbda5c690871f0c3d7a::spot_pool_emergency {
    public entry fun emergency_withdraw_protocol_fees_to_sender<T0, T1, T2>(arg0: &mut 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::emergency_cap::EmergencyCap, arg5: &mut 0x2::tx_context::TxContext) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::emergency_cap::assert_ready(arg4, arg3);
        let (v0, v1) = 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::emergency_withdraw_protocol_fees<T0, T1, T2>(arg0, arg1, arg2, arg4, arg3, arg5);
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

    public entry fun emergency_withdraw_reserves_to_sender<T0, T1, T2>(arg0: &mut 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::emergency_cap::EmergencyCap, arg5: &mut 0x2::tx_context::TxContext) {
        0x1f086f81dc593df550adbaa1b076f771dfa64f6e34df523fcb32d3e503fc90df::emergency_cap::assert_ready(arg4, arg3);
        let (v0, v1) = 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::emergency_withdraw_reserves<T0, T1, T2>(arg0, arg1, arg2, arg4, arg3, arg5);
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

