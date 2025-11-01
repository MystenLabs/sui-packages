module 0xac58548c2eeefb62215d1e8fd6c3a1796e8f78a3a74703bb8991c66f40c48a04::referral_registry {
    struct ReferralRegistry has key {
        id: 0x2::object::UID,
        referrals: 0x2::table::Table<address, address>,
        referrer_stats: 0x2::table::Table<address, ReferrerStats>,
    }

    struct ReferrerStats has copy, drop, store {
        total_referrals: u64,
        total_earned_sui: u64,
    }

    struct ReferralRegistered has copy, drop {
        trader: address,
        referrer: address,
        timestamp: u64,
    }

    struct ReferralRewardPaid has copy, drop {
        referrer: address,
        trader: address,
        amount: u64,
        trade_amount: u64,
    }

    struct REFERRAL_REGISTRY has drop {
        dummy_field: bool,
    }

    public fun get_lifetime_earnings(arg0: &ReferralRegistry, arg1: address) : u64 {
        if (0x2::table::contains<address, ReferrerStats>(&arg0.referrer_stats, arg1)) {
            0x2::table::borrow<address, ReferrerStats>(&arg0.referrer_stats, arg1).total_earned_sui
        } else {
            0
        }
    }

    public fun get_referrer(arg0: &ReferralRegistry, arg1: address) : 0x1::option::Option<address> {
        if (0x2::table::contains<address, address>(&arg0.referrals, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<address, address>(&arg0.referrals, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun get_stats(arg0: &ReferralRegistry, arg1: address) : (u64, u64) {
        if (0x2::table::contains<address, ReferrerStats>(&arg0.referrer_stats, arg1)) {
            let v2 = 0x2::table::borrow<address, ReferrerStats>(&arg0.referrer_stats, arg1);
            (v2.total_referrals, v2.total_earned_sui)
        } else {
            (0, 0)
        }
    }

    public fun get_total_referrals(arg0: &ReferralRegistry, arg1: address) : u64 {
        if (0x2::table::contains<address, ReferrerStats>(&arg0.referrer_stats, arg1)) {
            0x2::table::borrow<address, ReferrerStats>(&arg0.referrer_stats, arg1).total_referrals
        } else {
            0
        }
    }

    public fun has_referrer(arg0: &ReferralRegistry, arg1: address) : bool {
        0x2::table::contains<address, address>(&arg0.referrals, arg1)
    }

    fun init(arg0: REFERRAL_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralRegistry{
            id             : 0x2::object::new(arg1),
            referrals      : 0x2::table::new<address, address>(arg1),
            referrer_stats : 0x2::table::new<address, ReferrerStats>(arg1),
        };
        0x2::transfer::share_object<ReferralRegistry>(v0);
    }

    public fun record_reward(arg0: &mut ReferralRegistry, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, ReferrerStats>(&arg0.referrer_stats, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, ReferrerStats>(&mut arg0.referrer_stats, arg1);
        v0.total_earned_sui = v0.total_earned_sui + arg2;
    }

    public fun try_register(arg0: &mut ReferralRegistry, arg1: address, arg2: address, arg3: u64) {
        if (arg1 == arg2) {
            return
        };
        if (has_referrer(arg0, arg1)) {
            return
        };
        0x2::table::add<address, address>(&mut arg0.referrals, arg1, arg2);
        if (!0x2::table::contains<address, ReferrerStats>(&arg0.referrer_stats, arg2)) {
            let v0 = ReferrerStats{
                total_referrals  : 1,
                total_earned_sui : 0,
            };
            0x2::table::add<address, ReferrerStats>(&mut arg0.referrer_stats, arg2, v0);
        } else {
            let v1 = 0x2::table::borrow_mut<address, ReferrerStats>(&mut arg0.referrer_stats, arg2);
            v1.total_referrals = v1.total_referrals + 1;
        };
        let v2 = ReferralRegistered{
            trader    : arg1,
            referrer  : arg2,
            timestamp : arg3,
        };
        0x2::event::emit<ReferralRegistered>(v2);
    }

    // decompiled from Move bytecode v6
}

