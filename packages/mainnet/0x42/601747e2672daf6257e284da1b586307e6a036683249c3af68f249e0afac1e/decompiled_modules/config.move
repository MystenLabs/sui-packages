module 0x42601747e2672daf6257e284da1b586307e6a036683249c3af68f249e0afac1e::config {
    struct DaoConfig has store, key {
        id: 0x2::object::UID,
        maximum_amount_of_participants: u64,
        quorum: u8,
        min_yes_votes: u64,
        proposal_index: u64,
        nft_types: vector<0x1::type_name::TypeName>,
    }

    public(friend) fun id(arg0: &DaoConfig) : 0x2::object::ID {
        0x2::object::id<DaoConfig>(arg0)
    }

    public(friend) fun new(arg0: u64, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : DaoConfig {
        DaoConfig{
            id                             : 0x2::object::new(arg3),
            maximum_amount_of_participants : arg0,
            quorum                         : arg1,
            min_yes_votes                  : arg2,
            proposal_index                 : 1,
            nft_types                      : 0x1::vector::empty<0x1::type_name::TypeName>(),
        }
    }

    public(friend) fun add_nft_type<T0: store + key>(arg0: &mut DaoConfig) {
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.nft_types, 0x1::type_name::get<T0>());
    }

    public(friend) fun assert_maximum_amount_of_participants(arg0: &DaoConfig, arg1: u64) {
        assert!(arg1 <= arg0.maximum_amount_of_participants, 5);
    }

    public(friend) fun assert_nft_type<T0: store + key>(arg0: &DaoConfig) {
        let v0 = 0x1::type_name::get<T0>();
        let (v1, _) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.nft_types, &v0);
        assert!(v1, 6);
    }

    public(friend) fun if_min_yes_votes_met(arg0: &DaoConfig, arg1: u64) : bool {
        arg1 >= arg0.min_yes_votes
    }

    public(friend) fun if_quorum_met(arg0: &DaoConfig, arg1: u8) : bool {
        arg1 >= arg0.quorum
    }

    public(friend) fun maximum_amount_of_participants(arg0: &DaoConfig) : u64 {
        arg0.maximum_amount_of_participants
    }

    public(friend) fun nft_types(arg0: &DaoConfig) : vector<0x1::type_name::TypeName> {
        arg0.nft_types
    }

    public(friend) fun proposal_created(arg0: &mut DaoConfig) {
        arg0.proposal_index = arg0.proposal_index + 1;
    }

    public(friend) fun proposal_index(arg0: &DaoConfig) : u64 {
        arg0.proposal_index
    }

    public(friend) fun quorum(arg0: &DaoConfig) : u8 {
        arg0.quorum
    }

    public(friend) fun remove_nft_type<T0: store + key>(arg0: &mut DaoConfig) {
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.nft_types, &v0);
        assert!(v1, 9223372346092421119);
        0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.nft_types, v2);
    }

    public(friend) fun set_maximum_amount_of_participants(arg0: &mut DaoConfig, arg1: u64) {
        arg0.maximum_amount_of_participants = arg1;
    }

    public(friend) fun set_min_yes_votes(arg0: &mut DaoConfig, arg1: u64) {
        arg0.min_yes_votes = arg1;
    }

    public(friend) fun set_quorum(arg0: &mut DaoConfig, arg1: u8) {
        arg0.quorum = arg1;
    }

    // decompiled from Move bytecode v6
}

