module 0x78651a6b80ca0eb35dcb3034a35eac6f18e51992a697427a4d351b9e56b56de5::rebase_distributor_cap {
    struct RebaseDistributorCap has store, key {
        id: 0x2::object::UID,
        rebase_distributor: 0x2::object::ID,
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : RebaseDistributorCap {
        RebaseDistributorCap{
            id                 : 0x2::object::new(arg1),
            rebase_distributor : arg0,
        }
    }

    public fun validate(arg0: &RebaseDistributorCap, arg1: 0x2::object::ID) {
        assert!(arg0.rebase_distributor == arg1, 641490194087433300);
    }

    // decompiled from Move bytecode v6
}

