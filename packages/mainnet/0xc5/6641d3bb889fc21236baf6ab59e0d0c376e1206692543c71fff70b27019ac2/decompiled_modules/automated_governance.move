module 0xc56641d3bb889fc21236baf6ab59e0d0c376e1206692543c71fff70b27019ac2::automated_governance {
    struct Proposal has store, key {
        id: 0x2::object::UID,
        description: vector<u8>,
        votes_for: u64,
        votes_against: u64,
        executed: bool,
    }

    public entry fun execute(arg0: &mut Proposal) {
        assert!(!arg0.executed, 1);
        arg0.executed = true;
    }

    public entry fun submit_proposal(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Proposal{
            id            : 0x2::object::new(arg1),
            description   : arg0,
            votes_for     : 0,
            votes_against : 0,
            executed      : false,
        };
        0x2::transfer::transfer<Proposal>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun vote(arg0: &mut Proposal, arg1: bool) {
        if (arg1) {
            arg0.votes_for = arg0.votes_for + 1;
        } else {
            arg0.votes_against = arg0.votes_against + 1;
        };
    }

    // decompiled from Move bytecode v6
}

