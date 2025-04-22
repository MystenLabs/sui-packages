module 0xdbb779d4848bdea676d6a33f5af5559b21fc776623d4a3e0db7171807438ef9e::voting_generic_vuln {
    struct VoteToken<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct VoteStore has key {
        id: 0x2::object::UID,
        proposals: 0x2::object_table::ObjectTable<0x1::ascii::String, Proposal>,
    }

    struct Proposal has store, key {
        id: 0x2::object::UID,
        votes: u64,
    }

    public entry fun create_proposal(arg0: &mut VoteStore, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Proposal{
            id    : 0x2::object::new(arg2),
            votes : 0,
        };
        0x2::object_table::add<0x1::ascii::String, Proposal>(&mut arg0.proposals, arg1, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VoteStore{
            id        : 0x2::object::new(arg0),
            proposals : 0x2::object_table::new<0x1::ascii::String, Proposal>(arg0),
        };
        0x2::transfer::share_object<VoteStore>(v0);
    }

    public entry fun register_voter<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VoteToken<T0>{
            id     : 0x2::object::new(arg0),
            amount : 100,
        };
        0x2::transfer::public_transfer<VoteToken<T0>>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun vote<T0>(arg0: &VoteToken<T0>, arg1: &mut VoteStore, arg2: 0x1::ascii::String) {
        assert!(arg0.amount > 0, 1);
        assert!(0x2::object_table::contains<0x1::ascii::String, Proposal>(&arg1.proposals, arg2), 2);
        let v0 = 0x2::object_table::borrow_mut<0x1::ascii::String, Proposal>(&mut arg1.proposals, arg2);
        v0.votes = v0.votes + arg0.amount;
    }

    // decompiled from Move bytecode v6
}

