module 0x54b879c96efd6f4750204b920158d6b865d521cd33bfa56b1dd9ad35d4b51ae4::rewards_pool {
    struct RewardsPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        spool_id: 0x2::object::ID,
        exchange_rate_numerator: u64,
        exchange_rate_denominator: u64,
        rewards: 0x2::balance::Balance<T0>,
    }

    public(friend) fun new<T0>(arg0: &0x54b879c96efd6f4750204b920158d6b865d521cd33bfa56b1dd9ad35d4b51ae4::spool::Spool, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : RewardsPool<T0> {
        RewardsPool<T0>{
            id                        : 0x2::object::new(arg3),
            spool_id                  : 0x2::object::id<0x54b879c96efd6f4750204b920158d6b865d521cd33bfa56b1dd9ad35d4b51ae4::spool::Spool>(arg0),
            exchange_rate_numerator   : arg1,
            exchange_rate_denominator : arg2,
            rewards                   : 0x2::balance::zero<T0>(),
        }
    }

    public(friend) fun add_rewards<T0>(arg0: &mut RewardsPool<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.rewards, arg1);
    }

    public fun assert_spool_id<T0>(arg0: &RewardsPool<T0>, arg1: &0x54b879c96efd6f4750204b920158d6b865d521cd33bfa56b1dd9ad35d4b51ae4::spool::Spool) {
        assert!(arg0.spool_id == 0x2::object::id<0x54b879c96efd6f4750204b920158d6b865d521cd33bfa56b1dd9ad35d4b51ae4::spool::Spool>(arg1), 16);
    }

    public fun calculate_point_to_reward<T0>(arg0: &RewardsPool<T0>, arg1: u64) : u64 {
        0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::u64::mul_div(arg1, arg0.exchange_rate_numerator, arg0.exchange_rate_denominator)
    }

    public fun calculate_reward_to_point<T0>(arg0: &RewardsPool<T0>, arg1: u64) : u64 {
        0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::u64::mul_div(arg1, arg0.exchange_rate_denominator, arg0.exchange_rate_numerator)
    }

    public(friend) fun redeem_rewards<T0, T1>(arg0: &mut RewardsPool<T1>, arg1: &mut 0x54b879c96efd6f4750204b920158d6b865d521cd33bfa56b1dd9ad35d4b51ae4::spool_account::SpoolAccount<T0>) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::math::min(calculate_point_to_reward<T1>(arg0, 0x54b879c96efd6f4750204b920158d6b865d521cd33bfa56b1dd9ad35d4b51ae4::spool_account::points<T0>(arg1)), 0x2::balance::value<T1>(&arg0.rewards));
        0x54b879c96efd6f4750204b920158d6b865d521cd33bfa56b1dd9ad35d4b51ae4::spool_account::redeem_point<T0>(arg1, calculate_reward_to_point<T1>(arg0, v0));
        0x2::balance::split<T1>(&mut arg0.rewards, v0)
    }

    public(friend) fun take_rewards<T0>(arg0: &mut RewardsPool<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.rewards, arg1)
    }

    // decompiled from Move bytecode v6
}

