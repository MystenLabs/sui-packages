module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::min_amount_rule {
    struct MinAmountRule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        min_amount: u64,
    }

    struct MinTokenBalanceUpdated<phantom T0> has copy, drop {
        sender: address,
        min_balance: u64,
    }

    public fun add<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        add_for_action<T0>(arg0, arg1, arg2, arg4);
        set_min_amount<T0>(arg0, arg1, arg3, arg4);
    }

    public fun add_for_action<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        if (!has_rule_for_action<T0>(arg0, &arg2)) {
            0x2::token::add_rule_for_action<T0, MinAmountRule>(arg0, arg1, arg2, arg3);
        };
    }

    public(friend) fun approve_timelock_tail<T0>(arg0: &mut 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SplitJoinRequest<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MinAmountRule{dummy_field: false};
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::add_approval<T0, MinAmountRule>(v0, arg0, arg1);
    }

    public fun default_actions() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x2::token::transfer_action());
        0x1::vector::push_back<0x1::string::String>(v1, 0x2::token::from_coin_action());
        0x1::vector::push_back<0x1::string::String>(v1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::split_action());
        v0
    }

    public fun has_rule_for_action<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &0x1::string::String) : bool {
        if (0x2::token::is_allowed<T0>(arg0, arg1)) {
            let v1 = 0x2::token::rules<T0>(arg0, arg1);
            let v2 = 0x1::type_name::with_defining_ids<MinAmountRule>();
            0x2::vec_set::contains<0x1::type_name::TypeName>(&v1, &v2)
        } else {
            false
        }
    }

    public fun min_amount<T0>(arg0: &0x2::token::TokenPolicy<T0>) : u64 {
        let v0 = MinAmountRule{dummy_field: false};
        0x2::token::rule_config<T0, MinAmountRule, Config>(v0, arg0).min_amount
    }

    public fun prove<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::assert_policy_version<T0>(arg0);
        let v0 = split_actions();
        let v1 = 0x2::token::action<T0>(arg1);
        assert!(!0x1::vector::contains<0x1::string::String>(&v0, &v1), 0);
        assert!(0x2::token::amount<T0>(arg1) >= min_amount<T0>(arg0), 1);
        let v2 = MinAmountRule{dummy_field: false};
        0x2::token::add_approval<T0, MinAmountRule>(v2, arg1, arg2);
    }

    public fun prove_split<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SplitJoinRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::assert_policy_version<T0>(arg0);
        let v0 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::request_approvals<T0>(arg1);
        let v1 = 0x1::type_name::with_defining_ids<MinAmountRule>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&v0, &v1)) {
            return
        };
        let v2 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::request_amount<T0>(arg1);
        let v3 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::request_full_amount<T0>(arg1) - v2;
        assert!(v2 >= min_amount<T0>(arg0), 1);
        assert!(v3 >= min_amount<T0>(arg0) || 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::request_action<T0>(arg1) != 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::split_action() && v3 == 0, 1);
        let v4 = MinAmountRule{dummy_field: false};
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::add_approval<T0, MinAmountRule>(v4, arg1, arg2);
    }

    public fun set_min_amount<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::token::has_rule_config_with_type<T0, MinAmountRule, Config>(arg0)) {
            update_min_amount<T0>(arg0, arg1, arg2, arg3);
        } else {
            let v0 = MinAmountRule{dummy_field: false};
            let v1 = Config{min_amount: arg2};
            0x2::token::add_rule_config<T0, MinAmountRule, Config>(v0, arg0, arg1, v1, arg3);
            let v2 = MinTokenBalanceUpdated<T0>{
                sender      : 0x2::tx_context::sender(arg3),
                min_balance : arg2,
            };
            0x2::event::emit<MinTokenBalanceUpdated<T0>>(v2);
        };
    }

    fun split_actions() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x2::token::from_coin_action());
        0x1::vector::push_back<0x1::string::String>(v1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::split_action());
        v0
    }

    public fun update_min_amount<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = MinAmountRule{dummy_field: false};
        0x2::token::rule_config_mut<T0, MinAmountRule, Config>(v0, arg0, arg1).min_amount = arg2;
        let v1 = MinTokenBalanceUpdated<T0>{
            sender      : 0x2::tx_context::sender(arg3),
            min_balance : arg2,
        };
        0x2::event::emit<MinTokenBalanceUpdated<T0>>(v1);
    }

    // decompiled from Move bytecode v7
}

