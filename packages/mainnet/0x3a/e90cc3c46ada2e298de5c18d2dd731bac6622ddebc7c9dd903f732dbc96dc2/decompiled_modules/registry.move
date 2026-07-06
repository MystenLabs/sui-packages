module 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::registry {
    struct VotingRegistry has key {
        id: 0x2::object::UID,
        proposals: vector<0x2::object::ID>,
    }

    public fun activate_proposal(arg0: &mut VotingRegistry, arg1: &mut 0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::proposal::Proposal, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2) == 1000000000000, 13835339723532402689);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.proposals, 0x2::object::id<0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::proposal::Proposal>(arg1));
        0x3ae90cc3c46ada2e298de5c18d2dd731bac6622ddebc7c9dd903f732dbc96dc2::proposal::activate(arg1, arg2, 0x2::clock::timestamp_ms(arg3) + 1209600000, arg4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VotingRegistry{
            id        : 0x2::object::new(arg0),
            proposals : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<VotingRegistry>(v0);
    }

    // decompiled from Move bytecode v7
}

