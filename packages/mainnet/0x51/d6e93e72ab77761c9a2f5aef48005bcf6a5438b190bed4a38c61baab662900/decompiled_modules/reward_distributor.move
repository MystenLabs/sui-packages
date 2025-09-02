module 0x51d6e93e72ab77761c9a2f5aef48005bcf6a5438b190bed4a38c61baab662900::reward_distributor {
    struct Claimable has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct ClaimAndLock has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    public entry fun claimable<T0>(arg0: &0x32fe1a93a598eef2af12732c7fec0d3bb19be96d95c170ed4b1c18a42e496777::rebase_distributor::RebaseDistributor<T0>, arg1: &0x49a7dda98c6dfd2115cee9c00727cf493c01804e55c89b325b08397e414898eb::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) {
        let v0 = Claimable{
            lock_id : arg2,
            amount  : 0x32fe1a93a598eef2af12732c7fec0d3bb19be96d95c170ed4b1c18a42e496777::rebase_distributor::claimable<T0>(arg0, arg1, arg2),
        };
        0x2::event::emit<Claimable>(v0);
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x32fe1a93a598eef2af12732c7fec0d3bb19be96d95c170ed4b1c18a42e496777::rebase_distributor::create<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x32fe1a93a598eef2af12732c7fec0d3bb19be96d95c170ed4b1c18a42e496777::rebase_distributor_cap::RebaseDistributorCap>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_share_object<0x32fe1a93a598eef2af12732c7fec0d3bb19be96d95c170ed4b1c18a42e496777::rebase_distributor::RebaseDistributor<T0>>(v0);
    }

    public entry fun claim_and_lock<T0>(arg0: &mut 0x32fe1a93a598eef2af12732c7fec0d3bb19be96d95c170ed4b1c18a42e496777::rebase_distributor::RebaseDistributor<T0>, arg1: &mut 0x49a7dda98c6dfd2115cee9c00727cf493c01804e55c89b325b08397e414898eb::voting_escrow::VotingEscrow<T0>, arg2: &0x32fe1a93a598eef2af12732c7fec0d3bb19be96d95c170ed4b1c18a42e496777::distribution_config::DistributionConfig, arg3: &mut 0x49a7dda98c6dfd2115cee9c00727cf493c01804e55c89b325b08397e414898eb::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimAndLock{
            lock_id : 0x2::object::id<0x49a7dda98c6dfd2115cee9c00727cf493c01804e55c89b325b08397e414898eb::voting_escrow::Lock>(arg3),
            amount  : 0x32fe1a93a598eef2af12732c7fec0d3bb19be96d95c170ed4b1c18a42e496777::rebase_distributor::claim<T0>(arg0, arg1, arg2, arg3, arg4, arg5),
        };
        0x2::event::emit<ClaimAndLock>(v0);
    }

    // decompiled from Move bytecode v6
}

