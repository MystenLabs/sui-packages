module 0x97e21376b9fe82f849b32ae42fd7499f89c947ca922dd19e3ee2350dd9cfe726::team_cap {
    struct TeamCap has store, key {
        id: 0x2::object::UID,
        target: 0x2::object::ID,
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : TeamCap {
        TeamCap{
            id     : 0x2::object::new(arg1),
            target : arg0,
        }
    }

    public(friend) fun validate(arg0: &TeamCap, arg1: 0x2::object::ID) {
        assert!(arg0.target == arg1, 9223372118459154433);
    }

    // decompiled from Move bytecode v6
}

