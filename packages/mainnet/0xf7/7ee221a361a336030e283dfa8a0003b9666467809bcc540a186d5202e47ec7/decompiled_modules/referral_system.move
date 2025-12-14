module 0xf77ee221a361a336030e283dfa8a0003b9666467809bcc540a186d5202e47ec7::referral_system {
    struct ReferralSystem has key {
        id: 0x2::object::UID,
        referral_counts: 0x2::vec_map::VecMap<address, u64>,
        referrals: 0x2::vec_map::VecMap<address, address>,
        total_rewards_distributed: u64,
        referral_percentage: u64,
    }

    struct ReferralRegistered has copy, drop {
        referrer: address,
        referee: address,
    }

    struct ReferralRewardPaid has copy, drop {
        referrer: address,
        referee: address,
        amount: u64,
    }

    public fun calculate_referral_reward(arg0: &ReferralSystem, arg1: address, arg2: u64) : (0x1::option::Option<address>, u64) {
        if (0x2::vec_map::contains<address, address>(&arg0.referrals, &arg1)) {
            (0x1::option::some<address>(*0x2::vec_map::get<address, address>(&arg0.referrals, &arg1)), arg2 * arg0.referral_percentage / 100)
        } else {
            (0x1::option::none<address>(), 0)
        }
    }

    public fun get_leaderboard_data(arg0: &ReferralSystem) : (vector<address>, vector<u64>) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x2::vec_map::length<address, u64>(&arg0.referral_counts)) {
            let (v3, v4) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg0.referral_counts, v2);
            0x1::vector::push_back<address>(&mut v0, *v3);
            0x1::vector::push_back<u64>(&mut v1, *v4);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun get_referral_count(arg0: &ReferralSystem, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, u64>(&arg0.referral_counts, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.referral_counts, &arg1)
        } else {
            0
        }
    }

    public fun get_referrer(arg0: &ReferralSystem, arg1: address) : 0x1::option::Option<address> {
        if (0x2::vec_map::contains<address, address>(&arg0.referrals, &arg1)) {
            0x1::option::some<address>(*0x2::vec_map::get<address, address>(&arg0.referrals, &arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun get_total_rewards(arg0: &ReferralSystem) : u64 {
        arg0.total_rewards_distributed
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralSystem{
            id                        : 0x2::object::new(arg0),
            referral_counts           : 0x2::vec_map::empty<address, u64>(),
            referrals                 : 0x2::vec_map::empty<address, address>(),
            total_rewards_distributed : 0,
            referral_percentage       : 10,
        };
        0x2::transfer::share_object<ReferralSystem>(v0);
    }

    public fun record_reward_distribution(arg0: &mut ReferralSystem, arg1: u64) {
        arg0.total_rewards_distributed = arg0.total_rewards_distributed + arg1;
    }

    public fun register_referral(arg0: &mut ReferralSystem, arg1: address, arg2: address) {
        assert!(arg1 != arg2, 0);
        assert!(!0x2::vec_map::contains<address, address>(&arg0.referrals, &arg2), 1);
        0x2::vec_map::insert<address, address>(&mut arg0.referrals, arg2, arg1);
        if (0x2::vec_map::contains<address, u64>(&arg0.referral_counts, &arg1)) {
            let (_, v1) = 0x2::vec_map::remove<address, u64>(&mut arg0.referral_counts, &arg1);
            0x2::vec_map::insert<address, u64>(&mut arg0.referral_counts, arg1, v1 + 1);
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.referral_counts, arg1, 1);
        };
        let v2 = ReferralRegistered{
            referrer : arg1,
            referee  : arg2,
        };
        0x2::event::emit<ReferralRegistered>(v2);
    }

    // decompiled from Move bytecode v6
}

