module 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::reward_pool {
    struct RewardPool<phantom T0> has store {
        exchange_rate_numerator: u64,
        exchange_rate_denominator: u64,
        reward: 0x2::balance::Balance<T0>,
        claimed_rewards: u64,
        fee_rate_numerator: u64,
        fee_rate_denominator: u64,
        fee_recipient: address,
    }

    struct VeScaIssuer has drop {
        dummy_field: bool,
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

    public(friend) fun claim_reward<T0>(arg0: &mut RewardPool<T0>, arg1: u64) : (u64, u64) {
        let v0 = calculate_points_to_reward<T0>(arg0, arg1);
        let v1 = v0;
        if (!is_ve_sca_as_rewards<T0>(arg0)) {
            v1 = 0x2::math::min(v0, left_reward_amount<T0>(arg0));
        };
        arg0.claimed_rewards = arg0.claimed_rewards + v1;
        (calculate_reward_to_points<T0>(arg0, v1), v1)
    }

    public fun claimed_rewards<T0>(arg0: &RewardPool<T0>) : u64 {
        arg0.claimed_rewards
    }

    public fun exchange_rate<T0>(arg0: &RewardPool<T0>) : (u64, u64) {
        (arg0.exchange_rate_numerator, arg0.exchange_rate_denominator)
    }

    public fun is_ve_sca_as_rewards<T0>(arg0: &RewardPool<T0>) : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VE_SCA>()
    }

    public fun left_reward_amount<T0>(arg0: &RewardPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reward)
    }

    public(friend) fun mint_ve_sca(arg0: &0xde6e897236ccc66d6eaa700340d5b75819650c94c76f2de2af4f35828bbc5f0b::linear_ve_sca::LinearVeScaConfig, arg1: &mut 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VeScaTreasury, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VeSca {
        let v0 = VeScaIssuer{dummy_field: false};
        0xde6e897236ccc66d6eaa700340d5b75819650c94c76f2de2af4f35828bbc5f0b::linear_ve_sca::mint<VeScaIssuer>(v0, arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun new<T0>(arg0: u64, arg1: u64, arg2: &0x2::tx_context::TxContext) : RewardPool<T0> {
        assert!(arg1 > 0, 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::app_error::reward_exchange_rate_numerator_zero());
        RewardPool<T0>{
            exchange_rate_numerator   : arg0,
            exchange_rate_denominator : arg1,
            reward                    : 0x2::balance::zero<T0>(),
            claimed_rewards           : 0,
            fee_rate_numerator        : 0,
            fee_rate_denominator      : 0,
            fee_recipient             : 0x2::tx_context::sender(arg2),
        }
    }

    public fun reward_fee_rates<T0>(arg0: &RewardPool<T0>) : (u64, u64) {
        (arg0.fee_rate_numerator, arg0.fee_rate_denominator)
    }

    public fun reward_fee_recipient<T0>(arg0: &RewardPool<T0>) : address {
        arg0.fee_recipient
    }

    public(friend) fun take_reward<T0>(arg0: &mut RewardPool<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.reward, arg1)
    }

    public(friend) fun update_reward_fee<T0>(arg0: &mut RewardPool<T0>, arg1: u64, arg2: u64, arg3: address) {
        arg0.fee_rate_numerator = arg1;
        arg0.fee_rate_denominator = arg2;
        arg0.fee_recipient = arg3;
    }

    public(friend) fun update_reward_pool<T0>(arg0: &mut RewardPool<T0>, arg1: u64, arg2: u64) {
        assert!(arg2 > 0, 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::app_error::reward_exchange_rate_numerator_zero());
        arg0.exchange_rate_numerator = arg1;
        arg0.exchange_rate_denominator = arg2;
    }

    // decompiled from Move bytecode v6
}

