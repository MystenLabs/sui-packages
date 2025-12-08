module 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::callback {
    struct DataProposed {
        query_id: 0x2::object::ID,
        data: vector<u8>,
        submitter: address,
        creator_witness: 0x1::type_name::TypeName,
    }

    struct ProposalDisputed {
        query_id: 0x2::object::ID,
        disputer: address,
        creator_witness: 0x1::type_name::TypeName,
    }

    struct QuerySettled {
        query_id: 0x2::object::ID,
        data: vector<u8>,
        creator_witness: 0x1::type_name::TypeName,
    }

    public fun data_proposed_creator_witness(arg0: &DataProposed) : 0x1::type_name::TypeName {
        arg0.creator_witness
    }

    public fun data_proposed_data(arg0: &DataProposed) : vector<u8> {
        arg0.data
    }

    public fun data_proposed_query_id(arg0: &DataProposed) : 0x2::object::ID {
        arg0.query_id
    }

    public fun data_proposed_submitter(arg0: &DataProposed) : address {
        arg0.submitter
    }

    public(friend) fun new_data_proposed(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: 0x1::type_name::TypeName) : DataProposed {
        DataProposed{
            query_id        : arg0,
            data            : arg2,
            submitter       : arg1,
            creator_witness : arg3,
        }
    }

    public(friend) fun new_proposal_disputed(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName) : ProposalDisputed {
        ProposalDisputed{
            query_id        : arg0,
            disputer        : arg1,
            creator_witness : arg2,
        }
    }

    public(friend) fun new_query_settled(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: 0x1::type_name::TypeName) : QuerySettled {
        QuerySettled{
            query_id        : arg0,
            data            : arg1,
            creator_witness : arg2,
        }
    }

    public fun proposal_disputed_creator_witness(arg0: &ProposalDisputed) : 0x1::type_name::TypeName {
        arg0.creator_witness
    }

    public fun proposal_disputed_disputer(arg0: &ProposalDisputed) : address {
        arg0.disputer
    }

    public fun proposal_disputed_query_id(arg0: &ProposalDisputed) : 0x2::object::ID {
        arg0.query_id
    }

    public fun query_settled_creator_witness(arg0: &QuerySettled) : 0x1::type_name::TypeName {
        arg0.creator_witness
    }

    public fun query_settled_data(arg0: &QuerySettled) : vector<u8> {
        arg0.data
    }

    public fun query_settled_query_id(arg0: &QuerySettled) : 0x2::object::ID {
        arg0.query_id
    }

    public fun verify_data_proposed<T0: drop>(arg0: DataProposed, arg1: T0) {
        let DataProposed {
            query_id        : _,
            data            : _,
            submitter       : _,
            creator_witness : v3,
        } = arg0;
        assert!(v3 == 0x1::type_name::with_defining_ids<T0>(), 0);
    }

    public fun verify_proposal_disputed<T0: drop>(arg0: ProposalDisputed, arg1: T0) {
        let ProposalDisputed {
            query_id        : _,
            disputer        : _,
            creator_witness : v2,
        } = arg0;
        assert!(v2 == 0x1::type_name::with_defining_ids<T0>(), 0);
    }

    public fun verify_query_settled<T0: drop>(arg0: QuerySettled, arg1: T0) {
        let QuerySettled {
            query_id        : _,
            data            : _,
            creator_witness : v2,
        } = arg0;
        assert!(v2 == 0x1::type_name::with_defining_ids<T0>(), 0);
    }

    // decompiled from Move bytecode v6
}

