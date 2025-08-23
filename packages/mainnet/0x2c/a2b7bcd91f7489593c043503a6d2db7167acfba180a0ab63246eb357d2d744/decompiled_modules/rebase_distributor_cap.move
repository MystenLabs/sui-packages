module 0xb8a376d33c5f113fdf9faf988c4d16d88a02ff9fec62481fa2b450ee8119316c::rebase_distributor_cap {
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

