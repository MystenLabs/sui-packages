module 0xf16f79b13fbe2c509cf9e0078bbdcd824b4739da14dcedcc3b6386ab70b5d7de::reward_distributor {
    struct Claimable has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct ClaimAndLock has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    public entry fun claimable<T0>(arg0: &0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::reward_distributor::RewardDistributor<T0>, arg1: &0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) {
        let v0 = Claimable{
            lock_id : arg2,
            amount  : 0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::reward_distributor::claimable<T0>(arg0, arg1, arg2),
        };
        0x2::event::emit<Claimable>(v0);
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::reward_distributor::create<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::reward_distributor_cap::RewardDistributorCap>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_share_object<0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::reward_distributor::RewardDistributor<T0>>(v0);
    }

    public entry fun claim_and_lock<T0>(arg0: &mut 0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::reward_distributor::RewardDistributor<T0>, arg1: &mut 0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::voting_escrow::VotingEscrow<T0>, arg2: &mut 0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimAndLock{
            lock_id : 0x2::object::id<0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::voting_escrow::Lock>(arg2),
            amount  : 0x9af1bff168d5155c2628a29ea17e7012353d94bf7173900461143d096079d96e::reward_distributor::claim<T0>(arg0, arg1, arg2, arg3, arg4),
        };
        0x2::event::emit<ClaimAndLock>(v0);
    }

    // decompiled from Move bytecode v6
}

