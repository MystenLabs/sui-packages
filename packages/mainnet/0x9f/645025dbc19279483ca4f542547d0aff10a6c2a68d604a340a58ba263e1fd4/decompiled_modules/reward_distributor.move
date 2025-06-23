module 0x5b9428ad212672a6ef8404569ae79de723610993579996e0fc2ae7e1665fd1f5::reward_distributor {
    struct Claimable has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct ClaimAndLock has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    public entry fun claim_and_lock<T0>(arg0: &mut 0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::reward_distributor::RewardDistributor<T0>, arg1: &mut 0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::voting_escrow::VotingEscrow<T0>, arg2: &mut 0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimAndLock{
            lock_id : 0x2::object::id<0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::voting_escrow::Lock>(arg2),
            amount  : 0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::reward_distributor::claim<T0>(arg0, arg1, arg2, arg3, arg4),
        };
        0x2::event::emit<ClaimAndLock>(v0);
    }

    public entry fun claimable<T0>(arg0: &0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::reward_distributor::RewardDistributor<T0>, arg1: &0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) {
        let v0 = Claimable{
            lock_id : arg2,
            amount  : 0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::reward_distributor::claimable<T0>(arg0, arg1, arg2),
        };
        0x2::event::emit<Claimable>(v0);
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::reward_distributor::create<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::reward_distributor_cap::RewardDistributorCap>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_share_object<0xf36af3e8e78c2d4a34def7907917e3872ab834602d9eed5123f7d7477c8505b0::reward_distributor::RewardDistributor<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

