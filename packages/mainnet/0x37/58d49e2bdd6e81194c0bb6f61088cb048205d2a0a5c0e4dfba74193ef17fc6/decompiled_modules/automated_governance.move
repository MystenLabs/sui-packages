module 0x3758d49e2bdd6e81194c0bb6f61088cb048205d2a0a5c0e4dfba74193ef17fc6::automated_governance {
    struct Proposal has store, key {
        id: 0x2::object::UID,
        description: vector<u8>,
        votes_for: u64,
        votes_against: u64,
        executed: bool,
    }

    struct Dashboard has store, key {
        id: 0x2::object::UID,
        proposals_ids: vector<0x2::object::ID>,
    }

    public entry fun execute(arg0: &mut Proposal) {
        assert!(!arg0.executed, 1);
        arg0.executed = true;
    }

    public entry fun init_dashboard(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Dashboard{
            id            : 0x2::object::new(arg0),
            proposals_ids : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::transfer<Dashboard>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun submit_proposal(arg0: vector<u8>, arg1: &mut Dashboard, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Proposal{
            id            : 0x2::object::new(arg2),
            description   : arg0,
            votes_for     : 0,
            votes_against : 0,
            executed      : false,
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.proposals_ids, 0x2::object::id<Proposal>(&v0));
        0x2::transfer::transfer<Proposal>(v0, 0x2::tx_context::sender(arg2));
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

