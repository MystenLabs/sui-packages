module 0xae7543cc09062bfca91ac0d33da7d44b2df1659d84cee87489979a05d66fc41d::reward_distributor {
    struct Claimable has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct ClaimAndLock has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    public entry fun claimable<T0>(arg0: &0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::rebase_distributor::RebaseDistributor<T0>, arg1: &0xa47eb67ba9072810412acb704da24202a6702b51b0a4d9608850cd2ef53dd08a::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) {
        let v0 = Claimable{
            lock_id : arg2,
            amount  : 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::rebase_distributor::claimable<T0>(arg0, arg1, arg2),
        };
        0x2::event::emit<Claimable>(v0);
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::rebase_distributor::create<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::rebase_distributor_cap::RebaseDistributorCap>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_share_object<0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::rebase_distributor::RebaseDistributor<T0>>(v0);
    }

    public entry fun claim_and_lock<T0>(arg0: &mut 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::rebase_distributor::RebaseDistributor<T0>, arg1: &mut 0xa47eb67ba9072810412acb704da24202a6702b51b0a4d9608850cd2ef53dd08a::voting_escrow::VotingEscrow<T0>, arg2: &0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::distribution_config::DistributionConfig, arg3: &mut 0xa47eb67ba9072810412acb704da24202a6702b51b0a4d9608850cd2ef53dd08a::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimAndLock{
            lock_id : 0x2::object::id<0xa47eb67ba9072810412acb704da24202a6702b51b0a4d9608850cd2ef53dd08a::voting_escrow::Lock>(arg3),
            amount  : 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::rebase_distributor::claim<T0>(arg0, arg1, arg2, arg3, arg4, arg5),
        };
        0x2::event::emit<ClaimAndLock>(v0);
    }

    // decompiled from Move bytecode v6
}

