module 0x882311e2c9eecc2338b2608bdd515dc290cf53ac87709c8a34b1332f067fec2a::rewards_pool {
    struct RewardsPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        spool_id: 0x2::object::ID,
        exchange_rate_numerator: u64,
        exchange_rate_denominator: u64,
        rewards: 0x2::balance::Balance<T0>,
        claimed_rewards: u64,
    }

    struct RewardsPoolFeeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RewardsPoolFee has store {
        fee_rate_numerator: u64,
        fee_rate_denominator: u64,
        recipient: address,
    }

    public(friend) fun new<T0>(arg0: &0x882311e2c9eecc2338b2608bdd515dc290cf53ac87709c8a34b1332f067fec2a::spool::Spool, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : RewardsPool<T0> {
        RewardsPool<T0>{
            id                        : 0x2::object::new(arg3),
            spool_id                  : 0x2::object::id<0x882311e2c9eecc2338b2608bdd515dc290cf53ac87709c8a34b1332f067fec2a::spool::Spool>(arg0),
            exchange_rate_numerator   : arg1,
            exchange_rate_denominator : arg2,
            rewards                   : 0x2::balance::zero<T0>(),
            claimed_rewards           : 0,
        }
    }

    public(friend) fun add_rewards<T0>(arg0: &mut RewardsPool<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.rewards, arg1);
    }

    public fun assert_spool_id<T0>(arg0: &RewardsPool<T0>, arg1: &0x882311e2c9eecc2338b2608bdd515dc290cf53ac87709c8a34b1332f067fec2a::spool::Spool) {
        assert!(arg0.spool_id == 0x2::object::id<0x882311e2c9eecc2338b2608bdd515dc290cf53ac87709c8a34b1332f067fec2a::spool::Spool>(arg1), 16);
    }

    public fun calculate_point_to_reward<T0>(arg0: &RewardsPool<T0>, arg1: u64) : u64 {
        0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::u64::mul_div(arg1, arg0.exchange_rate_numerator, arg0.exchange_rate_denominator)
    }

    public fun calculate_reward_to_point<T0>(arg0: &RewardsPool<T0>, arg1: u64) : u64 {
        0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::u64::mul_div(arg1, arg0.exchange_rate_denominator, arg0.exchange_rate_numerator)
    }

    public fun claimed_rewards<T0>(arg0: &RewardsPool<T0>) : u64 {
        arg0.claimed_rewards
    }

    public(friend) fun redeem_rewards<T0, T1>(arg0: &mut RewardsPool<T1>, arg1: &mut 0x882311e2c9eecc2338b2608bdd515dc290cf53ac87709c8a34b1332f067fec2a::spool_account::SpoolAccount<T0>) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::math::min(calculate_point_to_reward<T1>(arg0, 0x882311e2c9eecc2338b2608bdd515dc290cf53ac87709c8a34b1332f067fec2a::spool_account::points<T0>(arg1)), 0x2::balance::value<T1>(&arg0.rewards));
        arg0.claimed_rewards = arg0.claimed_rewards + v0;
        0x882311e2c9eecc2338b2608bdd515dc290cf53ac87709c8a34b1332f067fec2a::spool_account::redeem_point<T0>(arg1, calculate_reward_to_point<T1>(arg0, v0));
        0x2::balance::split<T1>(&mut arg0.rewards, v0)
    }

    public fun reward_fee<T0>(arg0: &RewardsPool<T0>) : (u64, u64) {
        let v0 = RewardsPoolFeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RewardsPoolFeeKey>(&arg0.id, v0)) {
            let v3 = RewardsPoolFeeKey{dummy_field: false};
            let v4 = 0x2::dynamic_field::borrow<RewardsPoolFeeKey, RewardsPoolFee>(&arg0.id, v3);
            (v4.fee_rate_numerator, v4.fee_rate_denominator)
        } else {
            (0, 0)
        }
    }

    public fun reward_fee_recipient<T0>(arg0: &RewardsPool<T0>) : address {
        let v0 = RewardsPoolFeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RewardsPoolFeeKey>(&arg0.id, v0)) {
            let v2 = RewardsPoolFeeKey{dummy_field: false};
            0x2::dynamic_field::borrow<RewardsPoolFeeKey, RewardsPoolFee>(&arg0.id, v2).recipient
        } else {
            @0x0
        }
    }

    public(friend) fun take_rewards<T0>(arg0: &mut RewardsPool<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.rewards, arg1)
    }

    public(friend) fun update_reward_fee<T0>(arg0: &mut RewardsPool<T0>, arg1: u64, arg2: u64, arg3: address) {
        let v0 = RewardsPoolFeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RewardsPoolFeeKey>(&arg0.id, v0)) {
            let v1 = RewardsPoolFeeKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow_mut<RewardsPoolFeeKey, RewardsPoolFee>(&mut arg0.id, v1);
            v2.fee_rate_numerator = arg1;
            v2.fee_rate_denominator = arg2;
            v2.recipient = arg3;
        } else {
            let v3 = RewardsPoolFee{
                fee_rate_numerator   : arg1,
                fee_rate_denominator : arg2,
                recipient            : arg3,
            };
            let v4 = RewardsPoolFeeKey{dummy_field: false};
            0x2::dynamic_field::add<RewardsPoolFeeKey, RewardsPoolFee>(&mut arg0.id, v4, v3);
        };
    }

    // decompiled from Move bytecode v6
}

