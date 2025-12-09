module 0x4307327d839e5a8f3e6ea6f069ef9b2112577219be25668875d97deb35ec0193::reward_distributor {
    struct Claimable has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct ClaimAndLock has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    public entry fun claim_and_lock<T0>(arg0: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor::RebaseDistributor<T0>, arg1: &mut 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::VotingEscrow<T0>, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &mut 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimAndLock{
            lock_id : 0x2::object::id<0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::Lock>(arg3),
            amount  : 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor::claim<T0>(arg0, arg1, arg2, arg3, arg4, arg5),
        };
        0x2::event::emit<ClaimAndLock>(v0);
    }

    public entry fun claimable<T0>(arg0: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor::RebaseDistributor<T0>, arg1: &0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) {
        let v0 = Claimable{
            lock_id : arg2,
            amount  : 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor::claimable<T0>(arg0, arg1, arg2),
        };
        0x2::event::emit<Claimable>(v0);
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor::create<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor_cap::RebaseDistributorCap>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_share_object<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::rebase_distributor::RebaseDistributor<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

