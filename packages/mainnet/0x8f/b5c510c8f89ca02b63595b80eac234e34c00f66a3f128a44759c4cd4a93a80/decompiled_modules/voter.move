module 0x8fb5c510c8f89ca02b63595b80eac234e34c00f66a3f128a44759c4cd4a93a80::voter {
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

    public fun batch_vote<T0>(arg0: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::VotingEscrow<T0>, arg2: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg3: vector<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>, arg4: vector<0x2::object::ID>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(&arg3)) {
            let v1 = 0x1::vector::pop_back<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(&mut arg3);
            0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::vote<T0>(arg0, arg1, arg2, &v1, arg4, arg5, arg6, arg7, arg8);
            v0 = v0 + 1;
            0x2::transfer::public_transfer<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(v1, 0x2::tx_context::sender(arg8));
        };
        0x1::vector::destroy_empty<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(arg3);
    }

    public fun claim_voting_bribes<T0, T1>(arg0: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::VotingEscrow<T0>, arg2: vector<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(&arg2)) {
            0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::claim_voting_bribe<T0, T1>(arg0, arg1, 0x1::vector::borrow<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(&arg2, v0), arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(&arg2) > 0) {
            0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::transfer<T0>(0x1::vector::pop_back<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_bribes_2<T0, T1, T2>(arg0: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::VotingEscrow<T0>, arg2: vector<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(&arg2)) {
            let v1 = 0x1::vector::borrow<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(&arg2, v0);
            0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::claim_voting_bribe<T0, T1>(arg0, arg1, v1, arg3, arg4);
            0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::claim_voting_bribe<T0, T2>(arg0, arg1, v1, arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(&arg2) > 0) {
            0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::transfer<T0>(0x1::vector::pop_back<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_bribes_3<T0, T1, T2, T3>(arg0: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::VotingEscrow<T0>, arg2: vector<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(&arg2)) {
            let v1 = 0x1::vector::borrow<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(&arg2, v0);
            0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::claim_voting_bribe<T0, T1>(arg0, arg1, v1, arg3, arg4);
            0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::claim_voting_bribe<T0, T2>(arg0, arg1, v1, arg3, arg4);
            0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::claim_voting_bribe<T0, T3>(arg0, arg1, v1, arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(&arg2) > 0) {
            0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::transfer<T0>(0x1::vector::pop_back<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_fee_rewards<T0, T1, T2>(arg0: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::VotingEscrow<T0>, arg2: vector<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(&arg2)) {
            let v1 = 0x1::vector::borrow<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(&arg2, v0);
            0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::claim_voting_fee_reward<T0, T1>(arg0, arg1, v1, arg3, arg4);
            0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::claim_voting_fee_reward<T0, T2>(arg0, arg1, v1, arg3, arg4);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(&arg2) > 0) {
            0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::transfer<T0>(0x1::vector::pop_back<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(&mut arg2), arg1, 0x2::tx_context::sender(arg4), arg3, arg4);
        };
        0x1::vector::destroy_empty<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(arg2);
    }

    public fun claim_voting_fee_rewards_single<T0, T1, T2>(arg0: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::VotingEscrow<T0>, arg2: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::claim_voting_fee_reward<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::claim_voting_fee_reward<T0, T2>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun claimable_voting_bribes<T0>(arg0: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>();
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T0>(), claimable_voting_bribes_internal<T0>(arg0, arg1, arg2));
        let v1 = ClaimableVotingBribes{data: v0};
        0x2::event::emit<ClaimableVotingBribes>(v1);
    }

    public fun claimable_voting_bribes_2<T0, T1>(arg0: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>();
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T0>(), claimable_voting_bribes_internal<T0>(arg0, arg1, arg2));
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_bribes_internal<T1>(arg0, arg1, arg2));
        let v1 = ClaimableVotingBribes{data: v0};
        0x2::event::emit<ClaimableVotingBribes>(v1);
    }

    public fun claimable_voting_bribes_3<T0, T1, T2>(arg0: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>();
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T0>(), claimable_voting_bribes_internal<T0>(arg0, arg1, arg2));
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_bribes_internal<T1>(arg0, arg1, arg2));
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x2::object::ID, u64>>(&mut v0, 0x1::type_name::get<T2>(), claimable_voting_bribes_internal<T2>(arg0, arg1, arg2));
        let v1 = ClaimableVotingBribes{data: v0};
        0x2::event::emit<ClaimableVotingBribes>(v1);
    }

    fun claimable_voting_bribes_internal<T0>(arg0: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : 0x2::vec_map::VecMap<0x2::object::ID, u64> {
        let v0 = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::voted_pools(arg0, arg1);
        let v1 = 0;
        let v2 = 0x2::vec_map::empty<0x2::object::ID, u64>();
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v0, v1);
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut v2, v3, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::bribe_voting_reward::earned<T0>(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::borrow_bribe_voting_reward(arg0, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::pool_to_gauge(arg0, v3)), arg1, arg2));
            v1 = v1 + 1;
        };
        v2
    }

    public fun claimable_voting_fees_1<T0>(arg0: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, 0x1::type_name::get<T0>(), claimable_voting_fees_internal<T0>(arg0, arg1, arg2, arg3));
        let v1 = ClaimableVotingFees{data: v0};
        0x2::event::emit<ClaimableVotingFees>(v1);
    }

    public fun claimable_voting_fees_2<T0, T1>(arg0: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, 0x1::type_name::get<T0>(), claimable_voting_fees_internal<T0>(arg0, arg1, arg2, arg3));
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_fees_internal<T1>(arg0, arg1, arg2, arg3));
        let v1 = ClaimableVotingFees{data: v0};
        0x2::event::emit<ClaimableVotingFees>(v1);
    }

    fun claimable_voting_fees_internal<T0>(arg0: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::fee_voting_reward::earned<T0>(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::borrow_fee_voting_reward(arg0, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::pool_to_gauge(arg0, arg2)), arg1, arg3)
    }

    public entry fun create(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::create(arg0, arg1, arg2, arg3);
        0x2::transfer::public_share_object<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter>(v0);
        0x2::transfer::public_transfer<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribute_cap::DistributeCap>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun create_gauge<T0, T1, T2>(arg0: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::minter::Minter<T2>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg2: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg3: &0x759fdf7bc2175c3dd078e16d4703ea5ef655cd055ff74eca9c516e6173c6b42e::gauge_cap::CreateCap, arg4: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::minter::AdminCap, arg5: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::VotingEscrow<T2>, arg6: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::gauge::Gauge<T0, T1>>(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::minter::create_gauge<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public entry fun distribute<T0, T1, T2, T3>(arg0: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::minter::Minter<T2>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg2: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::minter::DistributeGovernorCap, arg3: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg4: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::gauge::Gauge<T0, T1>, arg5: &mut 0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        if (0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::minter::active_period<T2>(arg0) + 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::epoch() < 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::common::current_timestamp(arg13)) {
            abort 93972037923406333
        };
        assert!(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::gauge::pool_id<T0, T1>(arg4) == 0x2::object::id<0xd9d2135d6efbbd95909338e5d1809c48854a35a2f95228ebf28d5fe0faf46234::pool::Pool<T0, T1>>(arg5), 9223373041877123071);
        let v0 = EventDistributeReward{
            sender : 0x2::tx_context::sender(arg14),
            gauge  : 0x2::object::id<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::gauge::Gauge<T0, T1>>(arg4),
            amount : 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::minter::distribute_gauge<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14),
        };
        0x2::event::emit<EventDistributeReward>(v0);
    }

    public entry fun get_voting_bribe_reward_tokens(arg0: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: 0x2::object::ID) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, vector<0x1::type_name::TypeName>>();
        let v1 = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::voted_pools(arg0, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v1, v2);
            0x2::vec_map::insert<0x2::object::ID, vector<0x1::type_name::TypeName>>(&mut v0, v3, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward::rewards_list(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::bribe_voting_reward::borrow_reward(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::borrow_bribe_voting_reward(arg0, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::pool_to_gauge(arg0, v3)))));
            v2 = v2 + 1;
        };
        let v4 = EventRewardTokens{list: v0};
        0x2::event::emit<EventRewardTokens>(v4);
    }

    public entry fun get_voting_bribe_reward_tokens_by_pool(arg0: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: 0x2::object::ID) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, vector<0x1::type_name::TypeName>>();
        0x2::vec_map::insert<0x2::object::ID, vector<0x1::type_name::TypeName>>(&mut v0, arg1, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward::rewards_list(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::bribe_voting_reward::borrow_reward(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::borrow_bribe_voting_reward(arg0, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::pool_to_gauge(arg0, arg1)))));
        let v1 = EventRewardTokens{list: v0};
        0x2::event::emit<EventRewardTokens>(v1);
    }

    public entry fun get_voting_fee_reward_tokens(arg0: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: 0x2::object::ID) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, vector<0x1::type_name::TypeName>>();
        let v1 = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::voted_pools(arg0, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v1, v2);
            0x2::vec_map::insert<0x2::object::ID, vector<0x1::type_name::TypeName>>(&mut v0, v3, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward::rewards_list(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::fee_voting_reward::borrow_reward(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::borrow_fee_voting_reward(arg0, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::pool_to_gauge(arg0, v3)))));
            v2 = v2 + 1;
        };
        let v4 = EventRewardTokens{list: v0};
        0x2::event::emit<EventRewardTokens>(v4);
    }

    public entry fun notify_bribe_reward<T0>(arg0: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::bribe_voting_reward::notify_reward_amount<T0>(0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::borrow_bribe_voting_reward_mut(arg0, 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::pool_to_gauge(arg0, arg1)), 0x1::option::none<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::whitelisted_tokens::WhitelistedToken>(), arg2, arg3, arg4);
    }

    public entry fun poke<T0>(arg0: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::VotingEscrow<T0>, arg2: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg3: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::poke<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun pools_tally(arg0: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: vector<0x2::object::ID>) {
        let v0 = 0x1::vector::empty<PoolWeight>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v2 = PoolWeight{
                id     : *0x1::vector::borrow<0x2::object::ID>(&arg1, v1),
                weight : 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::get_pool_weight(arg0, *0x1::vector::borrow<0x2::object::ID>(&arg1, v1)),
            };
            0x1::vector::push_back<PoolWeight>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = PoolsTally{list: v0};
        0x2::event::emit<PoolsTally>(v3);
    }

    public entry fun vote<T0>(arg0: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::Voter, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::VotingEscrow<T0>, arg2: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::distribution_config::DistributionConfig, arg3: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock, arg4: vector<0x2::object::ID>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voter::vote<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

