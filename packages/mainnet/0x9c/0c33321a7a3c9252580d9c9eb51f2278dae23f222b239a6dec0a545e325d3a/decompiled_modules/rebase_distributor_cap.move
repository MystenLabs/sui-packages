module 0x2f3827c5462f19283c33f3fe55169edd49093c18366b831b626ed9517c4baf99::rebase_distributor_cap {
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

