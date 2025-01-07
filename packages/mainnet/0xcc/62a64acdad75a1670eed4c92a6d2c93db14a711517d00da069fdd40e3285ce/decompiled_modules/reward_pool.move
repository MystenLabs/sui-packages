module 0xcc62a64acdad75a1670eed4c92a6d2c93db14a711517d00da069fdd40e3285ce::reward_pool {
    struct RewardPool<phantom T0> has store {
        exchange_rate_numerator: u64,
        exchange_rate_denominator: u64,
        reward: 0x2::balance::Balance<T0>,
        claimed_rewards: u64,
    }

    public(friend) fun add_reward<T0>(arg0: &mut RewardPool<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.reward, arg1);
    }

    public fun calculate_points_to_reward<T0>(arg0: &RewardPool<T0>, arg1: u64) : u64 {
        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(arg1, arg0.exchange_rate_numerator, arg0.exchange_rate_denominator)
    }

    public fun calculate_reward_to_points<T0>(arg0: &RewardPool<T0>, arg1: u64) : u64 {
        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(arg1, arg0.exchange_rate_denominator, arg0.exchange_rate_numerator)
    }

    public(friend) fun claim_reward<T0>(arg0: &mut RewardPool<T0>, arg1: u64) : (u64, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::math::min(calculate_points_to_reward<T0>(arg0, arg1), left_reward_amount<T0>(arg0));
        let v1 = calculate_reward_to_points<T0>(arg0, v0);
        arg0.claimed_rewards = arg0.claimed_rewards + v0;
        (v1, remove_reward<T0>(arg0, v0))
    }

    public fun claimed_rewards<T0>(arg0: &RewardPool<T0>) : u64 {
        arg0.claimed_rewards
    }

    public fun exchange_rate<T0>(arg0: &RewardPool<T0>) : (u64, u64) {
        (arg0.exchange_rate_numerator, arg0.exchange_rate_denominator)
    }

    public fun left_reward_amount<T0>(arg0: &RewardPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reward)
    }

    public(friend) fun new<T0>(arg0: u64, arg1: u64) : RewardPool<T0> {
        assert!(arg1 > 0, 0xcc62a64acdad75a1670eed4c92a6d2c93db14a711517d00da069fdd40e3285ce::app_error::reward_exchange_rate_numerator_zero());
        RewardPool<T0>{
            exchange_rate_numerator   : arg0,
            exchange_rate_denominator : arg1,
            reward                    : 0x2::balance::zero<T0>(),
            claimed_rewards           : 0,
        }
    }

    public(friend) fun remove_reward<T0>(arg0: &mut RewardPool<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.reward, arg1)
    }

    public(friend) fun update_reward_pool<T0>(arg0: &mut RewardPool<T0>, arg1: u64, arg2: u64) {
        assert!(arg2 > 0, 0xcc62a64acdad75a1670eed4c92a6d2c93db14a711517d00da069fdd40e3285ce::app_error::reward_exchange_rate_numerator_zero());
        arg0.exchange_rate_numerator = arg1;
        arg0.exchange_rate_denominator = arg2;
    }

    // decompiled from Move bytecode v6
}

