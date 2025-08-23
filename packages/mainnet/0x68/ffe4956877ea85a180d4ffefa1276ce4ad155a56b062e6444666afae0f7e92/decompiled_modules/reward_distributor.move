module 0x68ffe4956877ea85a180d4ffefa1276ce4ad155a56b062e6444666afae0f7e92::reward_distributor {
    struct Claimable has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct ClaimAndLock has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    public entry fun claim_and_lock<T0>(arg0: &mut 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::rebase_distributor::RebaseDistributor<T0>, arg1: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T0>, arg2: &mut 0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimAndLock{
            lock_id : 0x2::object::id<0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::Lock>(arg2),
            amount  : 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::rebase_distributor::claim<T0>(arg0, arg1, arg2, arg3, arg4),
        };
        0x2::event::emit<ClaimAndLock>(v0);
    }

    public entry fun claimable<T0>(arg0: &0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::rebase_distributor::RebaseDistributor<T0>, arg1: &0x3c1fa2694dbcd7cd95d15bdad7ea287be2fbd566c59550a882c085906a86f51a::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) {
        let v0 = Claimable{
            lock_id : arg2,
            amount  : 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::rebase_distributor::claimable<T0>(arg0, arg1, arg2),
        };
        0x2::event::emit<Claimable>(v0);
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::rebase_distributor::create<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::rebase_distributor_cap::RebaseDistributorCap>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_share_object<0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::rebase_distributor::RebaseDistributor<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

