module 0x49a7dda98c6dfd2115cee9c00727cf493c01804e55c89b325b08397e414898eb::team_cap {
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

