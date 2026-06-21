module 0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::renewal {
    public fun execute_renewal<T0>(arg0: &mut 0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::vault::StorageVault<T0>, arg1: &0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::waloraa::ProtocolConfig, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::vault::claim_for_renewal<T0>(arg0, arg2, arg3, arg4, arg5, arg6);
        let v1 = 0x2::coin::value<T0>(&v0);
        let v2 = 0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::waloraa::bps_denom();
        let v3 = mul_bps(v1, 0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::waloraa::protocol_fee_bps(arg1), v2);
        let v4 = mul_bps(v1, 0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::waloraa::keeper_reward_bps(arg1), v2);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, v3, arg6), 0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::waloraa::treasury(arg1));
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, v4, arg6), 0x2::tx_context::sender(arg6));
        };
        v0
    }

    fun mul_bps(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

