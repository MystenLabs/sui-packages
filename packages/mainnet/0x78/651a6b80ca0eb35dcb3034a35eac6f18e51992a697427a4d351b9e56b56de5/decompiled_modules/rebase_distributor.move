module 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::rebase_distributor {
    struct REBASE_DISTRIBUTOR has drop {
        dummy_field: bool,
    }

    struct EventStart has copy, drop, store {
        minter_active_period: u64,
    }

    struct EventUpdateActivePeriod has copy, drop, store {
        minter_active_period: u64,
    }

    struct RebaseDistributor<phantom T0> has store, key {
        id: 0x2::object::UID,
        reward_distributor: 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward_distributor::RewardDistributor<T0>,
        reward_distributor_cap: 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward_distributor_cap::RewardDistributorCap,
        minter_active_period: u64,
        bag: 0x2::bag::Bag,
    }

    public fun balance<T0>(arg0: &RebaseDistributor<T0>) : u64 {
        0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward_distributor::balance<T0>(&arg0.reward_distributor)
    }

    public fun checkpoint_token<T0>(arg0: &mut RebaseDistributor<T0>, arg1: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::rebase_distributor_cap::RebaseDistributorCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward_distributor::checkpoint_token<T0>(&mut arg0.reward_distributor, &arg0.reward_distributor_cap, arg2, arg3);
    }

    public fun claim<T0>(arg0: &mut RebaseDistributor<T0>, arg1: &mut 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::VotingEscrow<T0>, arg2: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::distribution_config::DistributionConfig, arg3: &mut 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::distribution_config::checked_package_version(arg2);
        let v0 = 0x2::object::id<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::Lock>(arg3);
        assert!(minter_active_period<T0>(arg0) >= 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::common::current_period(arg4), 326677348800338700);
        assert!(0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::is_locked(0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::escrow_type<T0>(arg1, v0)) == false, 27562280597090540);
        let v1 = 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward_distributor::claim<T0, T0>(&mut arg0.reward_distributor, &arg0.reward_distributor_cap, arg1, v0, arg5);
        let v2 = 0x2::coin::value<T0>(&v1);
        if (v2 > 0) {
            let (v3, _) = 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::locked<T0>(arg1, v0);
            let v5 = v3;
            if (0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::common::current_timestamp(arg4) >= 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::end(&v5) && !0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::is_permanent(&v5)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::owner_of<T0>(arg1, v0));
            } else {
                0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::deposit_for<T0>(arg1, arg3, v1, arg4, arg5);
            };
        } else {
            0x2::coin::destroy_zero<T0>(v1);
        };
        v2
    }

    public fun claimable<T0>(arg0: &RebaseDistributor<T0>, arg1: &0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) : u64 {
        0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward_distributor::claimable<T0, T0>(&arg0.reward_distributor, arg1, arg2)
    }

    public fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (RebaseDistributor<T0>, 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::rebase_distributor_cap::RebaseDistributorCap) {
        assert!(0x2::package::from_module<REBASE_DISTRIBUTOR>(arg0), 208084867296439940);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let (v2, v3) = 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward_distributor::create<T0>(v1, arg1, arg2);
        let v4 = RebaseDistributor<T0>{
            id                     : v0,
            reward_distributor     : v2,
            reward_distributor_cap : v3,
            minter_active_period   : 0,
            bag                    : 0x2::bag::new(arg2),
        };
        (v4, 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::rebase_distributor_cap::create(v1, arg2))
    }

    fun init(arg0: REBASE_DISTRIBUTOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<REBASE_DISTRIBUTOR>(arg0, arg1);
    }

    public fun last_token_time<T0>(arg0: &RebaseDistributor<T0>) : u64 {
        0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward_distributor::last_token_time<T0>(&arg0.reward_distributor)
    }

    public fun minter_active_period<T0>(arg0: &RebaseDistributor<T0>) : u64 {
        arg0.minter_active_period
    }

    public fun start<T0>(arg0: &mut RebaseDistributor<T0>, arg1: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::rebase_distributor_cap::RebaseDistributorCap, arg2: u64, arg3: &0x2::clock::Clock) {
        0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::rebase_distributor_cap::validate(arg1, 0x2::object::id<RebaseDistributor<T0>>(arg0));
        0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward_distributor::start<T0>(&mut arg0.reward_distributor, &arg0.reward_distributor_cap, arg3);
        arg0.minter_active_period = arg2;
        let v0 = EventStart{minter_active_period: arg2};
        0x2::event::emit<EventStart>(v0);
    }

    public fun tokens_per_period<T0>(arg0: &RebaseDistributor<T0>, arg1: u64) : u64 {
        0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::reward_distributor::tokens_per_period<T0>(&arg0.reward_distributor, arg1)
    }

    public(friend) fun update_active_period<T0>(arg0: &mut RebaseDistributor<T0>, arg1: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::rebase_distributor_cap::RebaseDistributorCap, arg2: u64) {
        0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::rebase_distributor_cap::validate(arg1, 0x2::object::id<RebaseDistributor<T0>>(arg0));
        arg0.minter_active_period = arg2;
        let v0 = EventUpdateActivePeriod{minter_active_period: arg2};
        0x2::event::emit<EventUpdateActivePeriod>(v0);
    }

    // decompiled from Move bytecode v6
}

