module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::freeze_rule {
    struct FreezeRule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        frozen_addresses: 0x2::vec_set::VecSet<address>,
    }

    struct AddressFrozen<phantom T0> has copy, drop {
        sender: address,
        addr: address,
        is_frozen: bool,
    }

    public fun add<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: 0x1::string::String, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::token::add_rule_for_action<T0, FreezeRule>(arg0, arg1, arg2, arg4);
        if (!0x2::token::has_rule_config_with_type<T0, FreezeRule, Config>(arg0)) {
            let v0 = FreezeRule{dummy_field: false};
            let v1 = Config{frozen_addresses: 0x2::vec_set::empty<address>()};
            0x2::token::add_rule_config<T0, FreezeRule, Config>(v0, arg0, arg1, v1, arg4);
        };
        0x1::vector::reverse<address>(&mut arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg3)) {
            freeze_address<T0>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg3), arg4);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<address>(arg3);
    }

    public fun default_actions() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x2::token::transfer_action());
        0x1::vector::push_back<0x1::string::String>(v1, 0x2::token::from_coin_action());
        0x1::vector::push_back<0x1::string::String>(v1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::split_action());
        0x1::vector::push_back<0x1::string::String>(v1, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::join_action());
        v0
    }

    public fun freeze_address<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = FreezeRule{dummy_field: false};
        0x2::vec_set::insert<address>(&mut 0x2::token::rule_config_mut<T0, FreezeRule, Config>(v0, arg0, arg1).frozen_addresses, arg2);
        let v1 = AddressFrozen<T0>{
            sender    : 0x2::tx_context::sender(arg3),
            addr      : arg2,
            is_frozen : true,
        };
        0x2::event::emit<AddressFrozen<T0>>(v1);
    }

    public fun is_frozen<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &address) : bool {
        let v0 = FreezeRule{dummy_field: false};
        0x2::vec_set::contains<address>(&0x2::token::rule_config<T0, FreezeRule, Config>(v0, arg0).frozen_addresses, arg1)
    }

    public fun prove<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::assert_policy_version<T0>(arg0);
        let v0 = 0x2::token::sender<T0>(arg1);
        assert!(!is_frozen<T0>(arg0, &v0), 0);
        let v1 = 0x2::token::recipient<T0>(arg1);
        let v2 = &v1;
        if (0x1::option::is_some<address>(v2)) {
            assert!(!is_frozen<T0>(arg0, 0x1::option::borrow<address>(v2)), 0);
        };
        let v3 = FreezeRule{dummy_field: false};
        0x2::token::add_approval<T0, FreezeRule>(v3, arg1, arg2);
    }

    public fun prove_split_join<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SplitJoinRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::action_request_mut<T0>(arg1);
        prove<T0>(arg0, v0, arg2);
    }

    public fun unfreeze_address<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = FreezeRule{dummy_field: false};
        0x2::vec_set::remove<address>(&mut 0x2::token::rule_config_mut<T0, FreezeRule, Config>(v0, arg0, arg1).frozen_addresses, &arg2);
        let v1 = AddressFrozen<T0>{
            sender    : 0x2::tx_context::sender(arg3),
            addr      : arg2,
            is_frozen : false,
        };
        0x2::event::emit<AddressFrozen<T0>>(v1);
    }

    // decompiled from Move bytecode v7
}

