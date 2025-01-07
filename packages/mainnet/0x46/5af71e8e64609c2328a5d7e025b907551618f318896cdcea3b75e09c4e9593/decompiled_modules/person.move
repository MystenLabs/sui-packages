module 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::person {
    struct Person has key {
        id: 0x2::object::UID,
        principal: address,
        guardian: address,
    }

    struct Key has copy, drop, store {
        agent: address,
    }

    public fun add_action_for_objects<T0>(arg0: &mut Person, arg1: address, arg2: vector<0x2::object::ID>, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg0.principal, arg3), 0);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::add_action_for_objects<T0>(agent_actions_mut(arg0, arg1), arg2);
    }

    public fun add_action_for_types<T0>(arg0: &mut Person, arg1: address, arg2: vector<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg0.principal, arg3), 0);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::add_action_for_types<T0>(agent_actions_mut(arg0, arg1), arg2);
    }

    public fun add_action_for_type<T0, T1>(arg0: &mut Person, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        let v0 = 0x1::vector::empty<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>();
        0x1::vector::push_back<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(&mut v0, 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::get<T0>());
        add_action_for_types<T1>(arg0, arg1, v0, arg2);
    }

    public fun add_general_action<T0>(arg0: &mut Person, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg0.principal, arg2), 0);
        assert!(!0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::is_admin_action<T0>() && !0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::is_manager_action<T0>(), 1);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::add_general<T0>(agent_actions_mut(arg0, arg1));
    }

    public fun agent_actions(arg0: &Person, arg1: address) : 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet {
        let v0 = Key{agent: arg1};
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::get_with_default<Key, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&arg0.id, v0, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::empty())
    }

    fun agent_actions_mut(arg0: &mut Person, arg1: address) : &mut 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet {
        let v0 = Key{agent: arg1};
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::borrow_mut_fill<Key, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&mut arg0.id, v0, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::empty())
    }

    fun agent_actions_value(arg0: &Person, arg1: address) : 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet {
        let v0 = Key{agent: arg1};
        let v1 = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::get_maybe<Key, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&arg0.id, v0);
        if (0x1::option::is_some<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&v1)) {
            0x1::option::destroy_some<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(v1)
        } else {
            0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::empty()
        }
    }

    public fun claim_delegation(arg0: &Person, arg1: &0x2::tx_context::TxContext) : 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg1);
        claim_delegation_(arg0, 0x2::tx_context::sender(arg1), &v0)
    }

    public fun claim_delegation_(arg0: &Person, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority {
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::merge_action_set_internal(arg0.principal, arg1, agent_actions_value(arg0, arg1), arg2)
    }

    public fun create(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Person {
        Person{
            id        : 0x2::object::new(arg1),
            principal : 0x2::tx_context::sender(arg1),
            guardian  : arg0,
        }
    }

    public fun create_(arg0: address, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority, arg3: &mut 0x2::tx_context::TxContext) : Person {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg0, arg2), 0);
        Person{
            id        : 0x2::object::new(arg3),
            principal : arg0,
            guardian  : arg1,
        }
    }

    public fun destroy(arg0: Person, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg0.principal, arg1), 0);
        let Person {
            id        : v0,
            principal : _,
            guardian  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun guardian(arg0: &Person) : address {
        arg0.guardian
    }

    public fun principal(arg0: &Person) : address {
        arg0.principal
    }

    public fun remove_action_for_objects_from_agent<T0>(arg0: &mut Person, arg1: address, arg2: vector<0x2::object::ID>, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg0.principal, arg3), 0);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::remove_action_for_objects<T0>(agent_actions_mut(arg0, arg1), arg2);
    }

    public fun remove_action_for_type_from_agent<T0, T1>(arg0: &mut Person, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        let v0 = 0x1::vector::empty<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>();
        0x1::vector::push_back<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(&mut v0, 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::get<T0>());
        remove_action_for_types_from_agent<T1>(arg0, arg1, v0, arg2);
    }

    public fun remove_action_for_types_from_agent<T0>(arg0: &mut Person, arg1: address, arg2: vector<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg0.principal, arg3), 0);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::remove_action_for_types<T0>(agent_actions_mut(arg0, arg1), arg2);
    }

    public fun remove_agent(arg0: &mut Person, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg0.principal, arg2), 0);
        let v0 = Key{agent: arg1};
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<Key, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::ActionSet>(&mut arg0.id, v0);
    }

    public fun remove_all_actions_for_objects_from_agent(arg0: &mut Person, arg1: address, arg2: vector<0x2::object::ID>, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg0.principal, arg3), 0);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::remove_all_actions_for_objects(agent_actions_mut(arg0, arg1), arg2);
    }

    public fun remove_all_actions_for_type_from_agent<T0>(arg0: &mut Person, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        let v0 = 0x1::vector::empty<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>();
        0x1::vector::push_back<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(&mut v0, 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::get<T0>());
        remove_all_actions_for_types_from_agent(arg0, arg1, v0, arg2);
    }

    public fun remove_all_actions_for_types_from_agent(arg0: &mut Person, arg1: address, arg2: vector<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg0.principal, arg3), 0);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::remove_all_actions_for_types(agent_actions_mut(arg0, arg1), arg2);
    }

    public fun remove_all_general_actions_from_agent(arg0: &mut Person, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg0.principal, arg2), 0);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::remove_all_general(agent_actions_mut(arg0, arg1));
    }

    public fun remove_general_action_from_agent<T0>(arg0: &mut Person, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg0.principal, arg2), 0);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action_set::remove_general<T0>(agent_actions_mut(arg0, arg1));
    }

    public fun return_and_share(arg0: Person) {
        0x2::transfer::share_object<Person>(arg0);
    }

    public fun uid(arg0: &Person) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut Person) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

