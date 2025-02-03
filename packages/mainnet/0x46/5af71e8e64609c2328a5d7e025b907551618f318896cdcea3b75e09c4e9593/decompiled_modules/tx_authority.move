module 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority {
    struct TxAuthority has drop {
        principal_actions: 0x2::vec_map::VecMap<address, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>,
        package_org: 0x2::vec_map::VecMap<0x2::object::ID, address>,
    }

    public fun empty() : TxAuthority {
        TxAuthority{
            principal_actions : 0x2::vec_map::empty<address, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(),
            package_org       : 0x2::vec_map::empty<0x2::object::ID, address>(),
        }
    }

    public(friend) fun add_actions_internal(arg0: address, arg1: address, arg2: vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>, arg3: &TxAuthority) : TxAuthority {
        let v0 = copy_(arg3);
        let v1 = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::get_maybe<address, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&v0.principal_actions, &arg1);
        if (0x1::option::is_some<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&v1)) {
            let v2 = 0x1::option::destroy_some<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(v1);
            0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::add_general_(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::borrow_mut_fill<address, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&mut v0.principal_actions, &arg0, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::new(0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>())), 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::intersection(&arg2, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::general(&v2)));
        };
        v0
    }

    public(friend) fun add_object_id(arg0: &0x2::object::UID, arg1: &TxAuthority) : TxAuthority {
        let v0 = copy_(arg1);
        let v1 = 0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>();
        0x1::vector::push_back<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(&mut v1, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::admin());
        let v2 = 0x2::object::uid_to_address(arg0);
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::set<address, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&mut v0.principal_actions, &v2, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::new(v1));
        v0
    }

    public(friend) fun add_organization_internal(arg0: vector<0x2::object::ID>, arg1: address, arg2: &TxAuthority) : TxAuthority {
        let v0 = copy_(arg2);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg0)) {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::insert_maybe<0x2::object::ID, address>(&mut v0.package_org, 0x1::vector::pop_back<0x2::object::ID>(&mut arg0), arg1);
        };
        v0
    }

    public fun add_package_witness<T0: drop, T1>(arg0: T0, arg1: &TxAuthority) : TxAuthority {
        let (v0, _, v2, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_name_decomposed<T0>();
        let v4 = v0;
        assert!(v2 == 0x1::string::utf8(b"Witness"), 0);
        let v5 = copy_(arg1);
        let v6 = 0x2::object::id_to_address(&v4);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::add_general<T1>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::borrow_mut_fill<address, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&mut v5.principal_actions, &v6, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::new(0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>())));
        v5
    }

    public fun add_package_witness_<T0: drop>(arg0: T0, arg1: &TxAuthority) : TxAuthority {
        let (v0, _, v2, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_name_decomposed<T0>();
        let v4 = v0;
        assert!(v2 == 0x1::string::utf8(b"Witness"), 0);
        let v5 = copy_(arg1);
        let v6 = 0x2::object::id_to_address(&v4);
        let v7 = 0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>();
        0x1::vector::push_back<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(&mut v7, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::admin());
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::set<address, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&mut v5.principal_actions, &v6, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::new(v7));
        v5
    }

    public fun add_signer(arg0: &0x2::tx_context::TxContext, arg1: &TxAuthority) : TxAuthority {
        let v0 = copy_(arg1);
        let v1 = 0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>();
        0x1::vector::push_back<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(&mut v1, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::admin());
        let v2 = 0x2::tx_context::sender(arg0);
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::set<address, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&mut v0.principal_actions, &v2, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::new(v1));
        v0
    }

    public fun add_type<T0>(arg0: &T0, arg1: &TxAuthority) : TxAuthority {
        let v0 = copy_(arg1);
        let v1 = 0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>();
        0x1::vector::push_back<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(&mut v1, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::admin());
        let v2 = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_into_address<T0>();
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::set<address, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&mut v0.principal_actions, &v2, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::new(v1));
        v0
    }

    public fun agents(arg0: &TxAuthority) : vector<address> {
        0x2::vec_map::keys<address, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&arg0.principal_actions)
    }

    public fun begin(arg0: &0x2::tx_context::TxContext) : TxAuthority {
        new_internal(0x2::tx_context::sender(arg0))
    }

    public(friend) fun begin_with_object_id(arg0: &0x2::object::UID) : TxAuthority {
        new_internal(0x2::object::uid_to_address(arg0))
    }

    public fun begin_with_package_witness<T0: drop, T1>(arg0: T0) : TxAuthority {
        let (v0, _, v2, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_name_decomposed<T0>();
        let v4 = v0;
        assert!(v2 == 0x1::string::utf8(b"Witness"), 0);
        new_internal_<T1>(0x2::object::id_to_address(&v4))
    }

    public fun begin_with_package_witness_<T0: drop>(arg0: T0) : TxAuthority {
        let (v0, _, v2, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_name_decomposed<T0>();
        let v4 = v0;
        assert!(v2 == 0x1::string::utf8(b"Witness"), 0);
        new_internal(0x2::object::id_to_address(&v4))
    }

    public fun begin_with_type<T0>(arg0: &T0) : TxAuthority {
        new_internal(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_into_address<T0>())
    }

    public fun can_act_as_address<T0>(arg0: address, arg1: &TxAuthority) : bool {
        let v0 = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::get_maybe<address, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&arg1.principal_actions, &arg0);
        if (0x1::option::is_none<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&v0)) {
            return false
        };
        let v1 = 0x1::option::destroy_some<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(v0);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::contains<T0>(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::general(&v1))
    }

    public fun can_act_as_address_on_object<T0>(arg0: address, arg1: &0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag, arg2: &0x2::object::ID, arg3: &TxAuthority) : bool {
        let v0 = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::get_maybe<address, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&arg3.principal_actions, &arg0);
        if (0x1::option::is_none<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&v0)) {
            return false
        };
        let v1 = 0x1::option::destroy_some<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(v0);
        if (0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::contains<T0>(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::general(&v1))) {
            return true
        };
        let v2 = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::match_struct_tag_maybe<vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::on_types(&v1), arg1);
        if (0x1::option::is_some<vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(&v2)) {
            let v3 = 0x1::option::destroy_some<vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(v2);
            if (0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::contains<T0>(&v3)) {
                return true
            };
        };
        let v4 = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::get_maybe<0x2::object::ID, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::on_objects(&v1), arg2);
        if (0x1::option::is_some<vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(&v4)) {
            let v5 = 0x1::option::destroy_some<vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(v4);
            if (0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::contains<T0>(&v5)) {
                return true
            };
        };
        false
    }

    public fun can_act_as_id<T0: key, T1>(arg0: &T0, arg1: &TxAuthority) : bool {
        can_act_as_id_<T1>(0x2::object::id<T0>(arg0), arg1)
    }

    public fun can_act_as_id_<T0>(arg0: 0x2::object::ID, arg1: &TxAuthority) : bool {
        can_act_as_address<T0>(0x2::object::id_to_address(&arg0), arg1)
    }

    public fun can_act_as_package<T0, T1>(arg0: &TxAuthority) : bool {
        can_act_as_package_<T1>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::package_id<T0>(), arg0)
    }

    public fun can_act_as_package_<T0>(arg0: 0x2::object::ID, arg1: &TxAuthority) : bool {
        if (can_act_as_address<T0>(0x2::object::id_to_address(&arg0), arg1)) {
            return true
        };
        let v0 = lookup_organization_for_package_(arg0, arg1);
        if (0x1::option::is_none<address>(&v0)) {
            return false
        };
        can_act_as_address<T0>(0x1::option::destroy_some<address>(v0), arg1)
    }

    public fun can_act_as_package_excluding_manager<T0, T1>(arg0: &TxAuthority) : bool {
        can_act_as_package_excluding_manager_<T1>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::package_id<T0>(), arg0)
    }

    public fun can_act_as_package_excluding_manager_<T0>(arg0: 0x2::object::ID, arg1: &TxAuthority) : bool {
        let v0 = 0x2::object::id_to_address(&arg0);
        if (can_act_as_address<T0>(v0, arg1) && !is_manager(v0, arg1)) {
            return true
        };
        let v1 = lookup_organization_for_package_(arg0, arg1);
        if (0x1::option::is_none<address>(&v1)) {
            return false
        };
        let v2 = 0x1::option::destroy_some<address>(v1);
        can_act_as_address<T0>(v2, arg1) && !is_manager(v2, arg1)
    }

    public fun can_act_as_package_on_object<T0, T1>(arg0: &0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag, arg1: &0x2::object::ID, arg2: &TxAuthority) : bool {
        can_act_as_package_on_object_<T1>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::package_id<T0>(), arg0, arg1, arg2)
    }

    public fun can_act_as_package_on_object_<T0>(arg0: 0x2::object::ID, arg1: &0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag, arg2: &0x2::object::ID, arg3: &TxAuthority) : bool {
        if (can_act_as_address_on_object<T0>(0x2::object::id_to_address(&arg0), arg1, arg2, arg3)) {
            return true
        };
        let v0 = lookup_organization_for_package_(arg0, arg3);
        if (0x1::option::is_none<address>(&v0)) {
            return false
        };
        can_act_as_address_on_object<T0>(0x1::option::destroy_some<address>(v0), arg1, arg2, arg3)
    }

    public fun can_act_as_package_opt<T0>(arg0: 0x1::option::Option<0x2::object::ID>, arg1: &TxAuthority) : bool {
        if (0x1::option::is_none<0x2::object::ID>(&arg0)) {
            return true
        };
        can_act_as_package_<T0>(0x1::option::destroy_some<0x2::object::ID>(arg0), arg1)
    }

    public fun can_act_as_type<T0, T1>(arg0: &TxAuthority) : bool {
        can_act_as_address<T1>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_into_address<T0>(), arg0)
    }

    public fun copy_(arg0: &TxAuthority) : TxAuthority {
        TxAuthority{
            principal_actions : arg0.principal_actions,
            package_org       : arg0.package_org,
        }
    }

    public fun has_k_or_more_agents_with_action<T0>(arg0: vector<address>, arg1: u64, arg2: &TxAuthority) : bool {
        if (arg1 == 0) {
            return true
        };
        let v0 = 0;
        while (!0x1::vector::is_empty<address>(&arg0)) {
            if (can_act_as_address<T0>(0x1::vector::pop_back<address>(&mut arg0), arg2)) {
                v0 = v0 + 1;
            };
            if (v0 >= arg1) {
                return true
            };
        };
        false
    }

    public fun is_manager(arg0: address, arg1: &TxAuthority) : bool {
        let v0 = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::get_maybe<address, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&arg1.principal_actions, &arg0);
        if (0x1::option::is_none<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&v0)) {
            return false
        };
        let v1 = 0x1::option::destroy_some<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(v0);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::contains_manager(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::general(&v1))
    }

    public fun is_module_authority<T0: drop, T1>() : bool {
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_name<T0>() == witness_string<T1>()
    }

    public fun lookup_organization_for_package<T0>(arg0: &TxAuthority) : 0x1::option::Option<address> {
        let v0 = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::package_id<T0>();
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::get_maybe<0x2::object::ID, address>(&arg0.package_org, &v0)
    }

    public fun lookup_organization_for_package_(arg0: 0x2::object::ID, arg1: &TxAuthority) : 0x1::option::Option<address> {
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::get_maybe<0x2::object::ID, address>(&arg1.package_org, &arg0)
    }

    public(friend) fun merge_action_set_internal(arg0: address, arg1: address, arg2: 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet, arg3: &TxAuthority) : TxAuthority {
        let v0 = copy_(arg3);
        let v1 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::new(0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>());
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::merge(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::borrow_mut_fill<address, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&mut v0.principal_actions, &arg0, v1), 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::intersection(&arg2, 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::borrow_mut_fill<address, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&mut v0.principal_actions, &arg1, v1)));
        v0
    }

    fun new_internal(arg0: address) : TxAuthority {
        let v0 = 0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>();
        0x1::vector::push_back<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(&mut v0, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::admin());
        TxAuthority{
            principal_actions : 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::new<address, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(arg0, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::new(v0)),
            package_org       : 0x2::vec_map::empty<0x2::object::ID, address>(),
        }
    }

    fun new_internal_<T0>(arg0: address) : TxAuthority {
        let v0 = 0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>();
        0x1::vector::push_back<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(&mut v0, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::new<T0>());
        TxAuthority{
            principal_actions : 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::new<address, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(arg0, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::new(v0)),
            package_org       : 0x2::vec_map::empty<0x2::object::ID, address>(),
        }
    }

    public fun organizations(arg0: &TxAuthority) : 0x2::vec_map::VecMap<0x2::object::ID, address> {
        arg0.package_org
    }

    public fun tally_agents_with_action<T0>(arg0: vector<address>, arg1: &TxAuthority) : u64 {
        let v0 = 0;
        while (!0x1::vector::is_empty<address>(&arg0)) {
            if (can_act_as_address<T0>(0x1::vector::pop_back<address>(&mut arg0), arg1)) {
                v0 = v0 + 1;
            };
        };
        v0
    }

    public fun witness_string<T0>() : 0x1::string::String {
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::append_struct_name<T0>(0x1::string::utf8(b"Witness"))
    }

    // decompiled from Move bytecode v6
}

