module 0x3896655da6b2a5fe67352b7f5332ce18442da975e1a9d7289d4888ec0af9a143::bee {
    struct BEE has drop {
        dummy_field: bool,
    }

    struct Burn has drop {
        dummy_field: bool,
    }

    struct BurnCondition has drop, store {
        percent: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct BeeCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        bee_kraft_cap: 0x2::coin::TreasuryCap<T0>,
        policy_cap: 0x2::token::TokenPolicyCap<T0>,
        is_genesis_supply_krafted: bool,
    }

    public fun bees_tokens_to_coin<T0>(arg0: &mut 0x2::token::Token<T0>, arg1: &BeeCap<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::token::split<T0>(arg0, arg3, arg4);
        let v1 = Burn{dummy_field: false};
        let v2 = 0x2::token::to_coin_action();
        let (v3, v4) = 0x2::token::to_coin<T0>(v0, arg4);
        let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<T0>(&arg1.policy_cap, v4, arg4);
        let v9 = 0x2::token::spend<T0>(0x2::token::split<T0>(&mut v0, 0x774b18f5c66b34ec2592e7c12ad2b8911eeb86d801cc6086e6d8b20c64d202d6::math::mul_div_u128((arg3 as u128), (*0x2::vec_map::get<0x1::string::String, u64>(&0x2::token::rule_config<T0, Burn, BurnCondition>(v1, arg2).percent, &v2) as u128), (100 as u128)), arg4), arg4);
        let v10 = &mut v9;
        verify<T0>(arg2, v10, arg4);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<T0>(arg2, v9, arg4);
        v3
    }

    public fun burn_bees_from_supply<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &mut BeeCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::token::flush<T0>(arg0, &mut arg1.bee_kraft_cap, arg2);
        0x2::token::spent_balance<T0>(arg0)
    }

    public fun get_total_bee_Supply() : u64 {
        420000000000000000
    }

    fun init(arg0: BEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEE>(arg0, 6, b"BEE", b"BEEs", b"Engagement drops farmed per epoch via Hive-Chronicles.`", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://degenhive.ai/assets/bee_logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEE>>(v1);
        let (v3, v4) = 0x2::token::new_policy<BEE>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        let v7 = &mut v6;
        set_rules<BEE>(v7, &v5, arg1);
        0x2::token::share_policy<BEE>(v6);
        let v8 = BeeCap<BEE>{
            id                        : 0x2::object::new(arg1),
            bee_kraft_cap             : v2,
            policy_cap                : v5,
            is_genesis_supply_krafted : false,
        };
        0x2::transfer::share_object<BeeCap<BEE>>(v8);
    }

    public(friend) fun kraft_genesis_supply(arg0: &mut BeeCap<BEE>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<BEE> {
        assert!(!arg0.is_genesis_supply_krafted, 9475);
        arg0.is_genesis_supply_krafted = true;
        0x2::coin::into_balance<BEE>(0x2::coin::mint<BEE>(&mut arg0.bee_kraft_cap, 420000000000000000, arg1))
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

    fun set_rules<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::token::add_rule_for_action<T0, Burn>(arg0, arg1, 0x2::token::transfer_action(), arg2);
        0x2::token::add_rule_for_action<T0, Burn>(arg0, arg1, 0x2::token::spend_action(), arg2);
        0x2::token::add_rule_for_action<T0, Burn>(arg0, arg1, 0x2::token::to_coin_action(), arg2);
        0x2::token::add_rule_for_action<T0, Burn>(arg0, arg1, 0x2::token::from_coin_action(), arg2);
        let v0 = 0x2::vec_map::empty<0x1::string::String, u64>();
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x2::token::transfer_action(), 3);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x2::token::to_coin_action(), 3);
        set_burn_percent<T0>(arg0, arg1, v0, arg2);
    }

    public fun transfer_bees<T0>(arg0: &mut 0x2::token::Token<T0>, arg1: &BeeCap<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::token::split<T0>(arg0, arg3, arg5);
        let v1 = Burn{dummy_field: false};
        let v2 = 0x2::token::transfer_action();
        let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<T0>(&arg1.policy_cap, 0x2::token::transfer<T0>(v0, arg4, arg5), arg5);
        let v7 = 0x2::token::spend<T0>(0x2::token::split<T0>(&mut v0, 0x774b18f5c66b34ec2592e7c12ad2b8911eeb86d801cc6086e6d8b20c64d202d6::math::mul_div_u128((arg3 as u128), (*0x2::vec_map::get<0x1::string::String, u64>(&0x2::token::rule_config<T0, Burn, BurnCondition>(v1, arg2).percent, &v2) as u128), (100 as u128)), arg5), arg5);
        let v8 = &mut v7;
        verify<T0>(arg2, v8, arg5);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<T0>(arg2, v7, arg5);
    }

    public fun transfer_bees_to_recepient<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &BeeCap<T0>, arg2: 0x2::balance::Balance<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
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

