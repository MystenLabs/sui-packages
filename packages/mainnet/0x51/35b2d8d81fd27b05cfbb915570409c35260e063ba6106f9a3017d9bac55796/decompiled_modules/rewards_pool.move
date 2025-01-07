module 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::rewards_pool {
    struct RewardsPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        spool_id: 0x2::object::ID,
        exchange_rate_numerator: u64,
        exchange_rate_denominator: u64,
        rewards: 0x2::balance::Balance<T0>,
        claimed_rewards: u64,
        fee_rate_numerator: u64,
        fee_rate_denominator: u64,
        fee_recipient: address,
    }

    struct VeScaIssuer has drop {
        dummy_field: bool,
    }

    public(friend) fun new<T0>(arg0: &0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::Spool, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : RewardsPool<T0> {
        RewardsPool<T0>{
            id                        : 0x2::object::new(arg3),
            spool_id                  : 0x2::object::id<0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::Spool>(arg0),
            exchange_rate_numerator   : arg1,
            exchange_rate_denominator : arg2,
            rewards                   : 0x2::balance::zero<T0>(),
            claimed_rewards           : 0,
            fee_rate_numerator        : 0,
            fee_rate_denominator      : 0,
            fee_recipient             : 0x2::tx_context::sender(arg3),
        }
    }

    public(friend) fun add_rewards<T0>(arg0: &mut RewardsPool<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.rewards, arg1);
    }

    public fun assert_spool_id<T0>(arg0: &RewardsPool<T0>, arg1: &0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::Spool) {
        assert!(arg0.spool_id == 0x2::object::id<0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool::Spool>(arg1), 16);
    }

    public fun calculate_point_to_reward<T0>(arg0: &RewardsPool<T0>, arg1: u64) : u64 {
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::u64::mul_div(arg1, arg0.exchange_rate_numerator, arg0.exchange_rate_denominator)
    }

    public fun calculate_reward_to_point<T0>(arg0: &RewardsPool<T0>, arg1: u64) : u64 {
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::u64::mul_div(arg1, arg0.exchange_rate_denominator, arg0.exchange_rate_numerator)
    }

    fun calculate_rewards<T0, T1>(arg0: &RewardsPool<T1>, arg1: &0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::SpoolAccount<T0>) : (u64, u64) {
        let v0 = calculate_point_to_reward<T1>(arg0, 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::points<T0>(arg1));
        let v1 = v0;
        if (!is_ve_sca_as_rewards<T1>(arg0)) {
            v1 = 0x2::math::min(v0, rewards<T1>(arg0));
        };
        (v1, calculate_reward_to_point<T1>(arg0, v1))
    }

    public fun claimed_rewards<T0>(arg0: &RewardsPool<T0>) : u64 {
        arg0.claimed_rewards
    }

    public fun is_ve_sca_as_rewards<T0>(arg0: &RewardsPool<T0>) : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VE_SCA>()
    }

    public(friend) fun mint_ve_sca(arg0: &0xde6e897236ccc66d6eaa700340d5b75819650c94c76f2de2af4f35828bbc5f0b::linear_ve_sca::LinearVeScaConfig, arg1: &mut 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VeScaTreasury, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VeSca {
        let v0 = VeScaIssuer{dummy_field: false};
        0xde6e897236ccc66d6eaa700340d5b75819650c94c76f2de2af4f35828bbc5f0b::linear_ve_sca::mint<VeScaIssuer>(v0, arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun redeem_rewards<T0, T1>(arg0: &mut RewardsPool<T1>, arg1: &mut 0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::SpoolAccount<T0>) : (u64, u64) {
        let (v0, v1) = calculate_rewards<T0, T1>(arg0, arg1);
        arg0.claimed_rewards = arg0.claimed_rewards + v0;
        0xa05122e6c5536d80d3bcf8cf541f20dbe8c35495a7fe0e4433394221de0ad3e2::spool_account::redeem_point<T0>(arg1, v1);
        (v0, v1)
    }

    public(friend) fun redeem_sca_from_ve_sca(arg0: &0xde6e897236ccc66d6eaa700340d5b75819650c94c76f2de2af4f35828bbc5f0b::linear_ve_sca::LinearVeScaConfig, arg1: &mut 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VeScaTreasury, arg2: &mut 0x3a4062f38c5288228a45654f1bb3c6578981f9d6af1b78926764d31586fee2c7::sca::ScaTreasury, arg3: 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VeSca, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x3a4062f38c5288228a45654f1bb3c6578981f9d6af1b78926764d31586fee2c7::sca::SCA> {
        let v0 = VeScaIssuer{dummy_field: false};
        0xde6e897236ccc66d6eaa700340d5b75819650c94c76f2de2af4f35828bbc5f0b::linear_ve_sca::redeem<VeScaIssuer>(v0, arg0, arg1, arg3, arg2, arg4, arg5)
    }

    public fun reward_fee<T0>(arg0: &RewardsPool<T0>) : (u64, u64) {
        (arg0.fee_rate_numerator, arg0.fee_rate_denominator)
    }

    public fun reward_fee_recipient<T0>(arg0: &RewardsPool<T0>) : address {
        arg0.fee_recipient
    }

    public fun rewards<T0>(arg0: &RewardsPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.rewards)
    }

    public(friend) fun take_rewards<T0>(arg0: &mut RewardsPool<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.rewards, arg1)
    }

    public(friend) fun update_reward_fee<T0>(arg0: &mut RewardsPool<T0>, arg1: u64, arg2: u64, arg3: address) {
        arg0.fee_rate_numerator = arg1;
        arg0.fee_rate_denominator = arg2;
        arg0.fee_recipient = arg3;
    }

    // decompiled from Move bytecode v6
}

