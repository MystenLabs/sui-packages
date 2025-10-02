module 0x19be8f3cbeb49fd3626bf5d342e6379795efa37ce3c170d59b738a36d3fe7ef5::risk_manager {
    struct RiskManager has store {
        total_risks: 0x1::option::Option<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>,
        total_parlay_risks: 0x1::option::Option<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>,
        marble_ids: vector<u64>,
    }

    public(friend) fun add_total_risk(arg0: &mut RiskManager, arg1: 0x1::type_name::TypeName, arg2: u64) {
        assert!(0x1::option::is_some<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(&arg0.total_risks), 2);
        let v0 = 0x1::option::borrow_mut<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(&mut arg0.total_risks);
        if (!0x2::linked_table::contains<0x1::type_name::TypeName, u64>(v0, arg1)) {
            0x2::linked_table::push_back<0x1::type_name::TypeName, u64>(v0, arg1, 0);
        };
        let v1 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, u64>(v0, arg1);
        *v1 = *v1 + arg2;
    }

    public(friend) fun destroy_manager(arg0: RiskManager) {
        let RiskManager {
            total_risks        : v0,
            total_parlay_risks : v1,
            marble_ids         : _,
        } = arg0;
        let v3 = v1;
        let v4 = v0;
        if (0x1::option::is_some<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(&v4)) {
            let v5 = 0x1::option::extract<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(&mut v4);
            if (!0x2::linked_table::is_empty<0x1::type_name::TypeName, u64>(&v5)) {
                while (0x2::linked_table::length<0x1::type_name::TypeName, u64>(&v5) > 0) {
                    let (_, _) = 0x2::linked_table::pop_back<0x1::type_name::TypeName, u64>(&mut v5);
                };
            };
            0x2::linked_table::destroy_empty<0x1::type_name::TypeName, u64>(v5);
        };
        0x1::option::destroy_none<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(v4);
        if (0x1::option::is_some<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(&v3)) {
            let v8 = 0x1::option::extract<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(&mut v3);
            if (!0x2::linked_table::is_empty<0x1::type_name::TypeName, u64>(&v8)) {
                while (0x2::linked_table::length<0x1::type_name::TypeName, u64>(&v8) > 0) {
                    let (_, _) = 0x2::linked_table::pop_back<0x1::type_name::TypeName, u64>(&mut v8);
                };
            };
            0x2::linked_table::destroy_empty<0x1::type_name::TypeName, u64>(v8);
        };
        0x1::option::destroy_none<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(v3);
    }

    public fun marble_ids(arg0: &RiskManager) : vector<u64> {
        arg0.marble_ids
    }

    public fun marble_ids_length(arg0: &RiskManager) : u64 {
        0x1::vector::length<u64>(&arg0.marble_ids)
    }

    public(friend) fun new_manager(arg0: vector<u64>, arg1: &mut 0x2::tx_context::TxContext) : RiskManager {
        RiskManager{
            total_risks        : 0x1::option::some<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(0x2::linked_table::new<0x1::type_name::TypeName, u64>(arg1)),
            total_parlay_risks : 0x1::option::some<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(0x2::linked_table::new<0x1::type_name::TypeName, u64>(arg1)),
            marble_ids         : arg0,
        }
    }

    public fun total_risk(arg0: &RiskManager, arg1: 0x1::type_name::TypeName) : u64 {
        if (0x1::option::is_some<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(&arg0.total_risks)) {
            *0x2::linked_table::borrow<0x1::type_name::TypeName, u64>(0x1::option::borrow<0x2::linked_table::LinkedTable<0x1::type_name::TypeName, u64>>(&arg0.total_risks), arg1)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

