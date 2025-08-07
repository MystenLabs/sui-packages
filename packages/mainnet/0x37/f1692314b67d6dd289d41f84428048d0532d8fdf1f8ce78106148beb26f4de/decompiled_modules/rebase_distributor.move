module 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::rebase_distributor {
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
        reward_distributor: 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::RewardDistributor<T0>,
        minter_active_period: u64,
        bag: 0x2::bag::Bag,
    }

    public fun balance<T0>(arg0: &RebaseDistributor<T0>) : u64 {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::balance<T0>(&arg0.reward_distributor)
    }

    public fun checkpoint_token<T0>(arg0: &mut RebaseDistributor<T0>, arg1: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor_cap::RewardDistributorCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::checkpoint_token<T0>(&mut arg0.reward_distributor, arg1, arg2, arg3);
    }

    public fun claim<T0>(arg0: &mut RebaseDistributor<T0>, arg1: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::VotingEscrow<T0>, arg2: &mut 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::object::id<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::Lock>(arg2);
        assert!(minter_active_period<T0>(arg0) >= 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::common::current_period(arg3), 326677348800338700);
        assert!(0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::is_locked(0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::escrow_type<T0>(arg1, v0)) == false, 27562280597090540);
        let v1 = 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::claim<T0, T0>(&mut arg0.reward_distributor, arg1, arg2, arg4);
        let v2 = 0x2::coin::value<T0>(&v1);
        if (v2 > 0) {
            let (v3, _) = 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::locked<T0>(arg1, v0);
            let v5 = v3;
            if (0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::common::current_timestamp(arg3) >= 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::end(&v5) && !0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::is_permanent(&v5)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::owner_of<T0>(arg1, v0));
            } else {
                0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::deposit_for<T0>(arg1, arg2, v1, arg3, arg4);
            };
        } else {
            0x2::coin::destroy_zero<T0>(v1);
        };
        v2
    }

    public fun claimable<T0>(arg0: &RebaseDistributor<T0>, arg1: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) : u64 {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::claimable<T0, T0>(&arg0.reward_distributor, arg1, arg2)
    }

    public fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (RebaseDistributor<T0>, 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor_cap::RewardDistributorCap) {
        assert!(0x2::package::from_module<REBASE_DISTRIBUTOR>(arg0), 208084867296439940);
        let v0 = 0x2::object::new(arg2);
        let (v1, v2) = 0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::create<T0>(0x2::object::uid_to_inner(&v0), arg1, arg2);
        let v3 = RebaseDistributor<T0>{
            id                   : v0,
            reward_distributor   : v1,
            minter_active_period : 0,
            bag                  : 0x2::bag::new(arg2),
        };
        (v3, v2)
    }

    fun init(arg0: REBASE_DISTRIBUTOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<REBASE_DISTRIBUTOR>(arg0, arg1);
    }

    public fun last_token_time<T0>(arg0: &RebaseDistributor<T0>) : u64 {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::last_token_time<T0>(&arg0.reward_distributor)
    }

    public fun minter_active_period<T0>(arg0: &RebaseDistributor<T0>) : u64 {
        arg0.minter_active_period
    }

    public fun start<T0>(arg0: &mut RebaseDistributor<T0>, arg1: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor_cap::RewardDistributorCap, arg2: u64, arg3: &0x2::clock::Clock) {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::start<T0>(&mut arg0.reward_distributor, arg1, arg3);
        arg0.minter_active_period = arg2;
        let v0 = EventStart{minter_active_period: arg2};
        0x2::event::emit<EventStart>(v0);
    }

    public fun tokens_per_period<T0>(arg0: &RebaseDistributor<T0>, arg1: u64) : u64 {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::tokens_per_period<T0>(&arg0.reward_distributor, arg1)
    }

    public(friend) fun update_active_period<T0>(arg0: &mut RebaseDistributor<T0>, arg1: &0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor_cap::RewardDistributorCap, arg2: u64) {
        0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor_cap::validate(arg1, 0x2::object::id<0x74df751c1e5821fde9f56dc3d3afe1305621c337d2b13e0152a858d3e41eb070::reward_distributor::RewardDistributor<T0>>(&arg0.reward_distributor));
        arg0.minter_active_period = arg2;
        let v0 = EventUpdateActivePeriod{minter_active_period: arg2};
        0x2::event::emit<EventUpdateActivePeriod>(v0);
    }

    // decompiled from Move bytecode v6
}

