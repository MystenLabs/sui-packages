module 0xb21fd30f9115df4551e68eb56406ce390e53ef5044b115c02982ecec944d5f64::reward_distributor {
    struct Claimable has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct ClaimAndLock has copy, drop, store {
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    public entry fun claimable<T0>(arg0: &0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::rebase_distributor::RebaseDistributor<T0>, arg1: &0x2469959951798462ecba5efc3b93276560472be279494561331d384baeedab4c::voting_escrow::VotingEscrow<T0>, arg2: 0x2::object::ID) {
        let v0 = Claimable{
            lock_id : arg2,
            amount  : 0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::rebase_distributor::claimable<T0>(arg0, arg1, arg2),
        };
        0x2::event::emit<Claimable>(v0);
    }

    public entry fun create<T0>(arg0: &0x2::package::Publisher, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::rebase_distributor::create<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::rebase_distributor_cap::RebaseDistributorCap>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_share_object<0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::rebase_distributor::RebaseDistributor<T0>>(v0);
    }

    public entry fun claim_and_lock<T0>(arg0: &mut 0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::rebase_distributor::RebaseDistributor<T0>, arg1: &mut 0x2469959951798462ecba5efc3b93276560472be279494561331d384baeedab4c::voting_escrow::VotingEscrow<T0>, arg2: &0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::distribution_config::DistributionConfig, arg3: &mut 0x2469959951798462ecba5efc3b93276560472be279494561331d384baeedab4c::voting_escrow::Lock, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimAndLock{
            lock_id : 0x2::object::id<0x2469959951798462ecba5efc3b93276560472be279494561331d384baeedab4c::voting_escrow::Lock>(arg3),
            amount  : 0xa270354407947f28987286a39a8a24e2d409c24dcd4b5e7d95882adc160305b4::rebase_distributor::claim<T0>(arg0, arg1, arg2, arg3, arg4, arg5),
        };
        0x2::event::emit<ClaimAndLock>(v0);
    }

    // decompiled from Move bytecode v6
}

