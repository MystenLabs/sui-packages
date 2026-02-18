module 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::passive_fee_distributor {
    struct PassiveFeeDistributor<phantom T0> has store, key {
        id: 0x2::object::UID,
        reward_distributor: 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor::RewardDistributor<T0>,
        reward_distributor_cap: 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor_cap::RewardDistributorCap,
        bag: 0x2::bag::Bag,
    }

    public fun balance<T0>(arg0: &PassiveFeeDistributor<T0>) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor::balance<T0>(&arg0.reward_distributor)
    }

    public(friend) fun checkpoint_token<T0>(arg0: &mut PassiveFeeDistributor<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor::checkpoint_token<T0>(&mut arg0.reward_distributor, &arg0.reward_distributor_cap, arg1, arg2);
    }

    public fun claim<T0, T1>(arg0: &mut PassiveFeeDistributor<T1>, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg2: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::distribution_config::DistributionConfig, arg3: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::distribution_config::checked_package_version(arg2);
        let v0 = 0x2::object::id<0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock>(arg3);
        assert!(0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::is_locked(0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::escrow_type<T0>(arg1, v0)) == false, 54894326219497416);
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor::claim<T0, T1>(&mut arg0.reward_distributor, &arg0.reward_distributor_cap, arg1, v0, arg4)
    }

    public fun claimable<T0, T1>(arg0: &PassiveFeeDistributor<T1>, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor::claimable<T0, T1>(&arg0.reward_distributor, arg1, arg2)
    }

    public(friend) fun create<T0>(arg0: 0x2::object::ID, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : PassiveFeeDistributor<T0> {
        let v0 = 0x2::object::new(arg2);
        let (v1, v2) = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor::create_v2<T0>(0x2::object::uid_to_inner(&v0), arg0, arg1, arg2);
        PassiveFeeDistributor<T0>{
            id                     : v0,
            reward_distributor     : v1,
            reward_distributor_cap : v2,
            bag                    : 0x2::bag::new(arg2),
        }
    }

    public fun last_token_time<T0>(arg0: &PassiveFeeDistributor<T0>) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor::last_token_time<T0>(&arg0.reward_distributor)
    }

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    public(friend) fun start<T0>(arg0: &mut PassiveFeeDistributor<T0>, arg1: &0x2::clock::Clock) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor::start<T0>(&mut arg0.reward_distributor, &arg0.reward_distributor_cap, arg1);
    }

    public fun tokens_per_period<T0>(arg0: &PassiveFeeDistributor<T0>, arg1: u64) : u64 {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_distributor::tokens_per_period<T0>(&arg0.reward_distributor, arg1)
    }

    // decompiled from Move bytecode v6
}

