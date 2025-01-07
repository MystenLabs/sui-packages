module 0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::bee {
    struct BEE has drop {
        dummy_field: bool,
    }

    struct Burn has drop {
        dummy_field: bool,
    }

    struct BurnCondition has drop, store {
        percent: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct BeesTransferred has copy, drop {
        bees_to_transfer: u64,
        receipient: address,
        bees_burnt: u64,
    }

    struct BeesUnwrappedToCoin has copy, drop {
        bees_to_unwrap: u64,
        bees_burnt: u64,
    }

    public fun get_total_bee_Supply() : u64 {
        0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::constants::total_bee_supply()
    }

    fun init(arg0: BEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEE>(arg0, 6, b"BEE", b"BEEs", b"Incentivizing the collaborative AI revolution on DegenHive!`", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://degenhive.ai/assets/bee_logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun set_burn_percent<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::token::has_rule_config<T0, Burn>(arg0)) {
            let v0 = BurnCondition{percent: arg2};
            let v1 = Burn{dummy_field: false};
            0x2::token::add_rule_config<T0, Burn, BurnCondition>(v1, arg0, arg1, v0, arg3);
        } else {
            let v2 = Burn{dummy_field: false};
            0x2::token::rule_config_mut<T0, Burn, BurnCondition>(v2, arg0, arg1).percent = arg2;
        };
    }

    public fun set_rules<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::constants::bee_burn_pct();
        0x2::token::add_rule_for_action<T0, Burn>(arg0, arg1, 0x2::token::transfer_action(), arg2);
        0x2::token::add_rule_for_action<T0, Burn>(arg0, arg1, 0x2::token::spend_action(), arg2);
        0x2::token::add_rule_for_action<T0, Burn>(arg0, arg1, 0x2::token::to_coin_action(), arg2);
        0x2::token::add_rule_for_action<T0, Burn>(arg0, arg1, 0x2::token::from_coin_action(), arg2);
        let v1 = 0x2::vec_map::empty<0x1::string::String, u64>();
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v1, 0x2::token::transfer_action(), v0);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v1, 0x2::token::to_coin_action(), v0);
        set_burn_percent<T0>(arg0, arg1, v1, arg2);
    }

    public fun transfer_bees<T0>(arg0: &mut 0x2::token::Token<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::token::split<T0>(arg0, arg3, arg5);
        let v1 = Burn{dummy_field: false};
        let v2 = 0x2::token::transfer_action();
        let v3 = 0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::math::mul_div_u128((arg3 as u128), (*0x2::vec_map::get<0x1::string::String, u64>(&0x2::token::rule_config<T0, Burn, BurnCondition>(v1, arg2).percent, &v2) as u128), (0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::constants::percent_precision() as u128));
        let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<T0>(arg1, 0x2::token::transfer<T0>(v0, arg4, arg5), arg5);
        let v8 = 0x2::token::spend<T0>(0x2::token::split<T0>(&mut v0, v3, arg5), arg5);
        let v9 = &mut v8;
        verify<T0>(arg2, v9, arg5);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<T0>(arg2, v8, arg5);
        let v14 = BeesTransferred{
            bees_to_transfer : arg3,
            receipient       : arg4,
            bees_burnt       : v3,
        };
        0x2::event::emit<BeesTransferred>(v14);
    }

    public fun transfer_bees_balance<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: 0x2::balance::Balance<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
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

    public fun unwrap_bee_tokens_to_coins<T0>(arg0: &mut 0x2::token::Token<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::token::split<T0>(arg0, arg3, arg4);
        let v1 = Burn{dummy_field: false};
        let v2 = 0x2::token::to_coin_action();
        let v3 = 0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::math::mul_div_u128((arg3 as u128), (*0x2::vec_map::get<0x1::string::String, u64>(&0x2::token::rule_config<T0, Burn, BurnCondition>(v1, arg2).percent, &v2) as u128), (0xde500cd7b5c7cfb149caaf96c6de16e3d9c25a83b2865566ad83aa7ab0152b23::constants::percent_precision() as u128));
        let (v4, v5) = 0x2::token::to_coin<T0>(v0, arg4);
        let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<T0>(arg1, v5, arg4);
        let v10 = 0x2::token::spend<T0>(0x2::token::split<T0>(&mut v0, v3, arg4), arg4);
        let v11 = &mut v10;
        verify<T0>(arg2, v11, arg4);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<T0>(arg2, v10, arg4);
        let v16 = BeesUnwrappedToCoin{
            bees_to_unwrap : arg3,
            bees_burnt     : v3,
        };
        0x2::event::emit<BeesUnwrappedToCoin>(v16);
        v4
    }

    public fun verify<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::token::has_rule_config<T0, Burn>(arg0)) {
            let v0 = Burn{dummy_field: false};
            0x2::token::add_approval<T0, Burn>(v0, arg1, arg2);
            return
        };
        let v1 = Burn{dummy_field: false};
        let v2 = 0x2::token::rule_config<T0, Burn, BurnCondition>(v1, arg0);
        let v3 = 0x2::token::action<T0>(arg1);
        if (!0x2::vec_map::contains<0x1::string::String, u64>(&v2.percent, &v3)) {
            let v4 = Burn{dummy_field: false};
            0x2::token::add_approval<T0, Burn>(v4, arg1, arg2);
            return
        };
        let v5 = 0x2::token::action<T0>(arg1);
        assert!(*0x2::vec_map::get<0x1::string::String, u64>(&v2.percent, &v5) == 0, 9476);
        let v6 = Burn{dummy_field: false};
        0x2::token::add_approval<T0, Burn>(v6, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

