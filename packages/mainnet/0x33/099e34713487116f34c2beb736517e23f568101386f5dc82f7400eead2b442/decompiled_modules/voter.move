module 0x33099e34713487116f34c2beb736517e23f568101386f5dc82f7400eead2b442::voter {
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

    public fun batch_vote<T0>(arg0: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::VotingEscrow<T0>, arg2: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::distribution_config::DistributionConfig, arg3: vector<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>, arg4: vector<0x2::object::ID>, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(&arg3)) {
            let v1 = 0x1::vector::pop_back<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(&mut arg3);
            0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::vote<T0>(arg0, arg1, arg2, &v1, arg4, arg5, arg6, arg7);
            v0 = v0 + 1;
            0x2::transfer::public_transfer<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(v1, 0x2::tx_context::sender(arg7));
        };
        0x1::vector::destroy_empty<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(arg3);
    }

    public fun claim_voting_bribes<T0, T1>(arg0: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::VotingEscrow<T0>, arg2: vector<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(&arg2)) {
            0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::claim_voting_bribe<T0, T1>(arg0, arg1, 0x1::vector::borrow<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(&arg2, v0), arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(&arg2) > 0) {
            0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::transfer<T0>(0x1::vector::pop_back<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_bribes_2<T0, T1, T2>(arg0: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::VotingEscrow<T0>, arg2: vector<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(&arg2)) {
            let v1 = 0x1::vector::borrow<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(&arg2, v0);
            0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::claim_voting_bribe<T0, T1>(arg0, arg1, v1, arg3, arg4);
            0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::claim_voting_bribe<T0, T2>(arg0, arg1, v1, arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(&arg2) > 0) {
            0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::transfer<T0>(0x1::vector::pop_back<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_bribes_3<T0, T1, T2, T3>(arg0: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::VotingEscrow<T0>, arg2: vector<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(&arg2)) {
            let v1 = 0x1::vector::borrow<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(&arg2, v0);
            0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::claim_voting_bribe<T0, T1>(arg0, arg1, v1, arg3, arg4);
            0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::claim_voting_bribe<T0, T2>(arg0, arg1, v1, arg3, arg4);
            0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::claim_voting_bribe<T0, T3>(arg0, arg1, v1, arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(&arg2) > 0) {
            0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::transfer<T0>(0x1::vector::pop_back<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_fee_rewards<T0, T1, T2>(arg0: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::VotingEscrow<T0>, arg2: vector<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(&arg2)) {
            let v1 = 0x1::vector::borrow<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(&arg2, v0);
            0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::claim_voting_fee_reward<T0, T1>(arg0, arg1, v1, arg3, arg4);
            0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::claim_voting_fee_reward<T0, T2>(arg0, arg1, v1, arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(&arg2) > 0) {
            0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::transfer<T0>(0x1::vector::pop_back<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_fee_rewards_single<T0, T1, T2>(arg0: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::VotingEscrow<T0>, arg2: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::claim_voting_fee_reward<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::claim_voting_fee_reward<T0, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun claimable_voting_bribes<T0, T1>(arg0: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>();
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_bribes_internal<T0, T1>(arg0, arg1, arg2));
        let v1 = ClaimableVotingBribes{data: v0};
        0x2::event::emit<ClaimableVotingBribes>(v1);
    }

    public fun claimable_voting_bribes_2<T0, T1, T2>(arg0: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>();
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_bribes_internal<T0, T1>(arg0, arg1, arg2));
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T2>(), claimable_voting_bribes_internal<T0, T2>(arg0, arg1, arg2));
        let v1 = ClaimableVotingBribes{data: v0};
        0x2::event::emit<ClaimableVotingBribes>(v1);
    }

    public fun claimable_voting_bribes_3<T0, T1, T2, T3>(arg0: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>();
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_bribes_internal<T0, T1>(arg0, arg1, arg2));
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T2>(), claimable_voting_bribes_internal<T0, T2>(arg0, arg1, arg2));
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T3>(), claimable_voting_bribes_internal<T0, T3>(arg0, arg1, arg2));
        let v1 = ClaimableVotingBribes{data: v0};
        0x2::event::emit<ClaimableVotingBribes>(v1);
    }

    fun claimable_voting_bribes_internal<T0, T1>(arg0: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : 0x2::vec_map::VecMap<0x2::object::ID, u64> {
        let v0 = 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::voted_pools<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x2::vec_map::empty<0x2::object::ID, u64>();
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v0, v1);
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut v2, v3, 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::bribe_voting_reward::earned<T1>(0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::borrow_bribe_voting_reward<T0>(arg0, 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::pool_to_gauge<T0>(arg0, v3)), arg1, arg2));
            v1 = v1 + 1;
        };
        v2
    }

    public fun claimable_voting_fees_1<T0, T1>(arg0: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_fees_internal<T0, T1>(arg0, arg1, arg2, arg3));
        let v1 = ClaimableVotingFees{data: v0};
        0x2::event::emit<ClaimableVotingFees>(v1);
    }

    public fun claimable_voting_fees_2<T0, T1, T2>(arg0: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_fees_internal<T0, T1>(arg0, arg1, arg2, arg3));
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, 0x1::type_name::get<T2>(), claimable_voting_fees_internal<T0, T2>(arg0, arg1, arg2, arg3));
        let v1 = ClaimableVotingFees{data: v0};
        0x2::event::emit<ClaimableVotingFees>(v1);
    }

    fun claimable_voting_fees_internal<T0, T1>(arg0: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::fee_voting_reward::earned<T1>(0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::borrow_fee_voting_reward<T0>(arg0, 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::pool_to_gauge<T0>(arg0, arg2)), arg1, arg3)
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::get<T0>());
        let (v1, v2) = 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::create<T0>(arg0, arg1, arg2, v0, arg3);
        0x2::transfer::public_share_object<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>>(v1);
        0x2::transfer::public_transfer<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::notify_reward_cap::NotifyRewardCap>(v2, 0x2::tx_context::sender(arg3));
    }

    public entry fun create_gauge<T0, T1, T2>(arg0: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T2>, arg1: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::distribution_config::DistributionConfig, arg2: &0xf3ad118290c2025a585369f1f87834bf642034878ff607cbcb1f3471d7489344::gauge_cap::CreateCap, arg3: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter_cap::GovernorCap, arg4: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::VotingEscrow<T2>, arg5: &mut 0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::gauge::Gauge<T0, T1, T2>>(0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::create_gauge<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public entry fun distribute<T0, T1, T2>(arg0: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::minter::Minter<T2>, arg1: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T2>, arg2: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::distribution_config::DistributionConfig, arg3: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::VotingEscrow<T2>, arg4: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::reward_distributor::RewardDistributor<T2>, arg5: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::gauge::Gauge<T0, T1, T2>, arg6: &mut 0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::minter::active_period<T2>(arg0) + 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::common::week() < 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::common::current_timestamp(arg7)) {
            0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::minter::update_period<T2>(arg0, arg1, arg3, arg4, arg7, arg8);
        };
        assert!(0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::gauge::pool_id<T0, T1, T2>(arg5) == 0x2::object::id<0x849f35cd9a8857e736d6f9e6c7d7c59deeff5fd3d22fcf38133f836561ecf68c::pool::Pool<T0, T1>>(arg6), 9223373041877123071);
        let v0 = EventDistributeReward{
            sender : 0x2::tx_context::sender(arg8),
            gauge  : 0x2::object::id<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::gauge::Gauge<T0, T1, T2>>(arg5),
            amount : 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::distribute_gauge<T0, T1, T2>(arg1, arg2, arg5, arg6, arg7, arg8),
        };
        0x2::event::emit<EventDistributeReward>(v0);
    }

    public entry fun get_voting_bribe_reward_tokens<T0>(arg0: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: 0x2::object::ID) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, vector<0x1::type_name::TypeName>>();
        let v1 = 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::voted_pools<T0>(arg0, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v1, v2);
            0x2::vec_map::insert<0x2::object::ID, vector<0x1::type_name::TypeName>>(&mut v0, v3, 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::reward::rewards_list(0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::bribe_voting_reward::borrow_reward(0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::borrow_bribe_voting_reward<T0>(arg0, 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::pool_to_gauge<T0>(arg0, v3)))));
            v2 = v2 + 1;
        };
        let v4 = EventRewardTokens{list: v0};
        0x2::event::emit<EventRewardTokens>(v4);
    }

    public entry fun get_voting_bribe_reward_tokens_by_pool<T0>(arg0: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: 0x2::object::ID) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, vector<0x1::type_name::TypeName>>();
        0x2::vec_map::insert<0x2::object::ID, vector<0x1::type_name::TypeName>>(&mut v0, arg1, 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::reward::rewards_list(0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::bribe_voting_reward::borrow_reward(0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::borrow_bribe_voting_reward<T0>(arg0, 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::pool_to_gauge<T0>(arg0, arg1)))));
        let v1 = EventRewardTokens{list: v0};
        0x2::event::emit<EventRewardTokens>(v1);
    }

    public entry fun get_voting_fee_reward_tokens<T0>(arg0: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: 0x2::object::ID) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, vector<0x1::type_name::TypeName>>();
        let v1 = 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::voted_pools<T0>(arg0, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v1, v2);
            0x2::vec_map::insert<0x2::object::ID, vector<0x1::type_name::TypeName>>(&mut v0, v3, 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::reward::rewards_list(0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::fee_voting_reward::borrow_reward(0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::borrow_fee_voting_reward<T0>(arg0, 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::pool_to_gauge<T0>(arg0, v3)))));
            v2 = v2 + 1;
        };
        let v4 = EventRewardTokens{list: v0};
        0x2::event::emit<EventRewardTokens>(v4);
    }

    public entry fun notify_bribe_reward<T0, T1>(arg0: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::bribe_voting_reward::notify_reward_amount<T1>(0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::borrow_bribe_voting_reward_mut<T0>(arg0, 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::pool_to_gauge<T0>(arg0, arg1)), 0x1::option::none<0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::whitelisted_tokens::WhitelistedToken>(), arg2, arg3, arg4);
    }

    public entry fun poke<T0>(arg0: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::VotingEscrow<T0>, arg2: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::distribution_config::DistributionConfig, arg3: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::poke<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun pools_tally<T0>(arg0: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: vector<0x2::object::ID>) {
        let v0 = 0x1::vector::empty<PoolWeight>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v2 = PoolWeight{
                id     : *0x1::vector::borrow<0x2::object::ID>(&arg1, v1),
                weight : 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::get_pool_weight<T0>(arg0, *0x1::vector::borrow<0x2::object::ID>(&arg1, v1)),
            };
            0x1::vector::push_back<PoolWeight>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = PoolsTally{list: v0};
        0x2::event::emit<PoolsTally>(v3);
    }

    public entry fun vote<T0>(arg0: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::Voter<T0>, arg1: &mut 0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::VotingEscrow<T0>, arg2: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::distribution_config::DistributionConfig, arg3: &0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voting_escrow::Lock, arg4: vector<0x2::object::ID>, arg5: vector<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9238d35aaa5974dbe7c58e32abb5129fcb277d049e278122af822e63fb9414b6::voter::vote<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

