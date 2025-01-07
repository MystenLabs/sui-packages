module 0xeb944c66892b743f2a4f3077aafba322f07274cfccb2e6b4428e380489800c0a::burn_bees {
    struct Burn has drop {
        dummy_field: bool,
    }

    struct BurnCondition has drop, store {
        percent: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct BurnCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        policy_cap: 0x2::token::TokenPolicyCap<T0>,
    }

    public fun bees_tokens_to_coin<T0>(arg0: &mut 0x2::token::Token<T0>, arg1: &BurnCap<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::token::split<T0>(arg0, arg3, arg4);
        let (v1, v2) = 0x2::token::to_coin<T0>(v0, arg4);
        let v3 = 0x2::token::spend<T0>(0x2::token::split<T0>(&mut v0, 0x4414b96a690c02eafcdfc974cf733aa44f5e541fab35e4919808213156d9f660::math::mul_div_u128((arg3 as u128), (3 as u128), (100 as u128)), arg4), arg4);
        let v4 = &mut v3;
        verify<T0>(arg2, v4, arg4);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg2, v3, arg4);
        let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<T0>(&arg1.policy_cap, v2, arg4);
        v1
    }

    public fun get_burn_percent<T0>(arg0: &0x2::token::TokenPolicy<T0>) : 0x2::vec_map::VecMap<0x1::string::String, u64> {
        let v0 = Burn{dummy_field: false};
        0x2::token::rule_config<T0, Burn, BurnCondition>(v0, arg0).percent
    }

    public entry fun kraft_burn_cap<T0>(arg0: 0x2::token::TokenPolicyCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BurnCap<T0>{
            id         : 0x2::object::new(arg1),
            policy_cap : arg0,
        };
        0x2::transfer::share_object<BurnCap<T0>>(v0);
    }

    public fun set_burn_percent<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::token::has_rule_config<T0, Burn>(arg0)) {
            let v0 = BurnCondition{percent: arg2};
            let v1 = Burn{dummy_field: false};
            0x2::token::add_rule_config<T0, Burn, BurnCondition>(v1, arg0, arg1, v0, arg3);
        } else {
            let v2 = Burn{dummy_field: false};
            0x2::token::rule_config_mut<T0, Burn, BurnCondition>(v2, arg0, arg1).percent = arg2;
        };
    }

    public fun transfer_bees<T0>(arg0: &mut 0x2::token::Token<T0>, arg1: &BurnCap<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::token::split<T0>(arg0, arg3, arg5);
        let v1 = 0x2::token::transfer<T0>(v0, arg4, arg5);
        let v2 = 0x2::token::spend<T0>(0x2::token::split<T0>(&mut v0, 0x4414b96a690c02eafcdfc974cf733aa44f5e541fab35e4919808213156d9f660::math::mul_div_u128((arg3 as u128), (3 as u128), (100 as u128)), arg5), arg5);
        let v3 = &mut v2;
        verify<T0>(arg2, v3, arg5);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg2, v2, arg5);
        let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<T0>(&arg1.policy_cap, v1, arg5);
    }

    public fun transfer_bees_to_recepient<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &BurnCap<T0>, arg2: 0x2::balance::Balance<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::from_coin<T0>(0x2::coin::from_balance<T0>(arg2, arg4), arg4);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v2;
        verify<T0>(arg0, v4, arg4);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg0, v2, arg4);
        let v9 = &mut v3;
        transfer_bees<T0>(v9, arg1, arg0, 0x2::token::value<T0>(&v3), arg3, arg4);
        0x2::token::destroy_zero<T0>(v3);
    }

    public fun verify<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::token::has_rule_config<T0, Burn>(arg0)) {
            let v0 = Burn{dummy_field: false};
            0x2::token::add_approval<T0, Burn>(v0, arg1, arg2);
            return
        };
        let v1 = Burn{dummy_field: false};
        let v2 = 0x2::token::action<T0>(arg1);
        assert!(!0x2::vec_map::contains<0x1::string::String, u64>(&0x2::token::rule_config<T0, Burn, BurnCondition>(v1, arg0).percent, &v2), 0);
        let v3 = Burn{dummy_field: false};
        0x2::token::add_approval<T0, Burn>(v3, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

