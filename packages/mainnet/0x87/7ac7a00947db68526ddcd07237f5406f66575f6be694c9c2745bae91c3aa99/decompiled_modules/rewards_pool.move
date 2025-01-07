module 0x877ac7a00947db68526ddcd07237f5406f66575f6be694c9c2745bae91c3aa99::rewards_pool {
    struct RewardsPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        spool_id: 0x2::object::ID,
        exchange_rate_numerator: u64,
        exchange_rate_denominator: u64,
        rewards: 0x2::balance::Balance<T0>,
        claimed_rewards: u64,
        fee_rate_numerator: u64,
        fee_rate_denominator: u64,
        fee_recipient: 0x1::option::Option<address>,
    }

    public(friend) fun new<T0>(arg0: &0x877ac7a00947db68526ddcd07237f5406f66575f6be694c9c2745bae91c3aa99::spool::Spool, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : RewardsPool<T0> {
        RewardsPool<T0>{
            id                        : 0x2::object::new(arg3),
            spool_id                  : 0x2::object::id<0x877ac7a00947db68526ddcd07237f5406f66575f6be694c9c2745bae91c3aa99::spool::Spool>(arg0),
            exchange_rate_numerator   : arg1,
            exchange_rate_denominator : arg2,
            rewards                   : 0x2::balance::zero<T0>(),
            claimed_rewards           : 0,
            fee_rate_numerator        : 0,
            fee_rate_denominator      : 1,
            fee_recipient             : 0x1::option::none<address>(),
        }
    }

    public(friend) fun add_rewards<T0>(arg0: &mut RewardsPool<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.rewards, arg1);
    }

    public fun assert_spool_id<T0>(arg0: &RewardsPool<T0>, arg1: &0x877ac7a00947db68526ddcd07237f5406f66575f6be694c9c2745bae91c3aa99::spool::Spool) {
        assert!(arg0.spool_id == 0x2::object::id<0x877ac7a00947db68526ddcd07237f5406f66575f6be694c9c2745bae91c3aa99::spool::Spool>(arg1), 16);
    }

    public fun calculate_point_to_reward<T0>(arg0: &RewardsPool<T0>, arg1: u64) : u64 {
        0x877ac7a00947db68526ddcd07237f5406f66575f6be694c9c2745bae91c3aa99::utils::mul_div(arg1, arg0.exchange_rate_numerator, arg0.exchange_rate_denominator)
    }

    public fun calculate_reward_to_point<T0>(arg0: &RewardsPool<T0>, arg1: u64) : u64 {
        0x877ac7a00947db68526ddcd07237f5406f66575f6be694c9c2745bae91c3aa99::utils::mul_div(arg1, arg0.exchange_rate_denominator, arg0.exchange_rate_numerator)
    }

    public fun claimed_rewards<T0>(arg0: &RewardsPool<T0>) : u64 {
        arg0.claimed_rewards
    }

    public(friend) fun redeem_rewards<T0, T1>(arg0: &mut RewardsPool<T1>, arg1: &mut 0x877ac7a00947db68526ddcd07237f5406f66575f6be694c9c2745bae91c3aa99::spool_account::SpoolAccount<T0>) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::math::min(calculate_point_to_reward<T1>(arg0, 0x877ac7a00947db68526ddcd07237f5406f66575f6be694c9c2745bae91c3aa99::spool_account::points(0x877ac7a00947db68526ddcd07237f5406f66575f6be694c9c2745bae91c3aa99::spool_account::spool_account_reward<T0>(arg1, v0))), rewards<T1>(arg0));
        arg0.claimed_rewards = arg0.claimed_rewards + v1;
        0x877ac7a00947db68526ddcd07237f5406f66575f6be694c9c2745bae91c3aa99::spool_account::redeem_point<T0>(arg1, v0, calculate_reward_to_point<T1>(arg0, v1));
        take_rewards<T1>(arg0, v1)
    }

    public fun reward_fee<T0>(arg0: &RewardsPool<T0>) : (u64, u64) {
        (arg0.fee_rate_numerator, arg0.fee_rate_denominator)
    }

    public fun reward_fee_recipient<T0>(arg0: &RewardsPool<T0>) : address {
        *0x1::option::borrow<address>(&arg0.fee_recipient)
    }

    public fun rewards<T0>(arg0: &RewardsPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.rewards)
    }

    public(friend) fun take_old_rewards<T0>(arg0: &mut RewardsPool<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.rewards, arg1)
    }

    public(friend) fun take_rewards<T0>(arg0: &mut RewardsPool<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.rewards, arg1)
    }

    public(friend) fun update_reward_fee<T0>(arg0: &mut RewardsPool<T0>, arg1: u64, arg2: u64, arg3: address) {
        arg0.fee_rate_numerator = arg1;
        arg0.fee_rate_denominator = arg2;
        arg0.fee_recipient = 0x1::option::some<address>(arg3);
    }

    // decompiled from Move bytecode v6
}

