module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group {
    struct Group has store {
        name: 0x1::string::String,
        holders: 0x2::linked_table::LinkedTable<u64, 0x2::vec_set::VecSet<address>>,
        max_holders: 0x1::option::Option<u64>,
    }

    public(friend) fun drop(arg0: Group) {
        let Group {
            name        : _,
            holders     : v1,
            max_holders : _,
        } = arg0;
        0x2::linked_table::drop<u64, 0x2::vec_set::VecSet<address>>(v1);
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x1::option::Option<u64>, arg2: &mut 0x2::tx_context::TxContext) : Group {
        Group{
            name        : arg0,
            holders     : 0x2::linked_table::new<u64, 0x2::vec_set::VecSet<address>>(arg2),
            max_holders : arg1,
        }
    }

    public(friend) fun add_holder_address(arg0: &mut Group, arg1: u64, arg2: address) {
        if (0x2::linked_table::contains<u64, 0x2::vec_set::VecSet<address>>(&arg0.holders, arg1)) {
            0x2::vec_set::insert<address>(0x2::linked_table::borrow_mut<u64, 0x2::vec_set::VecSet<address>>(&mut arg0.holders, arg1), arg2);
            return
        };
        if (0x1::option::is_some<u64>(&arg0.max_holders)) {
            assert!(0x2::linked_table::length<u64, 0x2::vec_set::VecSet<address>>(&arg0.holders) < *0x1::option::borrow<u64>(&arg0.max_holders), 1);
        };
        0x2::linked_table::push_back<u64, 0x2::vec_set::VecSet<address>>(&mut arg0.holders, arg1, 0x2::vec_set::singleton<address>(arg2));
    }

    public(friend) fun contains_holder(arg0: &Group, arg1: u64) : bool {
        0x2::linked_table::contains<u64, 0x2::vec_set::VecSet<address>>(&arg0.holders, arg1)
    }

    public(friend) fun destroy(arg0: Group) : (0x1::string::String, 0x2::linked_table::LinkedTable<u64, 0x2::vec_set::VecSet<address>>, 0x1::option::Option<u64>) {
        let Group {
            name        : v0,
            holders     : v1,
            max_holders : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public(friend) fun holders(arg0: &Group) : &0x2::linked_table::LinkedTable<u64, 0x2::vec_set::VecSet<address>> {
        &arg0.holders
    }

    public(friend) fun max_holders(arg0: &Group) : &0x1::option::Option<u64> {
        &arg0.max_holders
    }

    public(friend) fun name(arg0: &Group) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun name_mut(arg0: &mut Group) : &mut 0x1::string::String {
        &mut arg0.name
    }

    public(friend) fun remove_holder(arg0: &mut Group, arg1: u64) : 0x2::vec_set::VecSet<address> {
        0x2::linked_table::remove<u64, 0x2::vec_set::VecSet<address>>(&mut arg0.holders, arg1)
    }

    public(friend) fun remove_holder_address(arg0: &mut Group, arg1: u64, arg2: address) {
        assert!(0x2::linked_table::contains<u64, 0x2::vec_set::VecSet<address>>(&arg0.holders, arg1), 0);
        let v0 = 0x2::linked_table::borrow_mut<u64, 0x2::vec_set::VecSet<address>>(&mut arg0.holders, arg1);
        0x2::vec_set::remove<address>(v0, &arg2);
        if (0x2::vec_set::is_empty<address>(v0)) {
            0x2::linked_table::remove<u64, 0x2::vec_set::VecSet<address>>(&mut arg0.holders, arg1);
        };
    }

    public(friend) fun update_max_holders(arg0: &mut Group, arg1: 0x1::option::Option<u64>) : 0x1::option::Option<u64> {
        let v0 = if (0x1::option::is_some<u64>(&arg1)) {
            let v1 = 0x1::option::destroy_some<u64>(arg1);
            let v2 = if (v1 < 0x2::linked_table::length<u64, 0x2::vec_set::VecSet<address>>(&arg0.holders)) {
                0x2::linked_table::length<u64, 0x2::vec_set::VecSet<address>>(&arg0.holders)
            } else {
                v1
            };
            0x1::option::some<u64>(v2)
        } else {
            0x1::option::destroy_none<u64>(arg1);
            0x1::option::none<u64>()
        };
        arg0.max_holders = v0;
        v0
    }

    // decompiled from Move bytecode v7
}

