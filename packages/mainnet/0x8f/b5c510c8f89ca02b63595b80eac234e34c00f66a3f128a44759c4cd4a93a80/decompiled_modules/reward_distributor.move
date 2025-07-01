module 0x8fb5c510c8f89ca02b63595b80eac234e34c00f66a3f128a44759c4cd4a93a80::reward_distributor {
    struct Claimable has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct ClaimAndLock has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    public entry fun claim_and_lock<T0>(arg0: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor::RewardDistributor<T0>, arg1: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::VotingEscrow<T0>, arg2: &mut 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimAndLock{
            lock_id : 0x2::object::id<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::Lock>(arg2),
            amount  : 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor::claim<T0>(arg0, arg1, arg2, arg3, arg4),
        };
        0x2::event::emit<ClaimAndLock>(v0);
    }

    public entry fun claimable<T0>(arg0: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor::RewardDistributor<T0>, arg1: &0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) {
        let v0 = Claimable{
            lock_id : arg2,
            amount  : 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor::claimable<T0>(arg0, arg1, arg2),
        };
        0x2::event::emit<Claimable>(v0);
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor::create<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor_cap::RewardDistributorCap>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_share_object<0xd4d7bdc15013391ea5776db31abfc0c2dcf9121b58dcffc29c179e95b56f4c21::reward_distributor::RewardDistributor<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

