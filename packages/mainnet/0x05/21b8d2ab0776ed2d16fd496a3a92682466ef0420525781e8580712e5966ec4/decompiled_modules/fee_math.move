module 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::fee_math {
    struct Rates has copy, drop {
        trade_fee_bps: u64,
        creator_bps: u64,
        liquidity_bps: u64,
        season_bps: u64,
        referral_bps: u64,
    }

    struct FeeShares has copy, drop {
        tax: u64,
        creator: u64,
        liquidity: u64,
        referral: u64,
        season: u64,
        platform: u64,
        penalty_season: u64,
        penalty_platform: u64,
    }

    public fun mode_preset(arg0: u8) : (u64, u64, u64) {
        if (arg0 == 0) {
            (10000, 0, 0)
        } else if (arg0 == 1) {
            (0, 10000, 0)
        } else if (arg0 == 2) {
            (0, 0, 10000)
        } else {
            assert!(arg0 == 3, 201);
            (5000, 2500, 2500)
        }
    }

    public fun mode_split(arg0: u64, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let v0 = 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::bps_of(arg0, arg1);
        let v1 = 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::bps_of(arg0, arg2);
        (arg0 - v0 - v1, v0, v1)
    }

    public fun rates(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : Rates {
        Rates{
            trade_fee_bps : arg0,
            creator_bps   : arg1,
            liquidity_bps : arg2,
            season_bps    : arg3,
            referral_bps  : arg4,
        }
    }

    public fun split(arg0: &Rates, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : FeeShares {
        let v0 = 0x1::u64::min(0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::bps_of(arg2, arg0.trade_fee_bps), arg1);
        let v1 = arg1 - v0;
        let v2 = 0x1::u64::min(0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::bps_of(arg2, arg3), v1);
        let v3 = v1 - v2;
        let v4 = 0x1::u64::min(0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::bps_of(arg2, arg0.creator_bps), v0);
        let v5 = v0 - v4;
        let v6 = 0x1::u64::min(0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::bps_of(arg2, arg0.liquidity_bps), v5);
        let v7 = v5 - v6;
        let v8 = v7;
        let v9 = 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::bps_of(arg2, arg0.season_bps);
        let v10 = v9;
        let v11 = 0;
        if (arg4) {
            let v12 = 0x1::u64::min(0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::bps_of(arg2, arg0.referral_bps), v7);
            v11 = v12;
            v10 = v9 - 0x1::u64::min(0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math::bps_of(arg2, arg0.referral_bps / 2), v9);
            v8 = v7 - v12;
        };
        let v13 = 0x1::u64::min(v10, v8);
        let v14 = v3 / 2;
        FeeShares{
            tax              : v2,
            creator          : v4,
            liquidity        : v6,
            referral         : v11,
            season           : v13,
            platform         : v8 - v13,
            penalty_season   : v14,
            penalty_platform : v3 - v14,
        }
    }

    public fun unpack(arg0: &FeeShares) : (u64, u64, u64, u64, u64, u64, u64, u64) {
        (arg0.tax, arg0.creator, arg0.liquidity, arg0.referral, arg0.season, arg0.platform, arg0.penalty_season, arg0.penalty_platform)
    }

    // decompiled from Move bytecode v7
}

