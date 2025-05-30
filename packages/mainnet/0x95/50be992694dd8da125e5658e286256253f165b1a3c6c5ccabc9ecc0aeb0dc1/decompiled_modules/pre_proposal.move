module 0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::pre_proposal {
    struct PreProposal has store, key {
        id: 0x2::object::UID,
        proposer: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        vote_types: 0x2::linked_table::LinkedTable<0x2::object::ID, 0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::vote_type::VoteType>,
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) : PreProposal {
        let v0 = PreProposal{
            id          : 0x2::object::new(arg3),
            proposer    : 0x2::tx_context::sender(arg3),
            name        : arg0,
            description : arg1,
            vote_types  : 0x2::linked_table::new<0x2::object::ID, 0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::vote_type::VoteType>(arg3),
        };
        while (0x1::vector::length<0x1::string::String>(&arg2) > 0) {
            let v1 = 0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::vote_type::new(0x1::vector::pop_back<0x1::string::String>(&mut arg2), 0x2::object::id<PreProposal>(&v0), 0, arg3);
            0x2::linked_table::push_back<0x2::object::ID, 0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::vote_type::VoteType>(&mut v0.vote_types, 0x2::object::id<0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::vote_type::VoteType>(&v1), v1);
        };
        v0
    }

    public fun description(arg0: &PreProposal) : 0x1::string::String {
        arg0.description
    }

    public(friend) fun destruct(arg0: PreProposal) {
        let PreProposal {
            id          : v0,
            proposer    : _,
            name        : _,
            description : _,
            vote_types  : v4,
        } = arg0;
        let v5 = v4;
        while (0x2::linked_table::length<0x2::object::ID, 0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::vote_type::VoteType>(&v5) > 0) {
            let (_, v7) = 0x2::linked_table::pop_back<0x2::object::ID, 0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::vote_type::VoteType>(&mut v5);
            0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::vote_type::destruct(v7);
        };
        0x2::linked_table::destroy_empty<0x2::object::ID, 0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::vote_type::VoteType>(v5);
        0x2::object::delete(v0);
    }

    public(friend) fun destruct_and_new(arg0: PreProposal, arg1: &mut 0x2::tx_context::TxContext) : PreProposal {
        let PreProposal {
            id          : v0,
            proposer    : v1,
            name        : v2,
            description : v3,
            vote_types  : v4,
        } = arg0;
        0x2::object::delete(v0);
        PreProposal{
            id          : 0x2::object::new(arg1),
            proposer    : v1,
            name        : v2,
            description : v3,
            vote_types  : v4,
        }
    }

    public(friend) fun mut_vote_types(arg0: &mut PreProposal) : &mut 0x2::linked_table::LinkedTable<0x2::object::ID, 0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::vote_type::VoteType> {
        &mut arg0.vote_types
    }

    public fun name(arg0: &PreProposal) : 0x1::string::String {
        arg0.name
    }

    public fun proposer(arg0: &PreProposal) : address {
        arg0.proposer
    }

    public fun vec_vote_types(arg0: &PreProposal) : vector<0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::vote_type::VoteTypeClone> {
        let v0 = 0x1::vector::empty<0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::vote_type::VoteTypeClone>();
        let v1 = 0x2::linked_table::back<0x2::object::ID, 0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::vote_type::VoteType>(&arg0.vote_types);
        while (0x1::option::is_some<0x2::object::ID>(v1)) {
            0x1::vector::push_back<0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::vote_type::VoteTypeClone>(&mut v0, 0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::vote_type::new_from_vote_type(0x2::linked_table::borrow<0x2::object::ID, 0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::vote_type::VoteType>(&arg0.vote_types, *0x1::option::borrow<0x2::object::ID>(v1))));
            let v2 = *0x1::option::borrow<0x2::object::ID>(v1);
            v1 = 0x2::linked_table::prev<0x2::object::ID, 0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::vote_type::VoteType>(&arg0.vote_types, v2);
        };
        v0
    }

    public fun vote_types(arg0: &PreProposal) : &0x2::linked_table::LinkedTable<0x2::object::ID, 0x9550be992694dd8da125e5658e286256253f165b1a3c6c5ccabc9ecc0aeb0dc1::vote_type::VoteType> {
        &arg0.vote_types
    }

    // decompiled from Move bytecode v6
}

