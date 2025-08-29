module 0x58263a1a0da01d0ebcb4f61c3dd2ff057bb2fb0bc1cc856ae121d1344ef9461b::voter {
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

    public fun batch_vote<T0>(arg0: &mut 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::Voter, arg1: &mut 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::VotingEscrow<T0>, arg2: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::distribution_config::DistributionConfig, arg3: vector<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::Lock>, arg4: vector<0x2::object::ID>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::Lock>(&arg3)) {
            let v1 = 0x1::vector::pop_back<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::Lock>(&mut arg3);
            0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::vote<T0>(arg0, arg1, arg2, &v1, arg4, arg5, arg6, arg7, arg8);
            0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::transfer<T0>(v1, arg1, 0x2::tx_context::sender(arg8), arg7, arg8);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::Lock>(arg3);
    }

    public fun claim_voting_fee_rewards<T0, T1, T2>(arg0: &mut 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::Voter, arg1: &mut 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::VotingEscrow<T0>, arg2: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::distribution_config::DistributionConfig, arg3: vector<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::Lock>, arg4: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T1, T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::Lock>(&arg3)) {
            0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::claim_voting_fee_by_pool<T1, T2, T0>(arg0, arg1, arg2, 0x1::vector::borrow<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::Lock>(&arg3, v0), arg4, arg5, arg6);
            v0 = v0 + 1;
        };
        while (0x1::vector::length<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::Lock>(&arg3) > 0) {
            0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::transfer<T0>(0x1::vector::pop_back<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::Lock>(&mut arg3), arg1, 0x2::tx_context::sender(arg6), arg5, arg6);
        };
        0x1::vector::destroy_empty<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::Lock>(arg3);
    }

    public fun claim_voting_fee_rewards_single<T0, T1, T2>(arg0: &mut 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::Voter, arg1: &mut 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::VotingEscrow<T0>, arg2: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::distribution_config::DistributionConfig, arg3: &0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::Lock, arg4: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T1, T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::claim_voting_fee_by_pool<T1, T2, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun claimable_voting_fees_1<T0>(arg0: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::Voter, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, 0x1::type_name::get<T0>(), claimable_voting_fees_internal<T0>(arg0, arg1, arg2, arg3));
        let v1 = ClaimableVotingFees{data: v0};
        0x2::event::emit<ClaimableVotingFees>(v1);
    }

    public fun claimable_voting_fees_2<T0, T1>(arg0: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::Voter, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, 0x1::type_name::get<T0>(), claimable_voting_fees_internal<T0>(arg0, arg1, arg2, arg3));
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, 0x1::type_name::get<T1>(), claimable_voting_fees_internal<T1>(arg0, arg1, arg2, arg3));
        let v1 = ClaimableVotingFees{data: v0};
        0x2::event::emit<ClaimableVotingFees>(v1);
    }

    fun claimable_voting_fees_internal<T0>(arg0: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::Voter, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::fee_voting_reward::earned<T0>(0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::borrow_fee_voting_reward(arg0, 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::pool_to_gauge(arg0, arg2)), arg1, arg3)
    }

    public entry fun create(arg0: &0x2::package::Publisher, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::create(arg0, arg1, arg2, arg3);
        0x2::transfer::public_share_object<0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::Voter>(v0);
        0x2::transfer::public_transfer<0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::distribute_cap::DistributeCap>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun create_gauge<T0, T1, T2>(arg0: &mut 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::Minter<T2>, arg1: &mut 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::Voter, arg2: &mut 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::distribution_config::DistributionConfig, arg3: &0xfc5ce91b953f03c30e3e48ac1d2a7706d66697c25979aeb978f9fff3fbcde5b2::gauge_cap::CreateCap, arg4: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::AdminCap, arg5: &0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::VotingEscrow<T2>, arg6: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::gauge::Gauge<T0, T1>>(0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::create_gauge<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public entry fun distribute<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::Minter<T4>, arg1: &mut 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::Voter, arg2: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::DistributeGovernorCap, arg3: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::distribution_config::DistributionConfig, arg4: &mut 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::gauge::Gauge<T0, T1>, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg6: u64, arg7: &mut 0x82fd97f4ab360844693e9bfe655765a7bd1351f18e2a89b2a1eaf694b4390778::price_monitor::PriceMonitor, arg8: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T2, T3>, arg9: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        if (0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::active_period<T4>(arg0) + 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::common::epoch() < 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::common::current_timestamp(arg10)) {
            abort 93972037923406333
        };
        assert!(0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::gauge::pool_id<T0, T1>(arg4) == 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>>(arg5), 9223373041877123071);
        0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::distribute_gauge<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v0 = EventDistributeReward{
            sender : 0x2::tx_context::sender(arg11),
            gauge  : 0x2::object::id<0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::gauge::Gauge<T0, T1>>(arg4),
            amount : arg6,
        };
        0x2::event::emit<EventDistributeReward>(v0);
    }

    public entry fun distribute_for_sail_pool<T0, T1, T2, T3>(arg0: &mut 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::Minter<T2>, arg1: &mut 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::Voter, arg2: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::DistributeGovernorCap, arg3: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::distribution_config::DistributionConfig, arg4: &mut 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::gauge::Gauge<T0, T1>, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg6: u64, arg7: &mut 0x82fd97f4ab360844693e9bfe655765a7bd1351f18e2a89b2a1eaf694b4390778::price_monitor::PriceMonitor, arg8: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        if (0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::active_period<T2>(arg0) + 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::common::epoch() < 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::common::current_timestamp(arg9)) {
            abort 93972037923406333
        };
        assert!(0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::gauge::pool_id<T0, T1>(arg4) == 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>>(arg5), 9223373041877123071);
        0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::minter::distribute_gauge_for_sail_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v0 = EventDistributeReward{
            sender : 0x2::tx_context::sender(arg10),
            gauge  : 0x2::object::id<0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::gauge::Gauge<T0, T1>>(arg4),
            amount : arg6,
        };
        0x2::event::emit<EventDistributeReward>(v0);
    }

    public entry fun get_voting_fee_reward_tokens(arg0: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::Voter, arg1: 0x2::object::ID) {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, vector<0x1::type_name::TypeName>>();
        let v1 = 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::voted_pools(arg0, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v1, v2);
            0x2::vec_map::insert<0x2::object::ID, vector<0x1::type_name::TypeName>>(&mut v0, v3, 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward::rewards_list(0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::fee_voting_reward::borrow_reward(0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::borrow_fee_voting_reward(arg0, 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::pool_to_gauge(arg0, v3)))));
            v2 = v2 + 1;
        };
        let v4 = EventRewardTokens{list: v0};
        0x2::event::emit<EventRewardTokens>(v4);
    }

    public entry fun poke<T0>(arg0: &mut 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::Voter, arg1: &mut 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::VotingEscrow<T0>, arg2: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::distribution_config::DistributionConfig, arg3: &0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::poke<T0>(arg0, arg1, arg2, 0x2::object::id<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::Lock>(arg3), arg4, arg5);
    }

    public entry fun pools_tally(arg0: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::Voter, arg1: vector<0x2::object::ID>) {
        let v0 = 0x1::vector::empty<PoolWeight>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v2 = PoolWeight{
                id     : *0x1::vector::borrow<0x2::object::ID>(&arg1, v1),
                weight : 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::get_pool_weight(arg0, *0x1::vector::borrow<0x2::object::ID>(&arg1, v1)),
            };
            0x1::vector::push_back<PoolWeight>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = PoolsTally{list: v0};
        0x2::event::emit<PoolsTally>(v3);
    }

    public entry fun vote<T0>(arg0: &mut 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::Voter, arg1: &mut 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::VotingEscrow<T0>, arg2: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::distribution_config::DistributionConfig, arg3: &0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::Lock, arg4: vector<0x2::object::ID>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::voter::vote<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

