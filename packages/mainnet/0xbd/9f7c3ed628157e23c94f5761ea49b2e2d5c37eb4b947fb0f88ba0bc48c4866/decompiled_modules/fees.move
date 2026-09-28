module 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees {
    struct Split has copy, drop, store {
        trade_fee_bps: u64,
        creator_bps: u64,
        platform_bps: u64,
        season_bps: u64,
        basket_bps: u64,
        referral_bps: u64,
    }

    struct Parts has copy, drop {
        total: u64,
        creator: u64,
        platform: u64,
        season: u64,
        basket: u64,
        referral: u64,
    }

    public fun buy_fee_bps_at(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg4 <= arg2) {
            return arg1
        };
        let v0 = arg4 - arg2;
        if (v0 >= arg3) {
            return arg0
        };
        arg1 - 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::math::mul_div(arg1 - arg0, v0, arg3)
    }

    public fun check(arg0: &Split) {
        assert!(arg0.creator_bps + arg0.platform_bps + arg0.season_bps + arg0.basket_bps == arg0.trade_fee_bps, 300);
        assert!(arg0.trade_fee_bps <= 500, 300);
        let v0 = if (arg0.referral_bps % 2 == 0) {
            if (arg0.referral_bps / 2 <= arg0.platform_bps) {
                arg0.referral_bps / 2 <= arg0.season_bps
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 300);
    }

    public fun default_split() : Split {
        Split{
            trade_fee_bps : 100,
            creator_bps   : 50,
            platform_bps  : 30,
            season_bps    : 10,
            basket_bps    : 10,
            referral_bps  : 10,
        }
    }

    public fun fee_on(arg0: u64, arg1: u64) : u64 {
        0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::math::mul_div_up(arg0, arg1, 10000)
    }

    public fun new_split(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : Split {
        let v0 = Split{
            trade_fee_bps : arg0,
            creator_bps   : arg1,
            platform_bps  : arg2,
            season_bps    : arg3,
            basket_bps    : arg4,
            referral_bps  : arg5,
        };
        check(&v0);
        v0
    }

    fun part(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::math::mul_div(arg0, arg1, arg2)
    }

    public fun parts(arg0: &Parts) : (u64, u64, u64, u64, u64, u64) {
        (arg0.total, arg0.creator, arg0.platform, arg0.season, arg0.basket, arg0.referral)
    }

    public fun split(arg0: &Split, arg1: u64, arg2: u64, arg3: bool) : Parts {
        if (arg1 == 0 || arg2 == 0) {
            return Parts{
                total    : arg1,
                creator  : 0,
                platform : arg1,
                season   : 0,
                basket   : 0,
                referral : 0,
            }
        };
        let v0 = part(arg1, arg0.creator_bps, arg0.trade_fee_bps);
        let v1 = part(arg1, arg0.season_bps, arg0.trade_fee_bps);
        let v2 = part(arg1, arg0.basket_bps, arg0.trade_fee_bps);
        let v3 = if (arg3) {
            part(arg1, arg0.referral_bps, arg0.trade_fee_bps)
        } else {
            0
        };
        let v4 = v3 / 2;
        let v5 = if (v1 > v4) {
            v1 - v4
        } else {
            0
        };
        Parts{
            total    : arg1,
            creator  : v0,
            platform : arg1 - v0 - v5 - v2 - v3,
            season   : v5,
            basket   : v2,
            referral : v3,
        }
    }

    public fun trade_fee_bps(arg0: &Split) : u64 {
        arg0.trade_fee_bps
    }

    // decompiled from Move bytecode v7
}

