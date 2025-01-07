module 0xab3afd9f82735caee699b41c86ca6e329ef8092e5e7328e93b69181d196861ac::proposal_registry {
    struct ProposalRegistry has store, key {
        id: 0x2::object::UID,
        completed_proposals: 0x2::table_vec::TableVec<0x2::object::ID>,
        active_proposals: 0x2::table_vec::TableVec<0x2::object::ID>,
        pre_proposals: 0x2::table_vec::TableVec<0x2::object::ID>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : ProposalRegistry {
        ProposalRegistry{
            id                  : 0x2::object::new(arg0),
            completed_proposals : 0x2::table_vec::empty<0x2::object::ID>(arg0),
            active_proposals    : 0x2::table_vec::empty<0x2::object::ID>(arg0),
            pre_proposals       : 0x2::table_vec::empty<0x2::object::ID>(arg0),
        }
    }

    public fun add_active_proposal(arg0: &mut ProposalRegistry, arg1: 0x2::object::ID) {
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg0.active_proposals, arg1);
    }

    public fun add_completed_proposal(arg0: &mut ProposalRegistry, arg1: 0x2::object::ID) {
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg0.completed_proposals, arg1);
    }

    public fun add_pre_proposal(arg0: &mut ProposalRegistry, arg1: 0x2::object::ID) {
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg0.pre_proposals, arg1);
    }

    fun find_active_proposal(arg0: &ProposalRegistry, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        find_in_table_vec(&arg0.active_proposals, arg1)
    }

    fun find_completed_proposal(arg0: &ProposalRegistry, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        find_in_table_vec(&arg0.completed_proposals, arg1)
    }

    fun find_in_table_vec(arg0: &0x2::table_vec::TableVec<0x2::object::ID>, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x2::table_vec::length<0x2::object::ID>(arg0)) {
            if (0x2::table_vec::borrow<0x2::object::ID>(arg0, v0) == &arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun find_pre_proposal(arg0: &ProposalRegistry, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        find_in_table_vec(&arg0.pre_proposals, arg1)
    }

    public fun get_active_proposals(arg0: &ProposalRegistry) : vector<0x2::object::ID> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        while (v0 < 0x2::table_vec::length<0x2::object::ID>(&arg0.active_proposals)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v1, *0x2::table_vec::borrow<0x2::object::ID>(&arg0.active_proposals, v0));
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_completed_proposals(arg0: &ProposalRegistry) : vector<0x2::object::ID> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        while (v0 < 0x2::table_vec::length<0x2::object::ID>(&arg0.completed_proposals)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v1, *0x2::table_vec::borrow<0x2::object::ID>(&arg0.completed_proposals, v0));
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_pre_proposals(arg0: &ProposalRegistry) : vector<0x2::object::ID> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        while (v0 < 0x2::table_vec::length<0x2::object::ID>(&arg0.pre_proposals)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v1, *0x2::table_vec::borrow<0x2::object::ID>(&arg0.pre_proposals, v0));
            v0 = v0 + 1;
        };
        v1
    }

    public fun remove_active_proposal(arg0: &mut ProposalRegistry, arg1: 0x2::object::ID) {
        let v0 = find_active_proposal(arg0, arg1);
        0x2::table_vec::swap_remove<0x2::object::ID>(&mut arg0.active_proposals, 0x1::option::extract<u64>(&mut v0));
    }

    public fun remove_completed_proposal(arg0: &mut ProposalRegistry, arg1: 0x2::object::ID) {
        let v0 = find_completed_proposal(arg0, arg1);
        0x2::table_vec::swap_remove<0x2::object::ID>(&mut arg0.completed_proposals, 0x1::option::extract<u64>(&mut v0));
    }

    public fun remove_pre_proposal(arg0: &mut ProposalRegistry, arg1: 0x2::object::ID) {
        let v0 = find_pre_proposal(arg0, arg1);
        0x2::table_vec::swap_remove<0x2::object::ID>(&mut arg0.pre_proposals, 0x1::option::extract<u64>(&mut v0));
    }

    // decompiled from Move bytecode v6
}

