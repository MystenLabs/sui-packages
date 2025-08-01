module 0x1e415c1f032208644798cf5f3980b3fd4f058a9b01ce191a4eca79696e799a1b::reward_distributor {
    struct Claimable has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct ClaimAndLock has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    public entry fun claim_and_lock<T0>(arg0: &mut 0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::rebase_distributor::RebaseDistributor<T0>, arg1: &mut 0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::voting_escrow::VotingEscrow<T0>, arg2: &mut 0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimAndLock{
            lock_id : 0x2::object::id<0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::voting_escrow::Lock>(arg2),
            amount  : 0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::rebase_distributor::claim<T0>(arg0, arg1, arg2, arg3, arg4),
        };
        0x2::event::emit<ClaimAndLock>(v0);
    }

    public entry fun claimable<T0>(arg0: &0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::rebase_distributor::RebaseDistributor<T0>, arg1: &0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) {
        let v0 = Claimable{
            lock_id : arg2,
            amount  : 0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::rebase_distributor::claimable<T0>(arg0, arg1, arg2),
        };
        0x2::event::emit<Claimable>(v0);
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::rebase_distributor::create<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::reward_distributor_cap::RewardDistributorCap>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_share_object<0x5ee778a0e10b43e6b28367b72cb15731760e4f42d0da4637af5bbecbcd814e8b::rebase_distributor::RebaseDistributor<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

