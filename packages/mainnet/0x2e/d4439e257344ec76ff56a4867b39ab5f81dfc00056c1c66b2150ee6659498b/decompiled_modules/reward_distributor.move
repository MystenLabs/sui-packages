module 0x2ed4439e257344ec76ff56a4867b39ab5f81dfc00056c1c66b2150ee6659498b::reward_distributor {
    struct Claimable has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct ClaimAndLock has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    public entry fun claim_and_lock<T0>(arg0: &mut 0xbf22bfba6d2a264036325f4c4994ac12261207bb3f7f43676e4d31cd620ea060::reward_distributor::RewardDistributor<T0>, arg1: &mut 0xbf22bfba6d2a264036325f4c4994ac12261207bb3f7f43676e4d31cd620ea060::voting_escrow::VotingEscrow<T0>, arg2: &mut 0xbf22bfba6d2a264036325f4c4994ac12261207bb3f7f43676e4d31cd620ea060::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimAndLock{
            lock_id : 0x2::object::id<0xbf22bfba6d2a264036325f4c4994ac12261207bb3f7f43676e4d31cd620ea060::voting_escrow::Lock>(arg2),
            amount  : 0xbf22bfba6d2a264036325f4c4994ac12261207bb3f7f43676e4d31cd620ea060::reward_distributor::claim<T0>(arg0, arg1, arg2, arg3, arg4),
        };
        0x2::event::emit<ClaimAndLock>(v0);
    }

    public entry fun claimable<T0>(arg0: &0xbf22bfba6d2a264036325f4c4994ac12261207bb3f7f43676e4d31cd620ea060::reward_distributor::RewardDistributor<T0>, arg1: &0xbf22bfba6d2a264036325f4c4994ac12261207bb3f7f43676e4d31cd620ea060::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) {
        let v0 = Claimable{
            lock_id : arg2,
            amount  : 0xbf22bfba6d2a264036325f4c4994ac12261207bb3f7f43676e4d31cd620ea060::reward_distributor::claimable<T0>(arg0, arg1, arg2),
        };
        0x2::event::emit<Claimable>(v0);
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xbf22bfba6d2a264036325f4c4994ac12261207bb3f7f43676e4d31cd620ea060::reward_distributor::create<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0xbf22bfba6d2a264036325f4c4994ac12261207bb3f7f43676e4d31cd620ea060::reward_distributor_cap::RewardDistributorCap>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_share_object<0xbf22bfba6d2a264036325f4c4994ac12261207bb3f7f43676e4d31cd620ea060::reward_distributor::RewardDistributor<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

