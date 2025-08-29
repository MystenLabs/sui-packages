module 0x58263a1a0da01d0ebcb4f61c3dd2ff057bb2fb0bc1cc856ae121d1344ef9461b::reward_distributor {
    struct Claimable has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct ClaimAndLock has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    public entry fun claim_and_lock<T0>(arg0: &mut 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::rebase_distributor::RebaseDistributor<T0>, arg1: &mut 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::VotingEscrow<T0>, arg2: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::distribution_config::DistributionConfig, arg3: &mut 0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimAndLock{
            lock_id : 0x2::object::id<0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::Lock>(arg3),
            amount  : 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::rebase_distributor::claim<T0>(arg0, arg1, arg2, arg3, arg4, arg5),
        };
        0x2::event::emit<ClaimAndLock>(v0);
    }

    public entry fun claimable<T0>(arg0: &0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::rebase_distributor::RebaseDistributor<T0>, arg1: &0xd5c34bb087893fec8faf905a1259c008776aaaae84e2d2d46deb1a6b9f95e358::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) {
        let v0 = Claimable{
            lock_id : arg2,
            amount  : 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::rebase_distributor::claimable<T0>(arg0, arg1, arg2),
        };
        0x2::event::emit<Claimable>(v0);
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::rebase_distributor::create<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::rebase_distributor_cap::RebaseDistributorCap>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_share_object<0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::rebase_distributor::RebaseDistributor<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

