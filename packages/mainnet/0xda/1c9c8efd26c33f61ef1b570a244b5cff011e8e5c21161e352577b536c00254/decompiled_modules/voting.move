module 0xda1c9c8efd26c33f61ef1b570a244b5cff011e8e5c21161e352577b536c00254::voting {
    struct Voter has copy, drop, store {
        voted: bool,
    }

    struct Proposal has copy, drop, store {
        name: vector<u8>,
        vote_count: u64,
    }

    struct VotingSystem has key {
        id: 0x2::object::UID,
        proposals: vector<Proposal>,
        voters: 0x2::table::Table<address, Voter>,
    }

    public entry fun add_proposal(arg0: &mut VotingSystem, arg1: vector<u8>) {
        let v0 = Proposal{
            name       : arg1,
            vote_count : 0,
        };
        0x1::vector::push_back<Proposal>(&mut arg0.proposals, v0);
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = VotingSystem{
            id        : 0x2::object::new(arg0),
            proposals : 0x1::vector::empty<Proposal>(),
            voters    : 0x2::table::new<address, Voter>(arg0),
        };
        0x2::transfer::transfer<VotingSystem>(v0, 0x2::tx_context::sender(arg0));
        true
    }

    public entry fun vote(arg0: &mut VotingSystem, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, Voter>(&arg0.voters, v0)) {
            assert!(!0x2::table::borrow<address, Voter>(&arg0.voters, v0).voted, 0);
        };
        let v1 = Voter{voted: true};
        0x2::table::add<address, Voter>(&mut arg0.voters, v0, v1);
        let v2 = 0x1::vector::borrow_mut<Proposal>(&mut arg0.proposals, arg1);
        v2.vote_count = v2.vote_count + 1;
    }

    // decompiled from Move bytecode v6
}

