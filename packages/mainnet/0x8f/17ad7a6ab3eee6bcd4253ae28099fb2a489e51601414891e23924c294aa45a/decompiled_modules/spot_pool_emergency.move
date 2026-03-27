module 0x8f17ad7a6ab3eee6bcd4253ae28099fb2a489e51601414891e23924c294aa45a::spot_pool_emergency {
    public entry fun emergency_withdraw_protocol_fees_to_sender<T0, T1, T2>(arg0: &mut 0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x664a0e25093ade2eb071799f7b24a821a5eeb6f355986f6bc15c582b60d0c6a0::emergency_cap::EmergencyCap, arg5: &mut 0x2::tx_context::TxContext) {
        0x664a0e25093ade2eb071799f7b24a821a5eeb6f355986f6bc15c582b60d0c6a0::emergency_cap::assert_ready(arg4, arg3);
        let (v0, v1) = 0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::unified_spot_pool::emergency_withdraw_protocol_fees<T0, T1, T2>(arg0, arg1, arg2, arg4, arg3, arg5);
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

    public entry fun emergency_withdraw_reserves_to_sender<T0, T1, T2>(arg0: &mut 0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x664a0e25093ade2eb071799f7b24a821a5eeb6f355986f6bc15c582b60d0c6a0::emergency_cap::EmergencyCap, arg5: &mut 0x2::tx_context::TxContext) {
        0x664a0e25093ade2eb071799f7b24a821a5eeb6f355986f6bc15c582b60d0c6a0::emergency_cap::assert_ready(arg4, arg3);
        let (v0, v1) = 0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::unified_spot_pool::emergency_withdraw_reserves<T0, T1, T2>(arg0, arg1, arg2, arg4, arg3, arg5);
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

