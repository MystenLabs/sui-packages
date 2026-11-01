module 0x6bc1b4b3df8e0abd34bc3882d5bdea2fd518be40a1a3ebe6242974529978ab2d::aftermath {
    fun fraction(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000000000000) as u64)
    }

    public(friend) fun net_input(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) : u64 {
        let v0 = fraction(arg0, arg1);
        let v1 = fraction(v0, arg2);
        let v2 = if (arg6) {
            fraction(v1, arg5)
        } else {
            0
        };
        arg0 - v1 - v2 - fraction(v0, arg3) - fraction(v0, arg4)
    }

    public fun quote<T0, T1, T2>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg2: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg3: u64, arg4: &0x2::tx_context::TxContext) : (u64, u64) {
        if (arg3 == 0) {
            return (0, 0)
        };
        let v0 = net_input(arg3, 0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::total_protocol_fee(arg1), 0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::treasury_fee(arg1), 0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::insurance_fund_fee(arg1), 0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::dev_wallet_fee(arg1), 0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::referee_discount(arg1), 0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::has_referrer(arg2, 0x2::tx_context::sender(arg4)));
        let v1 = if (v0 == 0) {
            0
        } else {
            0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_swap_exact_in_direct<T0, T1, T2>(arg0, v0)
        };
        (arg3, v1)
    }

    // decompiled from Move bytecode v7
}

