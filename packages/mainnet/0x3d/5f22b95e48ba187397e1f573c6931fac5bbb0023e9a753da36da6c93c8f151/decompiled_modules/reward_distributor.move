module 0x3d5f22b95e48ba187397e1f573c6931fac5bbb0023e9a753da36da6c93c8f151::reward_distributor {
    struct Claimable has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct ClaimAndLock has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    public entry fun claimable<T0>(arg0: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::rebase_distributor::RebaseDistributor<T0>, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) {
        let v0 = Claimable{
            lock_id : arg2,
            amount  : 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::rebase_distributor::claimable<T0>(arg0, arg1, arg2),
        };
        0x2::event::emit<Claimable>(v0);
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::rebase_distributor::create<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::rebase_distributor_cap::RebaseDistributorCap>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_share_object<0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::rebase_distributor::RebaseDistributor<T0>>(v0);
    }

    public entry fun claim_and_lock<T0>(arg0: &mut 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::rebase_distributor::RebaseDistributor<T0>, arg1: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::VotingEscrow<T0>, arg2: &0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::distribution_config::DistributionConfig, arg3: &mut 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimAndLock{
            lock_id : 0x2::object::id<0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::voting_escrow::Lock>(arg3),
            amount  : 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::rebase_distributor::claim<T0>(arg0, arg1, arg2, arg3, arg4, arg5),
        };
        0x2::event::emit<ClaimAndLock>(v0);
    }

    // decompiled from Move bytecode v6
}

