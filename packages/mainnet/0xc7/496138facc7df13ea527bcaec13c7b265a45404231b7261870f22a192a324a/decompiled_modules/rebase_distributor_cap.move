module 0x3fcdcee11f485731170944af3acd26b17d1b96121ce6b756fe8517a95192b3a::rebase_distributor_cap {
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

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    public fun validate(arg0: &RebaseDistributorCap, arg1: 0x2::object::ID) {
        assert!(arg0.rebase_distributor == arg1, 641490194087433300);
    }

    // decompiled from Move bytecode v6
}

