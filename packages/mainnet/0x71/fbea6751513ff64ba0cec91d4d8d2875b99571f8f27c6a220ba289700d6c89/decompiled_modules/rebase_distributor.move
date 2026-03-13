module 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor {
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
        reward_distributor: 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor::RewardDistributor<T0>,
        reward_distributor_cap: 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor_cap::RewardDistributorCap,
        minter_active_period: u64,
        bag: 0x2::bag::Bag,
    }

    public fun balance<T0>(arg0: &RebaseDistributor<T0>) : u64 {
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor::balance<T0>(&arg0.reward_distributor)
    }

    public fun checkpoint_token<T0>(arg0: &mut RebaseDistributor<T0>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor_cap::RebaseDistributorCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor_cap::validate(arg1, 0x2::object::id<RebaseDistributor<T0>>(arg0));
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor::checkpoint_token<T0>(&mut arg0.reward_distributor, &arg0.reward_distributor_cap, arg2, arg3);
    }

    public fun claim<T0>(arg0: &mut RebaseDistributor<T0>, arg1: &mut 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::VotingEscrow<T0>, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &mut 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        let v0 = 0x2::object::id<0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::Lock>(arg3);
        assert!(minter_active_period<T0>(arg0) >= 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::current_period(arg4), 326677348800338700);
        assert!(0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::is_locked(0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::escrow_type<T0>(arg1, v0)) == false, 27562280597090540);
        let v1 = 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor::claim<T0, T0>(&mut arg0.reward_distributor, &arg0.reward_distributor_cap, arg1, v0, arg5);
        let v2 = 0x2::coin::value<T0>(&v1);
        if (v2 > 0) {
            let (v3, _) = 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::locked<T0>(arg1, v0);
            let v5 = v3;
            if (0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::common::current_timestamp(arg4) >= 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::end(&v5) && !0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::is_permanent(&v5)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::owner_of<T0>(arg1, v0, arg5));
            } else {
                0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::deposit_for<T0>(arg1, arg3, v1, arg4, arg5);
            };
        } else {
            0x2::coin::destroy_zero<T0>(v1);
        };
        v2
    }

    public fun claimable<T0>(arg0: &RebaseDistributor<T0>, arg1: &0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) : u64 {
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor::claimable<T0, T0>(&arg0.reward_distributor, arg1, arg2)
    }

    public fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (RebaseDistributor<T0>, 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor_cap::RebaseDistributorCap) {
        assert!(0x2::package::from_module<REBASE_DISTRIBUTOR>(arg0), 208084867296439940);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let (v2, v3) = 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor::create<T0>(v1, arg1, arg2);
        let v4 = RebaseDistributor<T0>{
            id                     : v0,
            reward_distributor     : v2,
            reward_distributor_cap : v3,
            minter_active_period   : 0,
            bag                    : 0x2::bag::new(arg2),
        };
        (v4, 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor_cap::create(v1, arg2))
    }

    public fun last_token_time<T0>(arg0: &RebaseDistributor<T0>) : u64 {
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor::last_token_time<T0>(&arg0.reward_distributor)
    }

    public fun start<T0>(arg0: &mut RebaseDistributor<T0>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor_cap::RebaseDistributorCap, arg2: u64, arg3: &0x2::clock::Clock) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor_cap::validate(arg1, 0x2::object::id<RebaseDistributor<T0>>(arg0));
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor::start<T0>(&mut arg0.reward_distributor, &arg0.reward_distributor_cap, arg3);
        arg0.minter_active_period = arg2;
        let v0 = EventStart{minter_active_period: arg2};
        0x2::event::emit<EventStart>(v0);
    }

    public fun tokens_per_period<T0>(arg0: &RebaseDistributor<T0>, arg1: u64) : u64 {
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor::tokens_per_period<T0>(&arg0.reward_distributor, arg1)
    }

    fun init(arg0: REBASE_DISTRIBUTOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<REBASE_DISTRIBUTOR>(arg0, arg1);
    }

    public fun minter_active_period<T0>(arg0: &RebaseDistributor<T0>) : u64 {
        arg0.minter_active_period
    }

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    public(friend) fun update_active_period<T0>(arg0: &mut RebaseDistributor<T0>, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor_cap::RebaseDistributorCap, arg2: u64) {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor_cap::validate(arg1, 0x2::object::id<RebaseDistributor<T0>>(arg0));
        arg0.minter_active_period = arg2;
        let v0 = EventUpdateActivePeriod{minter_active_period: arg2};
        0x2::event::emit<EventUpdateActivePeriod>(v0);
    }

    // decompiled from Move bytecode v6
}

