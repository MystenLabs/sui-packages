module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::allow_group_rule {
    struct GroupPairAllowedRule has drop {
        dummy_field: bool,
    }

    struct GroupPairAllowed<phantom T0> has copy, drop {
        sender: address,
        from: u64,
        to: u64,
    }

    struct GroupPairDisallowed<phantom T0> has copy, drop {
        sender: address,
        from: u64,
        to: u64,
    }

    public fun add<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: 0x1::string::String, arg3: vector<u64>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg3) == 0x1::vector::length<u64>(&arg4), 3);
        assert!(0x2::token::has_rule_config_with_type<T0, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::GroupMaxHolderRule, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::Config>(arg0), 0);
        0x2::token::add_rule_for_action<T0, GroupPairAllowedRule>(arg0, arg1, arg2, arg5);
        if (0x2::token::has_rule_config<T0, GroupPairAllowedRule>(arg0)) {
            assert!(0x1::vector::length<u64>(&arg3) == 0x1::vector::length<u64>(&arg4), 13906834453516255231);
            let v0 = 0;
            while (v0 < 0x1::vector::length<u64>(&arg4)) {
                allow_group_pair<T0>(arg0, arg1, 0x1::vector::pop_back<u64>(&mut arg3), 0x1::vector::pop_back<u64>(&mut arg4), arg5);
                v0 = v0 + 1;
            };
        } else {
            let v1 = GroupPairAllowedRule{dummy_field: false};
            0x2::token::add_rule_config<T0, GroupPairAllowedRule, 0x2::vec_set::VecSet<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::GroupPair>>(v1, arg0, arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::group_pair_vec_set(arg3, arg4), arg5);
        };
    }

    public fun allow_group_pair<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::contains_group<T0>(arg0, &arg2), 1);
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::contains_group<T0>(arg0, &arg3), 4);
        let v0 = GroupPairAllowedRule{dummy_field: false};
        0x2::vec_set::insert<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::GroupPair>(0x2::token::rule_config_mut<T0, GroupPairAllowedRule, 0x2::vec_set::VecSet<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::GroupPair>>(v0, arg0, arg1), 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::new(arg2, arg3));
        let v1 = GroupPairAllowed<T0>{
            sender : 0x2::tx_context::sender(arg4),
            from   : arg2,
            to     : arg3,
        };
        0x2::event::emit<GroupPairAllowed<T0>>(v1);
    }

    public fun default_actions() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x2::token::transfer_action());
        v0
    }

    public fun disallow_group_pair<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::GroupPair, arg3: &0x2::tx_context::TxContext) {
        let v0 = GroupPairAllowedRule{dummy_field: false};
        0x2::vec_set::remove<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::GroupPair>(0x2::token::rule_config_mut<T0, GroupPairAllowedRule, 0x2::vec_set::VecSet<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::GroupPair>>(v0, arg0, arg1), arg2);
        let v1 = GroupPairDisallowed<T0>{
            sender : 0x2::tx_context::sender(arg3),
            from   : 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::from(arg2),
            to     : 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::to(arg2),
        };
        0x2::event::emit<GroupPairDisallowed<T0>>(v1);
    }

    public fun prove<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::assert_policy_version<T0>(arg0);
        let v0 = 0x2::token::recipient<T0>(arg1);
        assert!(0x1::option::is_some<address>(&v0), 5);
        let v1 = 0x2::token::recipient<T0>(arg1);
        let v2 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::new(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::group_id<T0>(arg0, 0x2::token::sender<T0>(arg1)), 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::group_id<T0>(arg0, *0x1::option::borrow<address>(&v1)));
        let v3 = GroupPairAllowedRule{dummy_field: false};
        assert!(0x2::vec_set::contains<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::GroupPair>(0x2::token::rule_config<T0, GroupPairAllowedRule, 0x2::vec_set::VecSet<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::GroupPair>>(v3, arg0), &v2), 2);
        let v4 = GroupPairAllowedRule{dummy_field: false};
        0x2::token::add_approval<T0, GroupPairAllowedRule>(v4, arg1, arg2);
    }

    public fun prove_split_join<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SplitJoinRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::action_request_mut<T0>(arg1);
        prove<T0>(arg0, v0, arg2);
    }

    // decompiled from Move bytecode v7
}

