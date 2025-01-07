module 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy_registry {
    struct ActionPolicyRegistry has store, key {
        id: 0x2::object::UID,
        action_policies_list: 0x2::vec_set::VecSet<0x2::object::ID>,
        action_policies: 0x2::object_table::ObjectTable<0x2::object::ID, 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy::ActionPolicy>,
    }

    public(friend) fun add_policy(arg0: &mut ActionPolicyRegistry, arg1: 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy::ActionPolicy) {
        let v0 = 0x2::object::id<0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy::ActionPolicy>(&arg1);
        assert!(!policy_exists(arg0, v0), 0);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.action_policies_list, v0);
        0x2::object_table::add<0x2::object::ID, 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy::ActionPolicy>(&mut arg0.action_policies, v0, arg1);
    }

    public(friend) fun borrow_mut_policy(arg0: &mut ActionPolicyRegistry, arg1: 0x2::object::ID) : &mut 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy::ActionPolicy {
        assert!(policy_exists(arg0, arg1), 0);
        0x2::object_table::borrow_mut<0x2::object::ID, 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy::ActionPolicy>(&mut arg0.action_policies, arg1)
    }

    public(friend) fun borrow_policy(arg0: &ActionPolicyRegistry, arg1: 0x2::object::ID) : &0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy::ActionPolicy {
        assert!(policy_exists(arg0, arg1), 0);
        0x2::object_table::borrow<0x2::object::ID, 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy::ActionPolicy>(&arg0.action_policies, arg1)
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) : ActionPolicyRegistry {
        ActionPolicyRegistry{
            id                   : 0x2::object::new(arg0),
            action_policies_list : 0x2::vec_set::empty<0x2::object::ID>(),
            action_policies      : 0x2::object_table::new<0x2::object::ID, 0xff47500d8fe452565b259d307bf21081ec13cd5f249c405e65e0f4159316b160::action_policy::ActionPolicy>(arg0),
        }
    }

    public fun policy_exists(arg0: &ActionPolicyRegistry, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.action_policies_list, &arg1)
    }

    // decompiled from Move bytecode v6
}

