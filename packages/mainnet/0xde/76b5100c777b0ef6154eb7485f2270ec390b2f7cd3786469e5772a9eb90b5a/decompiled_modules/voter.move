module 0xde76b5100c777b0ef6154eb7485f2270ec390b2f7cd3786469e5772a9eb90b5a::voter {
    struct EventDistributeReward has copy, drop, store {
        sender: address,
        gauge: 0x2::object::ID,
        amount: u64,
    }

    struct EventRewardTokens has copy, drop, store {
        list: 0x2::vec_map::VecMap<0x2::object::ID, vector<0x1::type_name::TypeName>>,
    }

    struct ClaimableVotingBribes has copy, drop, store {
        data: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>,
    }

    struct PoolWeight has copy, drop, store {
        id: 0x2::object::ID,
        weight: u64,
    }

    struct PoolsTally has copy, drop, store {
        list: vector<PoolWeight>,
    }

    public fun claim_voting_bribes<T0, T1>(arg0: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>, arg1: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::VotingEscrow<T0>, arg2: vector<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(&arg2)) {
            0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::claim_voting_bribe<T0, T1>(arg0, arg1, 0x1::vector::borrow<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(&arg2, v0), arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(&arg2) > 0) {
            0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::transfer<T0>(0x1::vector::pop_back<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_bribes_2<T0, T1, T2>(arg0: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>, arg1: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::VotingEscrow<T0>, arg2: vector<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(&arg2)) {
            let v1 = 0x1::vector::borrow<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(&arg2, v0);
            0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::claim_voting_bribe<T0, T1>(arg0, arg1, v1, arg3, arg4);
            0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::claim_voting_bribe<T0, T2>(arg0, arg1, v1, arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(&arg2) > 0) {
            0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::transfer<T0>(0x1::vector::pop_back<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_bribes_3<T0, T1, T2, T3>(arg0: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>, arg1: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::VotingEscrow<T0>, arg2: vector<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(&arg2)) {
            let v1 = 0x1::vector::borrow<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(&arg2, v0);
            0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::claim_voting_bribe<T0, T1>(arg0, arg1, v1, arg3, arg4);
            0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::claim_voting_bribe<T0, T2>(arg0, arg1, v1, arg3, arg4);
            0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::claim_voting_bribe<T0, T3>(arg0, arg1, v1, arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(&arg2) > 0) {
            0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::transfer<T0>(0x1::vector::pop_back<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_fee_rewards<T0, T1, T2>(arg0: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>, arg1: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::VotingEscrow<T0>, arg2: vector<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(&arg2)) {
            let v1 = 0x1::vector::borrow<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(&arg2, v0);
            0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::claim_voting_fee_reward<T0, T1>(arg0, arg1, v1, arg3, arg4);
            0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::claim_voting_fee_reward<T0, T2>(arg0, arg1, v1, arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(&arg2) > 0) {
            0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::transfer<T0>(0x1::vector::pop_back<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_fee_rewards_single<T0, T1, T2>(arg0: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>, arg1: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::VotingEscrow<T0>, arg2: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::claim_voting_fee_reward<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::claim_voting_fee_reward<T0, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun claimable_voting_bribes<T0, T1>(arg0: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>();
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_bribes_internal<T0, T1>(arg0, arg1, arg2));
        let v1 = ClaimableVotingBribes{data: v0};
        0x2::event::emit<ClaimableVotingBribes>(v1);
    }

    public fun claimable_voting_bribes_2<T0, T1, T2>(arg0: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>();
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_bribes_internal<T0, T1>(arg0, arg1, arg2));
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T2>(), claimable_voting_bribes_internal<T0, T2>(arg0, arg1, arg2));
        let v1 = ClaimableVotingBribes{data: v0};
        0x2::event::emit<ClaimableVotingBribes>(v1);
    }

    public fun claimable_voting_bribes_3<T0, T1, T2, T3>(arg0: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>();
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_bribes_internal<T0, T1>(arg0, arg1, arg2));
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T2>(), claimable_voting_bribes_internal<T0, T2>(arg0, arg1, arg2));
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T3>(), claimable_voting_bribes_internal<T0, T3>(arg0, arg1, arg2));
        let v1 = ClaimableVotingBribes{data: v0};
        0x2::event::emit<ClaimableVotingBribes>(v1);
    }

    fun claimable_voting_bribes_internal<T0, T1>(arg0: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : 0x2::vec_map::VecMap<0x2::object::ID, u64> {
        let v0 = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::voted_pools<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x2::vec_map::empty<0x2::object::ID, u64>();
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v0, v1);
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut v2, v3, 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::bribe_voting_reward::earned<T1>(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::borrow_bribe_voting_reward<T0>(arg0, 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::pool_to_gauge<T0>(arg0, v3)), arg1, arg2));
            v1 = v1 + 1;
        };
        v2
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::get<T0>());
        let (v1, v2) = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::create<T0>(arg0, v0, arg1);
        0x2::transfer::public_share_object<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>>(v1);
        0x2::transfer::public_transfer<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::notify_reward_cap::NotifyRewardCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun create_gauge<T0, T1, T2>(arg0: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T2>, arg1: &0xd5dca9246b84c016555cc96c8b2f183db9341e97103da6d787087a0e9277f62b::gauge_cap::CreateCap, arg2: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter_cap::GovernorCap, arg3: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::VotingEscrow<T2>, arg4: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::gauge::Gauge<T0, T1, T2>>(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::create_gauge<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    public entry fun distribute<T0, T1, T2>(arg0: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::minter::Minter<T2>, arg1: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T2>, arg2: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::VotingEscrow<T2>, arg3: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_distributor::RewardDistributor<T2>, arg4: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::gauge::Gauge<T0, T1, T2>, arg5: &mut 0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::minter::active_period<T2>(arg0) + 604800 < 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::current_timestamp(arg6)) {
            0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::minter::update_period<T2>(arg0, arg1, arg2, arg3, arg6, arg7);
        };
        assert!(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::gauge::pool_id<T0, T1, T2>(arg4) == 0x2::object::id<0xc26f757214f9d6598e0dbdcf505ef08357845f53677dc7a787df5021f84374f0::pool::Pool<T0, T1>>(arg5), 9223373041877123071);
        let v0 = EventDistributeReward{
            sender : 0x2::tx_context::sender(arg7),
            gauge  : 0x2::object::id<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::gauge::Gauge<T0, T1, T2>>(arg4),
            amount : 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::distribute_gauge<T0, T1, T2>(arg1, arg4, arg5, arg6, arg7),
        };
        0x2::event::emit<EventDistributeReward>(v0);
    }

    public entry fun get_voting_bribe_reward_tokens<T0>(arg0: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>, arg1: 0x2::object::ID) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, vector<0x1::type_name::TypeName>>();
        let v1 = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::voted_pools<T0>(arg0, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            0x2::vec_map::insert<0x2::object::ID, vector<0x1::type_name::TypeName>>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2), 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward::rewards_list(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::bribe_voting_reward::borrow_reward(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::borrow_bribe_voting_reward<T0>(arg0, 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::pool_to_gauge<T0>(arg0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2))))));
            v2 = v2 + 1;
        };
        let v3 = EventRewardTokens{list: v0};
        0x2::event::emit<EventRewardTokens>(v3);
    }

    public entry fun get_voting_bribe_reward_tokens_by_pool<T0>(arg0: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>, arg1: 0x2::object::ID) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, vector<0x1::type_name::TypeName>>();
        0x2::vec_map::insert<0x2::object::ID, vector<0x1::type_name::TypeName>>(&mut v0, arg1, 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward::rewards_list(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::bribe_voting_reward::borrow_reward(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::borrow_bribe_voting_reward<T0>(arg0, 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::pool_to_gauge<T0>(arg0, arg1)))));
        let v1 = EventRewardTokens{list: v0};
        0x2::event::emit<EventRewardTokens>(v1);
    }

    public entry fun get_voting_fee_reward_tokens<T0>(arg0: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>, arg1: 0x2::object::ID) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, vector<0x1::type_name::TypeName>>();
        let v1 = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::voted_pools<T0>(arg0, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            0x2::vec_map::insert<0x2::object::ID, vector<0x1::type_name::TypeName>>(&mut v0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2), 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward::rewards_list(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::fee_voting_reward::borrow_reward(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::borrow_fee_voting_reward<T0>(arg0, 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::pool_to_gauge<T0>(arg0, *0x1::vector::borrow<0x2::object::ID>(&v1, v2))))));
            v2 = v2 + 1;
        };
        let v3 = EventRewardTokens{list: v0};
        0x2::event::emit<EventRewardTokens>(v3);
    }

    public entry fun notify_bribe_reward<T0, T1>(arg0: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::bribe_voting_reward::notify_reward_amount<T1>(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::borrow_bribe_voting_reward_mut<T0>(arg0, 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::pool_to_gauge<T0>(arg0, arg1)), 0x1::option::none<0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::whitelisted_tokens::WhitelistedToken>(), arg2, arg3, arg4);
    }

    public entry fun poke<T0>(arg0: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>, arg1: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::VotingEscrow<T0>, arg2: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::poke<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun pools_tally<T0>(arg0: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>, arg1: vector<0x2::object::ID>) {
        let v0 = 0x1::vector::empty<PoolWeight>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v2 = PoolWeight{
                id     : *0x1::vector::borrow<0x2::object::ID>(&arg1, v1),
                weight : 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::get_pool_weight<T0>(arg0, *0x1::vector::borrow<0x2::object::ID>(&arg1, v1)),
            };
            0x1::vector::push_back<PoolWeight>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = PoolsTally{list: v0};
        0x2::event::emit<PoolsTally>(v3);
    }

    public entry fun vote<T0>(arg0: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::Voter<T0>, arg1: &mut 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::VotingEscrow<T0>, arg2: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voting_escrow::Lock, arg3: vector<0x2::object::ID>, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::voter::vote<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

