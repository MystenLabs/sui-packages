module 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::passive_fee_distributor {
    struct PassiveFeeDistributor<phantom T0> has store, key {
        id: 0x2::object::UID,
        reward_distributor: 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor::RewardDistributor<T0>,
        reward_distributor_cap: 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor_cap::RewardDistributorCap,
        bag: 0x2::bag::Bag,
    }

    public fun balance<T0>(arg0: &PassiveFeeDistributor<T0>) : u64 {
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor::balance<T0>(&arg0.reward_distributor)
    }

    public(friend) fun checkpoint_token<T0>(arg0: &mut PassiveFeeDistributor<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock) {
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor::checkpoint_token<T0>(&mut arg0.reward_distributor, &arg0.reward_distributor_cap, arg1, arg2);
    }

    public fun claim<T0, T1>(arg0: &mut PassiveFeeDistributor<T1>, arg1: &0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::VotingEscrow<T0>, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::Lock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::checked_package_version(arg2);
        let v0 = 0x2::object::id<0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::Lock>(arg3);
        assert!(0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::is_locked(0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::escrow_type<T0>(arg1, v0)) == false, 54894326219497416);
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor::claim<T0, T1>(&mut arg0.reward_distributor, &arg0.reward_distributor_cap, arg1, v0, arg4)
    }

    public fun claimable<T0, T1>(arg0: &PassiveFeeDistributor<T1>, arg1: &0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) : u64 {
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor::claimable<T0, T1>(&arg0.reward_distributor, arg1, arg2)
    }

    public fun last_token_time<T0>(arg0: &PassiveFeeDistributor<T0>) : u64 {
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor::last_token_time<T0>(&arg0.reward_distributor)
    }

    public(friend) fun start<T0>(arg0: &mut PassiveFeeDistributor<T0>, arg1: &0x2::clock::Clock) {
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor::start<T0>(&mut arg0.reward_distributor, &arg0.reward_distributor_cap, arg1);
    }

    public fun tokens_per_period<T0>(arg0: &PassiveFeeDistributor<T0>, arg1: u64) : u64 {
        0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor::tokens_per_period<T0>(&arg0.reward_distributor, arg1)
    }

    public(friend) fun create<T0>(arg0: 0x2::object::ID, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : PassiveFeeDistributor<T0> {
        let v0 = 0x2::object::new(arg2);
        let (v1, v2) = 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_distributor::create_v2<T0>(0x2::object::uid_to_inner(&v0), arg0, arg1, arg2);
        PassiveFeeDistributor<T0>{
            id                     : v0,
            reward_distributor     : v1,
            reward_distributor_cap : v2,
            bag                    : 0x2::bag::new(arg2),
        }
    }

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    // decompiled from Move bytecode v6
}

