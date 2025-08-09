module 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::exercise_fee_distributor {
    struct ExerciseFeeDistributor<phantom T0> has store, key {
        id: 0x2::object::UID,
        reward_distributor: 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::RewardDistributor<T0>,
        bag: 0x2::bag::Bag,
    }

    public fun balance<T0>(arg0: &ExerciseFeeDistributor<T0>) : u64 {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::balance<T0>(&arg0.reward_distributor)
    }

    public fun checkpoint_token<T0>(arg0: &mut ExerciseFeeDistributor<T0>, arg1: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor_cap::RewardDistributorCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::checkpoint_token<T0>(&mut arg0.reward_distributor, arg1, arg2, arg3);
    }

    public fun claim<T0, T1>(arg0: &mut ExerciseFeeDistributor<T1>, arg1: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::VotingEscrow<T0>, arg2: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::Lock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::claim<T0, T1>(&mut arg0.reward_distributor, arg1, arg2, arg3)
    }

    public fun claimable<T0, T1>(arg0: &ExerciseFeeDistributor<T1>, arg1: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) : u64 {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::claimable<T0, T1>(&arg0.reward_distributor, arg1, arg2)
    }

    public(friend) fun create<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : (ExerciseFeeDistributor<T0>, 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor_cap::RewardDistributorCap) {
        let v0 = 0x2::object::new(arg1);
        let (v1, v2) = 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::create<T0>(0x2::object::uid_to_inner(&v0), arg0, arg1);
        let v3 = ExerciseFeeDistributor<T0>{
            id                 : v0,
            reward_distributor : v1,
            bag                : 0x2::bag::new(arg1),
        };
        (v3, v2)
    }

    public fun last_token_time<T0>(arg0: &ExerciseFeeDistributor<T0>) : u64 {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::last_token_time<T0>(&arg0.reward_distributor)
    }

    public fun start<T0>(arg0: &mut ExerciseFeeDistributor<T0>, arg1: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor_cap::RewardDistributorCap, arg2: &0x2::clock::Clock) {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::start<T0>(&mut arg0.reward_distributor, arg1, arg2);
    }

    public fun tokens_per_period<T0>(arg0: &ExerciseFeeDistributor<T0>, arg1: u64) : u64 {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::tokens_per_period<T0>(&arg0.reward_distributor, arg1)
    }

    // decompiled from Move bytecode v6
}

