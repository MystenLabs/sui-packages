module 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::rbac {
    struct RBAC has drop, store {
        principal: address,
        agent_role: 0x2::vec_map::VecMap<address, 0x1::string::String>,
        role_actions: 0x2::vec_map::VecMap<0x1::string::String, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>,
    }

    public fun agent_role(arg0: &RBAC) : &0x2::vec_map::VecMap<address, 0x1::string::String> {
        &arg0.agent_role
    }

    public(friend) fun create(arg0: address) : RBAC {
        RBAC{
            principal    : arg0,
            agent_role   : 0x2::vec_map::empty<address, 0x1::string::String>(),
            role_actions : 0x2::vec_map::empty<0x1::string::String, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(),
        }
    }

    public(friend) fun delete_agent(arg0: &mut RBAC, arg1: address) {
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::remove_maybe<address, 0x1::string::String>(&mut arg0.agent_role, &arg1);
    }

    public(friend) fun delete_role_and_agents(arg0: &mut RBAC, arg1: 0x1::string::String) {
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::remove_entries_with_value<address, 0x1::string::String>(&mut arg0.agent_role, &arg1);
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::remove_maybe<0x1::string::String, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(&mut arg0.role_actions, &arg1);
    }

    public(friend) fun get_admin() : vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action> {
        let v0 = 0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>();
        0x1::vector::push_back<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(&mut v0, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::new<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>());
        v0
    }

    public(friend) fun get_agent_actions(arg0: &RBAC, arg1: address) : vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action> {
        if (arg1 == arg0.principal) {
            let v0 = 0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>();
            0x1::vector::push_back<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(&mut v0, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::new<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>());
            return v0
        };
        let v1 = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::get_maybe<address, 0x1::string::String>(&arg0.agent_role, &arg1);
        if (0x1::option::is_some<0x1::string::String>(&v1)) {
            let v3 = 0x1::option::destroy_some<0x1::string::String>(v1);
            *0x2::vec_map::get<0x1::string::String, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(&arg0.role_actions, &v3)
        } else {
            0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>()
        }
    }

    public(friend) fun grant_action_to_role<T0>(arg0: &mut RBAC, arg1: 0x1::string::String) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::new<T0>();
        if (0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::is_admin_action_(&v0) || 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::is_manager_action_(&v0)) {
            let v1 = 0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>();
            0x1::vector::push_back<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(&mut v1, v0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::set<0x1::string::String, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(&mut arg0.role_actions, &arg1, v1);
        } else {
            let v2 = 0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>();
            0x1::vector::push_back<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(&mut v2, v0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::merge<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::borrow_mut_fill<0x1::string::String, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(&mut arg0.role_actions, &arg1, 0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>()), v2);
        };
    }

    public fun principal(arg0: &RBAC) : address {
        arg0.principal
    }

    public(friend) fun revoke_action_from_role<T0>(arg0: &mut RBAC, arg1: 0x1::string::String) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::new<T0>();
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::remove_maybe<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::borrow_mut_fill<0x1::string::String, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(&mut arg0.role_actions, &arg1, 0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>()), &v0);
    }

    public(friend) fun role_actions(arg0: &RBAC) : &0x2::vec_map::VecMap<0x1::string::String, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>> {
        &arg0.role_actions
    }

    public(friend) fun set_role_for_agent(arg0: &mut RBAC, arg1: address, arg2: 0x1::string::String) {
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::set<address, 0x1::string::String>(&mut arg0.agent_role, &arg1, arg2);
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::borrow_mut_fill<0x1::string::String, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>(&mut arg0.role_actions, &arg2, 0x1::vector::empty<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>());
    }

    public(friend) fun to_fields(arg0: &RBAC) : (address, &0x2::vec_map::VecMap<address, 0x1::string::String>, &0x2::vec_map::VecMap<0x1::string::String, vector<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::Action>>) {
        (arg0.principal, &arg0.agent_role, &arg0.role_actions)
    }

    // decompiled from Move bytecode v6
}

