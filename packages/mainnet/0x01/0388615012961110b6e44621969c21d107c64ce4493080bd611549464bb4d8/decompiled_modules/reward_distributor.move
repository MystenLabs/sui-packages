module 0x10388615012961110b6e44621969c21d107c64ce4493080bd611549464bb4d8::reward_distributor {
    struct Claimable has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct ClaimAndLock has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    public entry fun claim_and_lock<T0>(arg0: &mut 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward_distributor::RewardDistributor<T0>, arg1: &mut 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::voting_escrow::VotingEscrow<T0>, arg2: &mut 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimAndLock{
            lock_id : 0x2::object::id<0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::voting_escrow::Lock>(arg2),
            amount  : 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward_distributor::claim<T0>(arg0, arg1, arg2, arg3, arg4),
        };
        0x2::event::emit<ClaimAndLock>(v0);
    }

    public entry fun claimable<T0>(arg0: &0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward_distributor::RewardDistributor<T0>, arg1: &0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) {
        let v0 = Claimable{
            lock_id : arg2,
            amount  : 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward_distributor::claimable<T0>(arg0, arg1, arg2),
        };
        0x2::event::emit<Claimable>(v0);
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward_distributor::create<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward_distributor_cap::RewardDistributorCap>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_share_object<0xedcae74183cbbc67b87ca7ef7fabb6da246a127d416899021b2610feb2a0cfd6::reward_distributor::RewardDistributor<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

