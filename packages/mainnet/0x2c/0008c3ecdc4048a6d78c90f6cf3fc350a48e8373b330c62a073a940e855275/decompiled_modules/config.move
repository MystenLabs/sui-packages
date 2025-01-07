module 0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::config {
    struct ProposalConfig has store, key {
        id: 0x2::object::UID,
        fee: u64,
        receiver: address,
        min_generis_to_create_proposal: u64,
        proposal_index: u64,
        publisher: 0x2::package::Publisher,
    }

    public(friend) fun new(arg0: u64, arg1: address, arg2: u64, arg3: 0x2::package::Publisher, arg4: &mut 0x2::tx_context::TxContext) : ProposalConfig {
        ProposalConfig{
            id                             : 0x2::object::new(arg4),
            fee                            : arg0,
            receiver                       : arg1,
            min_generis_to_create_proposal : arg2,
            proposal_index                 : 1,
            publisher                      : arg3,
        }
    }

    public fun fee(arg0: &ProposalConfig) : u64 {
        arg0.fee
    }

    public fun min_generis_to_create_proposal(arg0: &ProposalConfig) : u64 {
        arg0.min_generis_to_create_proposal
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

    public entry fun set_dao_receiver(arg0: &0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::dao_admin::DaoAdmin, arg1: &mut ProposalConfig, arg2: address) {
        arg1.receiver = arg2;
    }

    public entry fun set_fee(arg0: &0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::dao_admin::DaoAdmin, arg1: &mut ProposalConfig, arg2: u64) {
        arg1.fee = arg2;
    }

    public entry fun set_min_generis_to_create_proposal(arg0: &0x2c0008c3ecdc4048a6d78c90f6cf3fc350a48e8373b330c62a073a940e855275::dao_admin::DaoAdmin, arg1: &mut ProposalConfig, arg2: u64) {
        arg1.min_generis_to_create_proposal = arg2;
    }

    // decompiled from Move bytecode v6
}

