module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::lock_group_until_timestamp_rule {
    struct LockGroupPairUntilTimestampRule has drop {
        dummy_field: bool,
    }

    struct GroupPairLockedUntil<phantom T0> has copy, drop {
        sender: address,
        from: u64,
        to: u64,
        unlock_timestamp: u64,
    }

    public fun add<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: 0x1::string::String, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::token::has_rule_config_with_type<T0, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::GroupMaxHolderRule, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::Config>(arg0), 0);
        0x2::token::add_rule_for_action<T0, LockGroupPairUntilTimestampRule>(arg0, arg1, arg2, arg6);
        if (0x2::token::has_rule_config<T0, LockGroupPairUntilTimestampRule>(arg0)) {
            assert!(0x1::vector::length<u64>(&arg3) == 0x1::vector::length<u64>(&arg4), 13906834423451484159);
            assert!(0x1::vector::length<u64>(&arg3) == 0x1::vector::length<u64>(&arg5), 13906834427746451455);
            let v0 = 0;
            while (v0 < 0x1::vector::length<u64>(&arg4)) {
                set_unlock_timestamp<T0>(arg0, arg1, 0x1::vector::pop_back<u64>(&mut arg3), 0x1::vector::pop_back<u64>(&mut arg4), 0x1::vector::pop_back<u64>(&mut arg5), arg6);
                v0 = v0 + 1;
            };
        } else {
            let v1 = LockGroupPairUntilTimestampRule{dummy_field: false};
            0x2::token::add_rule_config<T0, LockGroupPairUntilTimestampRule, 0x2::vec_map::VecMap<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::GroupPair, u64>>(v1, arg0, arg1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::group_pair_vec_map<u64>(arg3, arg4, arg5), arg6);
        };
    }

    public fun default_actions() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x2::token::transfer_action());
        v0
    }

    public fun prove<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::assert_policy_version<T0>(arg0);
        let v0 = 0x2::token::recipient<T0>(arg1);
        assert!(0x1::option::is_some<address>(&v0), 2);
        let v1 = 0x2::token::recipient<T0>(arg1);
        let v2 = LockGroupPairUntilTimestampRule{dummy_field: false};
        let v3 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::new(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::group_id<T0>(arg0, 0x2::token::sender<T0>(arg1)), 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_holder_config::group_id<T0>(arg0, *0x1::option::borrow<address>(&v1)));
        let v4 = 0x2::vec_map::try_get<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::GroupPair, u64>(0x2::token::rule_config<T0, LockGroupPairUntilTimestampRule, 0x2::vec_map::VecMap<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::GroupPair, u64>>(v2, arg0), &v3);
        let v5 = &v4;
        if (0x1::option::is_some<u64>(v5)) {
            assert!(0x2::clock::timestamp_ms(arg2) >= *0x1::option::borrow<u64>(v5), 1);
        };
        let v6 = LockGroupPairUntilTimestampRule{dummy_field: false};
        0x2::token::add_approval<T0, LockGroupPairUntilTimestampRule>(v6, arg1, arg3);
    }

    public fun prove_split_join<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SplitJoinRequest<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::action_request_mut<T0>(arg1);
        prove<T0>(arg0, v0, arg2, arg3);
    }

    public fun set_unlock_timestamp<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = LockGroupPairUntilTimestampRule{dummy_field: false};
        let v1 = 0x2::token::rule_config_mut<T0, LockGroupPairUntilTimestampRule, 0x2::vec_map::VecMap<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::GroupPair, u64>>(v0, arg0, arg1);
        let v2 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::new(arg2, arg3);
        if (0x2::vec_map::contains<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::GroupPair, u64>(v1, &v2)) {
            *0x2::vec_map::get_mut<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::GroupPair, u64>(v1, &v2) = arg4;
        } else {
            0x2::vec_map::insert<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_pair::GroupPair, u64>(v1, v2, arg4);
        };
        let v3 = GroupPairLockedUntil<T0>{
            sender           : 0x2::tx_context::sender(arg5),
            from             : arg2,
            to               : arg3,
            unlock_timestamp : arg4,
        };
        0x2::event::emit<GroupPairLockedUntil<T0>>(v3);
    }

    // decompiled from Move bytecode v7
}

