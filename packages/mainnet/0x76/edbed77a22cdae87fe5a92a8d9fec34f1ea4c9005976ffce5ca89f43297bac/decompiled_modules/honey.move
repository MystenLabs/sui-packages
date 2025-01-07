module 0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::honey {
    struct HONEY has drop {
        dummy_field: bool,
    }

    struct Consumption has drop {
        dummy_field: bool,
    }

    struct ConsumptionCondition has drop, store {
        percent: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct HoneyTransferred has copy, drop {
        honey_to_transfer: u64,
        receipient: address,
        honey_burnt: u64,
    }

    struct HoneyUnwrappedToCoin has copy, drop {
        honey_to_unwrap: u64,
        honey_burnt: u64,
    }

    public fun get_total_honey_Supply() : u64 {
        0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::constants::total_honey_supply()
    }

    fun init(arg0: HONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONEY>(arg0, 6, b"HONEY", b"HONEYs", x"484f4e455920697320746865206865616c746820736f7572636520666f7220647261676f6e2d62656573206e617669676174696e6720746865206d7973746963616c20537569207365617320f09f8c8a20f09f8fb4e2808de298a0efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d1sell8jrx8uwy.cloudfront.net/HoneyLogo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HONEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun set_consumption_pct<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: 0x2::vec_map::VecMap<0x1::string::String, u64>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::token::has_rule_config<T0, Consumption>(arg0)) {
            let v0 = ConsumptionCondition{percent: arg2};
            let v1 = Consumption{dummy_field: false};
            0x2::token::add_rule_config<T0, Consumption, ConsumptionCondition>(v1, arg0, arg1, v0, arg3);
        } else {
            let v2 = Consumption{dummy_field: false};
            0x2::token::rule_config_mut<T0, Consumption, ConsumptionCondition>(v2, arg0, arg1).percent = arg2;
        };
    }

    public fun set_rules<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::constants::honey_burn_pct();
        0x2::token::add_rule_for_action<T0, Consumption>(arg0, arg1, 0x2::token::transfer_action(), arg2);
        0x2::token::add_rule_for_action<T0, Consumption>(arg0, arg1, 0x2::token::spend_action(), arg2);
        0x2::token::add_rule_for_action<T0, Consumption>(arg0, arg1, 0x2::token::to_coin_action(), arg2);
        0x2::token::add_rule_for_action<T0, Consumption>(arg0, arg1, 0x2::token::from_coin_action(), arg2);
        let v1 = 0x2::vec_map::empty<0x1::string::String, u64>();
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v1, 0x2::token::transfer_action(), v0);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v1, 0x2::token::to_coin_action(), v0);
        set_consumption_pct<T0>(arg0, arg1, v1, arg2);
    }

    public fun transfer_honey<T0>(arg0: &mut 0x2::token::Token<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::token::split<T0>(arg0, arg3, arg5);
        let v1 = Consumption{dummy_field: false};
        let v2 = 0x2::token::transfer_action();
        let v3 = 0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::math::mul_div_u128((arg3 as u128), (*0x2::vec_map::get<0x1::string::String, u64>(&0x2::token::rule_config<T0, Consumption, ConsumptionCondition>(v1, arg2).percent, &v2) as u128), (0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::constants::percent_precision() as u128));
        let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<T0>(arg1, 0x2::token::transfer<T0>(v0, arg4, arg5), arg5);
        let v8 = 0x2::token::spend<T0>(0x2::token::split<T0>(&mut v0, v3, arg5), arg5);
        let v9 = &mut v8;
        verify<T0>(arg2, v9, arg5);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<T0>(arg2, v8, arg5);
        if (arg3 > 0) {
            let v14 = HoneyTransferred{
                honey_to_transfer : arg3,
                receipient        : arg4,
                honey_burnt       : v3,
            };
            0x2::event::emit<HoneyTransferred>(v14);
        };
    }

    public fun transfer_honey_balance<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: 0x2::balance::Balance<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::from_coin<T0>(0x2::coin::from_balance<T0>(arg2, arg4), arg4);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v2;
        verify<T0>(arg0, v4, arg4);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg0, v2, arg4);
        let v9 = &mut v3;
        transfer_honey<T0>(v9, arg1, arg0, 0x2::token::value<T0>(&v3), arg3, arg4);
        0x2::token::destroy_zero<T0>(v3);
    }

    public fun unwrap_honey_tokens_to_coins<T0>(arg0: &mut 0x2::token::Token<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::token::split<T0>(arg0, arg3, arg4);
        let v1 = Consumption{dummy_field: false};
        let v2 = 0x2::token::to_coin_action();
        let v3 = 0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::math::mul_div_u128((arg3 as u128), (*0x2::vec_map::get<0x1::string::String, u64>(&0x2::token::rule_config<T0, Consumption, ConsumptionCondition>(v1, arg2).percent, &v2) as u128), (0x76edbed77a22cdae87fe5a92a8d9fec34f1ea4c9005976ffce5ca89f43297bac::constants::percent_precision() as u128));
        let (v4, v5) = 0x2::token::to_coin<T0>(v0, arg4);
        let (_, _, _, _) = 0x2::token::confirm_with_policy_cap<T0>(arg1, v5, arg4);
        let v10 = 0x2::token::spend<T0>(0x2::token::split<T0>(&mut v0, v3, arg4), arg4);
        let v11 = &mut v10;
        verify<T0>(arg2, v11, arg4);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<T0>(arg2, v10, arg4);
        if (arg3 > 0) {
            let v16 = HoneyUnwrappedToCoin{
                honey_to_unwrap : arg3,
                honey_burnt     : v3,
            };
            0x2::event::emit<HoneyUnwrappedToCoin>(v16);
        };
        v4
    }

    public fun verify<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::token::has_rule_config<T0, Consumption>(arg0)) {
            let v0 = Consumption{dummy_field: false};
            0x2::token::add_approval<T0, Consumption>(v0, arg1, arg2);
            return
        };
        let v1 = Consumption{dummy_field: false};
        let v2 = 0x2::token::rule_config<T0, Consumption, ConsumptionCondition>(v1, arg0);
        let v3 = 0x2::token::action<T0>(arg1);
        if (!0x2::vec_map::contains<0x1::string::String, u64>(&v2.percent, &v3)) {
            let v4 = Consumption{dummy_field: false};
            0x2::token::add_approval<T0, Consumption>(v4, arg1, arg2);
            return
        };
        let v5 = 0x2::token::action<T0>(arg1);
        assert!(*0x2::vec_map::get<0x1::string::String, u64>(&v2.percent, &v5) == 0, 9476);
        let v6 = Consumption{dummy_field: false};
        0x2::token::add_approval<T0, Consumption>(v6, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

