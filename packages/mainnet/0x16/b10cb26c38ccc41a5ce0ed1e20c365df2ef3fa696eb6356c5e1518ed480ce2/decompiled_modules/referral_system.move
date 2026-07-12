module 0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::referral_system {
    struct Referral has key {
        id: 0x2::object::UID,
        referrer: address,
        referee: address,
        bonus_points: u64,
        referral_purchases_required: u64,
        claimed: bool,
        created_at: u64,
    }

    struct ReferralStats has key {
        id: 0x2::object::UID,
        owner: address,
        total_referrals: u64,
        successful_referrals: u64,
        total_bonus_earned: u64,
    }

    struct ReferralCreated has copy, drop {
        referrer: address,
        referee: address,
        bonus_points: u64,
        timestamp: u64,
    }

    struct ReferralBonusClaimed has copy, drop {
        referrer: address,
        referee: address,
        bonus_points: u64,
        timestamp: u64,
    }

    public entry fun claim_bonus(arg0: &mut Referral, arg1: &0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::loyalty_program::CustomerProfile, arg2: &mut ReferralStats, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.claimed, 0);
        assert!(0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::loyalty_program::get_customer_address(arg1) == arg0.referee, 4);
        assert!(0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::loyalty_program::get_total_purchases(arg1) >= arg0.referral_purchases_required, 3);
        arg0.claimed = true;
        arg2.successful_referrals = arg2.successful_referrals + 1;
        arg2.total_bonus_earned = arg2.total_bonus_earned + arg0.bonus_points;
        let v0 = ReferralBonusClaimed{
            referrer     : arg0.referrer,
            referee      : arg0.referee,
            bonus_points : arg0.bonus_points,
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ReferralBonusClaimed>(v0);
    }

    public entry fun create_referral(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg5);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg0 != arg1, 2);
        assert!(arg0 != @0x0 && arg1 != @0x0, 1);
        let v1 = Referral{
            id                          : 0x2::object::new(arg5),
            referrer                    : arg0,
            referee                     : arg1,
            bonus_points                : arg2,
            referral_purchases_required : arg3,
            claimed                     : false,
            created_at                  : v0,
        };
        let v2 = ReferralCreated{
            referrer     : arg0,
            referee      : arg1,
            bonus_points : arg2,
            timestamp    : v0,
        };
        0x2::event::emit<ReferralCreated>(v2);
        0x2::transfer::share_object<Referral>(v1);
    }

    public fun get_purchases_required(arg0: &Referral) : u64 {
        arg0.referral_purchases_required
    }

    public fun get_referral_info(arg0: &Referral) : (address, address, u64, bool) {
        (arg0.referrer, arg0.referee, arg0.bonus_points, arg0.claimed)
    }

    public fun get_referral_stats(arg0: &ReferralStats) : (u64, u64, u64) {
        (arg0.total_referrals, arg0.successful_referrals, arg0.total_bonus_earned)
    }

    public entry fun increment_referral_count(arg0: &mut ReferralStats, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.total_referrals = arg0.total_referrals + 1;
    }

    public entry fun init_referral_stats(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralStats{
            id                   : 0x2::object::new(arg1),
            owner                : arg0,
            total_referrals      : 0,
            successful_referrals : 0,
            total_bonus_earned   : 0,
        };
        0x2::transfer::share_object<ReferralStats>(v0);
    }

    public fun is_claimed(arg0: &Referral) : bool {
        arg0.claimed
    }

    // decompiled from Move bytecode v6
}

