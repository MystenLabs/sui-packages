module 0xa7c8a8b8952fd4301df7839ca6680cf6d70eec62165248e39e922fb70216312f::voting_system {
    struct Election has store, key {
        id: 0x2::object::UID,
        proposal: 0x1::string::String,
        votes: 0x2::vec_map::VecMap<address, VoterInfo>,
        status: bool,
        creator: address,
    }

    struct VoterInfo has drop, store {
        vote: u8,
        has_voted: bool,
    }

    public fun add_vote(arg0: &mut Election, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status, 2);
        let v0 = VoterInfo{
            vote      : arg1,
            has_voted : true,
        };
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::vec_map::contains<address, VoterInfo>(&arg0.votes, &v1), 0);
        0x2::vec_map::insert<address, VoterInfo>(&mut arg0.votes, v1, v0);
    }

    public fun close_election(arg0: &mut Election, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 3);
        arg0.status = false;
    }

    public fun create_election(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Election{
            id       : 0x2::object::new(arg1),
            proposal : arg0,
            votes    : 0x2::vec_map::empty<address, VoterInfo>(),
            status   : true,
            creator  : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Election>(v0);
    }

    public fun delete_election(arg0: Election, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 3);
        let Election {
            id       : v0,
            proposal : _,
            votes    : _,
            status   : _,
            creator  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun remove_vote(arg0: &mut Election, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status, 2);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_map::contains<address, VoterInfo>(&arg0.votes, &v0), 1);
        let (_, _) = 0x2::vec_map::remove<address, VoterInfo>(&mut arg0.votes, &v0);
    }

    public fun update_vote(arg0: &mut Election, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_map::contains<address, VoterInfo>(&arg0.votes, &v0), 1);
        0x2::vec_map::get_mut<address, VoterInfo>(&mut arg0.votes, &v0).vote = arg1;
    }

    // decompiled from Move bytecode v6
}

