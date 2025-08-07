module 0x9bd89740b35ed41c16b65840784ba336bbc800330a647309d4d8fc22bf29392b::voter {
    struct EventDistributeReward has copy, drop, store {
        sender: address,
        gauge: 0x2::object::ID,
        amount: u64,
    }

    struct EventRewardTokens has copy, drop, store {
        list: 0x2::vec_map::VecMap<0x2::object::ID, vector<0x1::type_name::TypeName>>,
    }

    struct ClaimableVotingFees has copy, drop, store {
        data: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct PoolWeight has copy, drop, store {
        id: 0x2::object::ID,
        weight: u64,
    }

    struct PoolsTally has copy, drop, store {
        list: vector<PoolWeight>,
    }

    public entry fun create_gauge<T0, T1, T2>(arg0: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::Minter<T2>, arg1: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::Voter, arg2: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::distribution_config::DistributionConfig, arg3: &0xcc201c522d0e0d28d2206749210bc6979aef8475b0fa896d592b438487b66971::gauge_cap::CreateCap, arg4: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::AdminCap, arg5: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::VotingEscrow<T2>, arg6: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::Pool<T0, T1>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::Gauge<T0, T1>>(0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::create_gauge<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public entry fun create(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::create(arg0, arg1, arg2, arg3);
        0x2::transfer::public_share_object<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::Voter>(v0);
        0x2::transfer::public_transfer<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::distribute_cap::DistributeCap>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun poke<T0>(arg0: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::Voter, arg1: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::VotingEscrow<T0>, arg2: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::distribution_config::DistributionConfig, arg3: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::poke<T0>(arg0, arg1, arg2, 0x2::object::id<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::Lock>(arg3), arg4, arg5);
    }

    public entry fun vote<T0>(arg0: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::Voter, arg1: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::VotingEscrow<T0>, arg2: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::distribution_config::DistributionConfig, arg3: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::Lock, arg4: vector<0x2::object::ID>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::vote<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun batch_vote<T0>(arg0: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::Voter, arg1: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::VotingEscrow<T0>, arg2: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::distribution_config::DistributionConfig, arg3: vector<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::Lock>, arg4: vector<0x2::object::ID>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::Lock>(&arg3)) {
            let v1 = 0x1::vector::pop_back<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::Lock>(&mut arg3);
            0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::vote<T0>(arg0, arg1, arg2, &v1, arg4, arg5, arg6, arg7, arg8);
            0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::transfer<T0>(v1, arg1, 0x2::tx_context::sender(arg8), arg7, arg8);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::Lock>(arg3);
    }

    public fun claim_voting_fee_rewards<T0, T1, T2>(arg0: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::Voter, arg1: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::VotingEscrow<T0>, arg2: vector<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::Lock>, arg3: &0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::Pool<T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::Lock>(&arg2)) {
            0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::claim_voting_fee_by_pool<T1, T2, T0>(arg0, arg1, 0x1::vector::borrow<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::Lock>(&arg2, v0), arg3, arg4, arg5);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::Lock>(&arg2) > 0) {
            0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::transfer<T0>(0x1::vector::pop_back<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg5), arg4, arg5);
        };
        0x1::vector::destroy_empty<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_fee_rewards_single<T0, T1, T2>(arg0: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::Voter, arg1: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::VotingEscrow<T0>, arg2: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::Lock, arg3: &0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::Pool<T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::claim_voting_fee_by_pool<T1, T2, T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun claimable_voting_fees_1<T0>(arg0: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::Voter, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, 0x1::type_name::get<T0>(), claimable_voting_fees_internal<T0>(arg0, arg1, arg2, arg3));
        let v1 = ClaimableVotingFees{data: v0};
        0x2::event::emit<ClaimableVotingFees>(v1);
    }

    public fun claimable_voting_fees_2<T0, T1>(arg0: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::Voter, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, 0x1::type_name::get<T0>(), claimable_voting_fees_internal<T0>(arg0, arg1, arg2, arg3));
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_fees_internal<T1>(arg0, arg1, arg2, arg3));
        let v1 = ClaimableVotingFees{data: v0};
        0x2::event::emit<ClaimableVotingFees>(v1);
    }

    fun claimable_voting_fees_internal<T0>(arg0: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::Voter, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::fee_voting_reward::earned<T0>(0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::borrow_fee_voting_reward(arg0, 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::pool_to_gauge(arg0, arg2)), arg1, arg3)
    }

    public entry fun distribute<T0, T1, T2, T3>(arg0: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::Minter<T2>, arg1: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::Voter, arg2: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::DistributeGovernorCap, arg3: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::distribution_config::DistributionConfig, arg4: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::Gauge<T0, T1>, arg5: &mut 0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::Pool<T0, T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        if (0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::active_period<T2>(arg0) + 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::common::epoch() < 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::common::current_timestamp(arg13)) {
            abort 93972037923406333
        };
        assert!(0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::pool_id<T0, T1>(arg4) == 0x2::object::id<0xa46f7dc3f1f0f4978d81c9c52757554f6f4dc62f65f2ce586be34409aa3b8168::pool::Pool<T0, T1>>(arg5), 9223373041877123071);
        let v0 = EventDistributeReward{
            sender : 0x2::tx_context::sender(arg14),
            gauge  : 0x2::object::id<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::gauge::Gauge<T0, T1>>(arg4),
            amount : 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::minter::distribute_gauge<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
        };
        0x2::event::emit<EventDistributeReward>(v0);
    }

    public entry fun get_voting_fee_reward_tokens(arg0: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::Voter, arg1: 0x2::object::ID) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, vector<0x1::type_name::TypeName>>();
        let v1 = 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::voted_pools(arg0, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v1, v2);
            0x2::vec_map::insert<0x2::object::ID, vector<0x1::type_name::TypeName>>(&mut v0, v3, 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward::rewards_list(0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::fee_voting_reward::borrow_reward(0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::borrow_fee_voting_reward(arg0, 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::pool_to_gauge(arg0, v3)))));
            v2 = v2 + 1;
        };
        let v4 = EventRewardTokens{list: v0};
        0x2::event::emit<EventRewardTokens>(v4);
    }

    public entry fun pools_tally(arg0: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::Voter, arg1: vector<0x2::object::ID>) {
        let v0 = 0x1::vector::empty<PoolWeight>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v2 = PoolWeight{
                id     : *0x1::vector::borrow<0x2::object::ID>(&arg1, v1),
                weight : 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voter::get_pool_weight(arg0, *0x1::vector::borrow<0x2::object::ID>(&arg1, v1)),
            };
            0x1::vector::push_back<PoolWeight>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = PoolsTally{list: v0};
        0x2::event::emit<PoolsTally>(v3);
    }

    // decompiled from Move bytecode v6
}

