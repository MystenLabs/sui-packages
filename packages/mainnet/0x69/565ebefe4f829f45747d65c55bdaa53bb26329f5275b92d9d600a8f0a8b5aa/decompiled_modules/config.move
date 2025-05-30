module 0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::config {
    struct ProposalConfig has store, key {
        id: 0x2::object::UID,
        fee: u64,
        receiver: address,
        min_in_to_create_proposal: u64,
        min_vote_value: u64,
        proposal_index: u64,
        publisher: 0x2::package::Publisher,
        payment_type: 0x1::type_name::TypeName,
    }

    public(friend) fun new<T0>(arg0: u64, arg1: address, arg2: u64, arg3: u64, arg4: 0x2::package::Publisher, arg5: &mut 0x2::tx_context::TxContext) : ProposalConfig {
        ProposalConfig{
            id                        : 0x2::object::new(arg5),
            fee                       : arg0,
            receiver                  : arg1,
            min_in_to_create_proposal : arg2,
            min_vote_value            : arg3,
            proposal_index            : 1,
            publisher                 : arg4,
            payment_type              : 0x1::type_name::get<T0>(),
        }
    }

    public fun fee(arg0: &ProposalConfig) : u64 {
        arg0.fee
    }

    public fun min_in_to_create_proposal(arg0: &ProposalConfig) : u64 {
        arg0.min_in_to_create_proposal
    }

    public fun min_vote_value(arg0: &ProposalConfig) : u64 {
        arg0.min_vote_value
    }

    public fun payment_type(arg0: &ProposalConfig) : 0x1::type_name::TypeName {
        arg0.payment_type
    }

    public(friend) fun proposal_created(arg0: &mut ProposalConfig) {
        arg0.proposal_index = arg0.proposal_index + 1;
    }

    public fun proposal_index(arg0: &ProposalConfig) : u64 {
        arg0.proposal_index
    }

    public(friend) fun publisher(arg0: &ProposalConfig) : &0x2::package::Publisher {
        &arg0.publisher
    }

    public fun receiver(arg0: &ProposalConfig) : address {
        arg0.receiver
    }

    public entry fun set_dao_receiver(arg0: &0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::dao_admin::DaoAdmin, arg1: &mut ProposalConfig, arg2: address) {
        arg1.receiver = arg2;
    }

    public entry fun set_fee(arg0: &0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::dao_admin::DaoAdmin, arg1: &mut ProposalConfig, arg2: u64) {
        arg1.fee = arg2;
    }

    public entry fun set_min_in_to_create_proposal(arg0: &0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::dao_admin::DaoAdmin, arg1: &mut ProposalConfig, arg2: u64) {
        arg1.min_in_to_create_proposal = arg2;
    }

    public entry fun set_min_vote_value(arg0: &0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::dao_admin::DaoAdmin, arg1: &mut ProposalConfig, arg2: u64) {
        arg1.min_vote_value = arg2;
    }

    public entry fun set_payment_type<T0>(arg0: &0x69565ebefe4f829f45747d65c55bdaa53bb26329f5275b92d9d600a8f0a8b5aa::dao_admin::DaoAdmin, arg1: &mut ProposalConfig) {
        arg1.payment_type = 0x1::type_name::get<T0>();
    }

    // decompiled from Move bytecode v6
}

