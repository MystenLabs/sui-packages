module 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::token_rules {
    struct HoneyTaxRule has drop {
        dummy_field: bool,
    }

    struct ExemptRule has drop {
        dummy_field: bool,
    }

    struct TokenTradeCap has store, key {
        id: 0x2::object::UID,
    }

    struct TokenRules has store, key {
        id: 0x2::object::UID,
        rewards_claim_cap: 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::CreatorRewardsClaimCap,
        token_rules: 0x2::linked_table::LinkedTable<0x1::ascii::String, HoneyTaxConfig>,
        bag: 0x2::bag::Bag,
        module_version: u64,
    }

    struct HoneyTaxConfig has store {
        spend_pct: u64,
        transfer_pct: u64,
        to_coin_pct: u64,
        from_coin_pct: u64,
        buy_pct: u64,
        sell_pct: u64,
        add_liquidity_pct: u64,
        remove_liquidity_pct: u64,
        treasury_pct: u64,
        bag: 0x2::bag::Bag,
        version: u64,
    }

    struct Exemptions has store {
        addresses: 0x2::linked_table::LinkedTable<address, bool>,
    }

    struct HoneyTaxUpdated has copy, drop {
        token_type: 0x1::type_name::TypeName,
        spend_pct: u64,
        transfer_pct: u64,
        to_coin_pct: u64,
        from_coin_pct: u64,
        buy_pct: u64,
        sell_pct: u64,
        add_liquidity_pct: u64,
        remove_liquidity_pct: u64,
        treasury_pct: u64,
    }

    struct ExemptionUpdated has copy, drop {
        token_type: 0x1::type_name::TypeName,
        addr: address,
        added: bool,
    }

    struct HoneyTaxDeleted has copy, drop {
        token_type: 0x1::type_name::TypeName,
    }

    struct TokensTransferred has copy, drop {
        token_type: 0x1::type_name::TypeName,
        transferred_amount: u64,
        total_tax_amount: u64,
        honey_tax_amount: u64,
        admin_tax_amount: u64,
        treasury_tax_amount: u64,
        sender: address,
        recipient: address,
    }

    struct TokenToCoinActioned has copy, drop {
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        total_tax_amount: u64,
        honey_tax_amount: u64,
        admin_tax_amount: u64,
        treasury_tax_amount: u64,
        sender: address,
    }

    struct TokenFromCoinActioned has copy, drop {
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        total_tax_amount: u64,
        honey_tax_amount: u64,
        admin_tax_amount: u64,
        treasury_tax_amount: u64,
        sender: address,
    }

    struct AddLiquidityTaxed has copy, drop {
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        total_tax_amount: u64,
        honey_tax_amount: u64,
        admin_tax_amount: u64,
        treasury_tax_amount: u64,
        sender: address,
    }

    struct RemoveLiquidityTaxed has copy, drop {
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        total_tax_amount: u64,
        honey_tax_amount: u64,
        admin_tax_amount: u64,
        treasury_tax_amount: u64,
        sender: address,
        recipient: address,
    }

    struct SellTokensTaxed has copy, drop {
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        total_tax_amount: u64,
        honey_tax_amount: u64,
        admin_tax_amount: u64,
        treasury_tax_amount: u64,
        sender: address,
    }

    struct BuyTokensTaxed has copy, drop {
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        total_tax_amount: u64,
        honey_tax_amount: u64,
        admin_tax_amount: u64,
        treasury_tax_amount: u64,
        sender: address,
        recipient: address,
    }

    struct SpendTaxed has copy, drop {
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        total_tax_amount: u64,
        honey_tax_amount: u64,
        admin_tax_amount: u64,
        treasury_tax_amount: u64,
        sender: address,
    }

    struct HoneyTaxInfo has drop, store {
        spend_pct: u64,
        from_coin_pct: u64,
        transfer_pct: u64,
        to_coin_pct: u64,
        buy_pct: u64,
        sell_pct: u64,
    }

    public fun claim_creator_rewards<T0>(arg0: &mut TokenRules, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<T0>, arg3: &0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg4: &mut 0x2::token::TokenPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::claim_creator_rewards<T0>(&arg0.rewards_claim_cap, arg1, arg2), arg5);
        let (v1, v2) = from_coin_with_tax<T0>(v0, arg2, arg3, arg4, arg5);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg4, v2, arg5);
        let v7 = 0x2::tx_context::sender(arg5);
        let (v8, v9) = transfer_with_tax<T0>(v1, v7, arg2, arg3, arg4, arg5);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg4, v9, arg5);
        0x2::token::destroy_zero<T0>(v8);
    }

    public fun add_exempt<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::token::has_rule_config<T0, ExemptRule>(arg0)) {
            let v0 = ExemptRule{dummy_field: false};
            let v1 = Exemptions{addresses: 0x2::linked_table::new<address, bool>(arg3)};
            0x2::token::add_rule_config<T0, ExemptRule, Exemptions>(v0, arg0, arg1, v1, arg3);
        };
        let v2 = ExemptRule{dummy_field: false};
        0x2::linked_table::push_back<address, bool>(&mut 0x2::token::rule_config_mut<T0, ExemptRule, Exemptions>(v2, arg0, arg1).addresses, arg2, true);
        let v3 = ExemptionUpdated{
            token_type : 0x1::type_name::with_defining_ids<T0>(),
            addr       : arg2,
            added      : true,
        };
        0x2::event::emit<ExemptionUpdated>(v3);
    }

    public fun add_liquidity_pct<T0>(arg0: &0x2::token::TokenPolicy<T0>) : u64 {
        let (_, _, _, _, _, _, v6, _, _) = get_honey_taxes<T0>(arg0);
        v6
    }

    public fun approve_request<T0>(arg0: &0x2::token::TokenPolicyCap<T0>, arg1: 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::string::String, u64, address, 0x1::option::Option<address>) {
        0x2::token::confirm_with_policy_cap<T0>(arg0, arg1, arg2)
    }

    public fun approve_request_mut<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::string::String, u64, address, 0x1::option::Option<address>) {
        0x2::token::confirm_request<T0>(arg0, arg1, arg2)
    }

    public fun buy_pct<T0>(arg0: &0x2::token::TokenPolicy<T0>) : u64 {
        let (_, _, _, _, v4, _, _, _, _) = get_honey_taxes<T0>(arg0);
        v4
    }

    public fun buy_tokens_with_tax<T0>(arg0: &TokenTradeCap, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<T0>, arg3: &0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg4: &mut 0x2::token::TokenPolicy<T0>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0x2::token::ActionRequest<T0> {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let (v5, v6) = 0x2::token::from_coin<T0>(arg1, arg6);
        let v7 = v6;
        let v8 = v5;
        let v9 = HoneyTaxRule{dummy_field: false};
        0x2::token::add_approval<T0, HoneyTaxRule>(v9, &mut v7, arg6);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg4, v7, arg6);
        let v14 = if (is_exempt<T0>(arg4, v0)) {
            0
        } else {
            buy_pct<T0>(arg4)
        };
        if (v14 > 0) {
            let v15 = 0x2::token::value<T0>(&v8) * v14 / 10000;
            v4 = v15;
            if (v15 > 0) {
                let v16 = 0x2::token::split<T0>(&mut v8, v15, arg6);
                let v17 = &mut v16;
                let (v18, v19, v20) = charge_taxes_on_burn_tax<T0>(arg2, arg3, arg4, v17, treasury_pct<T0>(arg4), arg6);
                v1 = v20;
                v2 = v19;
                v3 = v18;
                let v21 = 0x2::token::spend<T0>(v16, arg6);
                let v22 = HoneyTaxRule{dummy_field: false};
                0x2::token::add_approval<T0, HoneyTaxRule>(v22, &mut v21, arg6);
                let (_, _, _, _) = 0x2::token::confirm_request_mut<T0>(arg4, v21, arg6);
            };
        };
        let v27 = 0x2::token::transfer<T0>(v8, arg5, arg6);
        let v28 = HoneyTaxRule{dummy_field: false};
        0x2::token::add_approval<T0, HoneyTaxRule>(v28, &mut v27, arg6);
        let v29 = BuyTokensTaxed{
            token_type          : 0x1::type_name::with_defining_ids<T0>(),
            amount              : 0x2::coin::value<T0>(&arg1),
            total_tax_amount    : v4,
            honey_tax_amount    : v3,
            admin_tax_amount    : v2,
            treasury_tax_amount : v1,
            sender              : v0,
            recipient           : arg5,
        };
        0x2::event::emit<BuyTokensTaxed>(v29);
        v27
    }

    public fun calculate_add_liquidity_tax_amounts<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg2: u64, arg3: address) : (u64, u64, u64, u64) {
        calculate_tax_amounts<T0>(arg0, arg1, arg2, 6, arg3)
    }

    public fun calculate_buy_tax_amounts<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg2: u64, arg3: address) : (u64, u64, u64, u64) {
        calculate_tax_amounts<T0>(arg0, arg1, arg2, 4, arg3)
    }

    public fun calculate_remove_liquidity_tax_amounts<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg2: u64, arg3: address) : (u64, u64, u64, u64) {
        calculate_tax_amounts<T0>(arg0, arg1, arg2, 7, arg3)
    }

    public fun calculate_sell_tax_amounts<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg2: u64, arg3: address) : (u64, u64, u64, u64) {
        calculate_tax_amounts<T0>(arg0, arg1, arg2, 5, arg3)
    }

    public fun calculate_tax_amounts<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: &0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg2: u64, arg3: u8, arg4: address) : (u64, u64, u64, u64) {
        if (is_exempt<T0>(arg0, arg4)) {
            return (arg2, 0, 0, 0)
        };
        let v0 = if (arg3 == 0) {
            spend_pct<T0>(arg0)
        } else if (arg3 == 1) {
            transfer_pct<T0>(arg0)
        } else if (arg3 == 2) {
            to_coin_pct<T0>(arg0)
        } else if (arg3 == 3) {
            from_coin_pct<T0>(arg0)
        } else if (arg3 == 4) {
            buy_pct<T0>(arg0)
        } else if (arg3 == 5) {
            sell_pct<T0>(arg0)
        } else if (arg3 == 6) {
            add_liquidity_pct<T0>(arg0)
        } else if (arg3 == 7) {
            remove_liquidity_pct<T0>(arg0)
        } else {
            0
        };
        if (v0 == 0) {
            return (arg2, 0, 0, 0)
        };
        let v1 = arg2 * v0 / 10000;
        (arg2 - v1, v1, v1 * 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::get_honey_tax_pct(arg1) / 100, v1 * 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::get_creator_tax_pct<T0>(arg1) / 100)
    }

    fun charge_taxes_on_burn_tax<T0>(arg0: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<T0>, arg1: &0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg2: &0x2::token::TokenPolicy<T0>, arg3: &mut 0x2::token::Token<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 0x2::token::value<T0>(arg3);
        let v1 = 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::get_honey_tax_pct(arg1);
        let v2 = 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::get_creator_tax_pct<T0>(arg1);
        let v3 = if (v1 == 0) {
            if (v2 == 0) {
                arg4 == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v3) {
            return (0, 0, 0)
        };
        let v4 = v0 * v1 / 100;
        let v5 = v0 * v2 / 100;
        let v6 = (v0 - v4 - v5) * arg4 / 100;
        let v7 = 0x2::token::split<T0>(arg3, v4 + v5, arg5);
        if (v4 > 0) {
            let (v8, v9) = 0x2::token::to_coin<T0>(0x2::token::split<T0>(&mut v7, v4, arg5), arg5);
            let v10 = v9;
            let v11 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v11, &mut v10, arg5);
            let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg2, v10, arg5);
            0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::collect_fee_for_coin<T0>(arg0, 0x2::coin::into_balance<T0>(v8));
        };
        if (v5 > 0) {
            let (v16, v17) = 0x2::token::to_coin<T0>(v7, arg5);
            let v18 = v17;
            let v19 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v19, &mut v18, arg5);
            let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg2, v18, arg5);
            0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::add_rewards_for_coin<T0>(arg0, 0x2::coin::into_balance<T0>(v16));
        } else {
            0x2::token::destroy_zero<T0>(v7);
        };
        if (v6 > 0) {
            let (v24, v25) = 0x2::token::to_coin<T0>(0x2::token::split<T0>(arg3, v6, arg5), arg5);
            let v26 = v25;
            let v27 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v27, &mut v26, arg5);
            let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg2, v26, arg5);
            0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::add_treasury_for_coin<T0>(arg0, 0x2::coin::into_balance<T0>(v24));
        };
        (v4, v5, v6)
    }

    public fun delete_honey_tax_config<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::token::has_rule_config<T0, HoneyTaxRule>(arg0)) {
            let v0 = 0x2::token::remove_rule_config<T0, HoneyTaxRule, HoneyTaxConfig>(arg0, arg1, arg2);
            destroy_honey_tax_config(v0, arg2);
        };
        let v1 = HoneyTaxDeleted{token_type: 0x1::type_name::with_defining_ids<T0>()};
        0x2::event::emit<HoneyTaxDeleted>(v1);
    }

    public fun destroy_honey_tax_config(arg0: HoneyTaxConfig, arg1: &mut 0x2::tx_context::TxContext) {
        let HoneyTaxConfig {
            spend_pct            : _,
            transfer_pct         : _,
            to_coin_pct          : _,
            from_coin_pct        : _,
            buy_pct              : _,
            sell_pct             : _,
            add_liquidity_pct    : _,
            remove_liquidity_pct : _,
            treasury_pct         : _,
            bag                  : v9,
            version              : _,
        } = arg0;
        0x2::bag::destroy_empty(v9);
    }

    public fun from_coin_and_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<T0>, arg2: &0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg3: &mut 0x2::token::TokenPolicy<T0>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = from_coin_with_tax<T0>(arg0, arg1, arg2, arg3, arg5);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg3, v1, arg5);
        let v6 = 0x2::token::transfer<T0>(v0, arg4, arg5);
        let v7 = HoneyTaxRule{dummy_field: false};
        0x2::token::add_approval<T0, HoneyTaxRule>(v7, &mut v6, arg5);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg3, v6, arg5);
    }

    public fun from_coin_for_remove_liquidity_with_tax<T0>(arg0: &TokenTradeCap, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<T0>, arg3: &0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg4: &mut 0x2::token::TokenPolicy<T0>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0x2::token::ActionRequest<T0> {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let (v5, v6) = 0x2::token::from_coin<T0>(arg1, arg6);
        let v7 = v6;
        let v8 = v5;
        let v9 = HoneyTaxRule{dummy_field: false};
        0x2::token::add_approval<T0, HoneyTaxRule>(v9, &mut v7, arg6);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg4, v7, arg6);
        let v14 = if (is_exempt<T0>(arg4, v0)) {
            0
        } else {
            remove_liquidity_pct<T0>(arg4)
        };
        if (v14 > 0) {
            let v15 = 0x2::token::value<T0>(&v8) * v14 / 10000;
            v4 = v15;
            if (v15 > 0) {
                let v16 = 0x2::token::split<T0>(&mut v8, v15, arg6);
                let v17 = &mut v16;
                let (v18, v19, v20) = charge_taxes_on_burn_tax<T0>(arg2, arg3, arg4, v17, treasury_pct<T0>(arg4), arg6);
                v1 = v20;
                v2 = v19;
                v3 = v18;
                let v21 = 0x2::token::spend<T0>(v16, arg6);
                let v22 = HoneyTaxRule{dummy_field: false};
                0x2::token::add_approval<T0, HoneyTaxRule>(v22, &mut v21, arg6);
                let (_, _, _, _) = 0x2::token::confirm_request_mut<T0>(arg4, v21, arg6);
            };
        };
        let v27 = 0x2::token::transfer<T0>(v8, arg5, arg6);
        let v28 = HoneyTaxRule{dummy_field: false};
        0x2::token::add_approval<T0, HoneyTaxRule>(v28, &mut v27, arg6);
        let v29 = RemoveLiquidityTaxed{
            token_type          : 0x1::type_name::with_defining_ids<T0>(),
            amount              : 0x2::coin::value<T0>(&arg1),
            total_tax_amount    : v4,
            honey_tax_amount    : v3,
            admin_tax_amount    : v2,
            treasury_tax_amount : v1,
            sender              : v0,
            recipient           : arg5,
        };
        0x2::event::emit<RemoveLiquidityTaxed>(v29);
        v27
    }

    public fun from_coin_pct<T0>(arg0: &0x2::token::TokenPolicy<T0>) : u64 {
        let (_, v1, _, _, _, _, _, _, _) = get_honey_taxes<T0>(arg0);
        v1
    }

    public fun from_coin_with_tax<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<T0>, arg2: &0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg3: &mut 0x2::token::TokenPolicy<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::token::Token<T0>, 0x2::token::ActionRequest<T0>) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg0);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = if (is_exempt<T0>(arg3, v0)) {
            0
        } else {
            from_coin_pct<T0>(arg3)
        };
        let (v7, v8) = if (v6 == 0) {
            let (v9, v10) = 0x2::token::from_coin<T0>(arg0, arg4);
            let v7 = v10;
            let v11 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v11, &mut v7, arg4);
            (v7, v9)
        } else {
            let v12 = v1 * v6 / 10000;
            v5 = v12;
            let v13 = 0x2::coin::into_balance<T0>(arg0);
            let v14 = 0x2::coin::from_balance<T0>(v13, arg4);
            let (v15, v16) = 0x2::token::from_coin<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v13, v12), arg4), arg4);
            let v17 = v16;
            let v18 = v15;
            let v19 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v19, &mut v17, arg4);
            let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg3, v17, arg4);
            let v24 = &mut v18;
            let (v25, v26, v27) = charge_taxes_on_burn_tax<T0>(arg1, arg2, arg3, v24, treasury_pct<T0>(arg3), arg4);
            v2 = v27;
            v3 = v26;
            v4 = v25;
            let v28 = 0x2::token::spend<T0>(v18, arg4);
            let v29 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v29, &mut v28, arg4);
            let (_, _, _, _) = 0x2::token::confirm_request_mut<T0>(arg3, v28, arg4);
            let (v34, v35) = 0x2::token::from_coin<T0>(v14, arg4);
            let v7 = v35;
            let v36 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v36, &mut v7, arg4);
            (v7, v34)
        };
        let v37 = TokenFromCoinActioned{
            token_type          : 0x1::type_name::with_defining_ids<T0>(),
            amount              : v1,
            total_tax_amount    : v5,
            honey_tax_amount    : v4,
            admin_tax_amount    : v3,
            treasury_tax_amount : v2,
            sender              : v0,
        };
        0x2::event::emit<TokenFromCoinActioned>(v37);
        (v8, v7)
    }

    public fun get_all_exempts_paginated<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, u64) {
        if (!0x2::token::has_rule_config<T0, ExemptRule>(arg0)) {
            return (0x1::vector::empty<address>(), 0)
        };
        let v0 = ExemptRule{dummy_field: false};
        let v1 = 0x2::token::rule_config<T0, ExemptRule, Exemptions>(v0, arg0);
        let v2 = 0x1::vector::empty<address>();
        let v3 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, bool>(&v1.addresses)
        };
        let v4 = v3;
        let v5 = 0;
        while (0x1::option::is_some<address>(&v4) && v5 < arg2) {
            let v6 = 0x1::option::borrow<address>(&v4);
            0x1::vector::push_back<address>(&mut v2, *v6);
            v4 = *0x2::linked_table::next<address, bool>(&v1.addresses, *v6);
            v5 = v5 + 1;
        };
        (v2, v5)
    }

    public fun get_honey_tax_config_info<T0>(arg0: &TokenRules) : HoneyTaxInfo {
        if (!0x2::linked_table::contains<0x1::ascii::String, HoneyTaxConfig>(&arg0.token_rules, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))) {
            return HoneyTaxInfo{
                spend_pct     : 0,
                from_coin_pct : 0,
                transfer_pct  : 0,
                to_coin_pct   : 0,
                buy_pct       : 0,
                sell_pct      : 0,
            }
        };
        let v0 = 0x2::linked_table::borrow<0x1::ascii::String, HoneyTaxConfig>(&arg0.token_rules, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        HoneyTaxInfo{
            spend_pct     : v0.spend_pct,
            from_coin_pct : v0.from_coin_pct,
            transfer_pct  : v0.transfer_pct,
            to_coin_pct   : v0.to_coin_pct,
            buy_pct       : v0.buy_pct,
            sell_pct      : v0.sell_pct,
        }
    }

    public fun get_honey_taxes<T0>(arg0: &0x2::token::TokenPolicy<T0>) : (u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        if (0x2::token::has_rule_config<T0, HoneyTaxRule>(arg0)) {
            let v9 = HoneyTaxRule{dummy_field: false};
            let v10 = 0x2::token::rule_config<T0, HoneyTaxRule, HoneyTaxConfig>(v9, arg0);
            (v10.spend_pct, v10.from_coin_pct, v10.transfer_pct, v10.to_coin_pct, v10.buy_pct, v10.sell_pct, v10.add_liquidity_pct, v10.remove_liquidity_pct, v10.treasury_pct)
        } else {
            (0, 0, 0, 0, 0, 0, 0, 0, 0)
        }
    }

    public fun get_honey_taxes_info<T0>(arg0: &0x2::token::TokenPolicy<T0>) : HoneyTaxInfo {
        if (0x2::token::has_rule_config<T0, HoneyTaxRule>(arg0)) {
            let v1 = HoneyTaxRule{dummy_field: false};
            let v2 = 0x2::token::rule_config<T0, HoneyTaxRule, HoneyTaxConfig>(v1, arg0);
            HoneyTaxInfo{spend_pct: v2.spend_pct, from_coin_pct: v2.from_coin_pct, transfer_pct: v2.transfer_pct, to_coin_pct: v2.to_coin_pct, buy_pct: v2.buy_pct, sell_pct: v2.sell_pct}
        } else {
            HoneyTaxInfo{spend_pct: 0, from_coin_pct: 0, transfer_pct: 0, to_coin_pct: 0, buy_pct: 0, sell_pct: 0}
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenTradeCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<TokenTradeCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initialize_token_rules(arg0: 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::CreatorRewardsClaimCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenRules{
            id                : 0x2::object::new(arg1),
            rewards_claim_cap : arg0,
            token_rules       : 0x2::linked_table::new<0x1::ascii::String, HoneyTaxConfig>(arg1),
            bag               : 0x2::bag::new(arg1),
            module_version    : 0,
        };
        0x2::transfer::share_object<TokenRules>(v0);
    }

    public fun is_exempt<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: address) : bool {
        if (!0x2::token::has_rule_config<T0, ExemptRule>(arg0)) {
            return false
        };
        let v0 = ExemptRule{dummy_field: false};
        0x2::linked_table::contains<address, bool>(&0x2::token::rule_config<T0, ExemptRule, Exemptions>(v0, arg0).addresses, arg1)
    }

    public fun new_honey_tax_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : HoneyTaxConfig {
        assert!(arg0 <= 10000, 10001);
        assert!(arg1 <= 10000, 10002);
        assert!(arg2 <= 10000, 10003);
        assert!(arg3 <= 10000, 10004);
        assert!(arg4 <= 10000, 10005);
        assert!(arg5 <= 10000, 10006);
        assert!(arg6 <= 10000, 10007);
        assert!(arg7 <= 10000, 10008);
        assert!(arg8 <= 100, 10011);
        HoneyTaxConfig{
            spend_pct            : arg0,
            transfer_pct         : arg1,
            to_coin_pct          : arg2,
            from_coin_pct        : arg3,
            buy_pct              : arg4,
            sell_pct             : arg5,
            add_liquidity_pct    : arg6,
            remove_liquidity_pct : arg7,
            treasury_pct         : arg8,
            bag                  : 0x2::bag::new(arg9),
            version              : 0,
        }
    }

    public fun remove_exempt<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::token::has_rule_config<T0, ExemptRule>(arg0)) {
            return
        };
        let v0 = ExemptRule{dummy_field: false};
        let v1 = 0x2::token::rule_config_mut<T0, ExemptRule, Exemptions>(v0, arg0, arg1);
        if (0x2::linked_table::contains<address, bool>(&v1.addresses, arg2)) {
            0x2::linked_table::remove<address, bool>(&mut v1.addresses, arg2);
            let v2 = ExemptionUpdated{
                token_type : 0x1::type_name::with_defining_ids<T0>(),
                addr       : arg2,
                added      : false,
            };
            0x2::event::emit<ExemptionUpdated>(v2);
        };
    }

    public fun remove_liquidity_pct<T0>(arg0: &0x2::token::TokenPolicy<T0>) : u64 {
        let (_, _, _, _, _, _, _, v7, _) = get_honey_taxes<T0>(arg0);
        v7
    }

    public fun sell_pct<T0>(arg0: &0x2::token::TokenPolicy<T0>) : u64 {
        let (_, _, _, _, _, v5, _, _, _) = get_honey_taxes<T0>(arg0);
        v5
    }

    public fun sell_tokens_with_tax<T0>(arg0: &TokenTradeCap, arg1: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<T0>, arg2: &0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg3: 0x2::token::Token<T0>, arg4: &mut 0x2::token::TokenPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::token::ActionRequest<T0>) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::token::value<T0>(&arg3);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = if (is_exempt<T0>(arg4, v0)) {
            0
        } else {
            sell_pct<T0>(arg4)
        };
        let (v7, v8) = if (v6 == 0) {
            let (v9, v10) = 0x2::token::to_coin<T0>(arg3, arg5);
            let v8 = v10;
            let v11 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v11, &mut v8, arg5);
            (v9, v8)
        } else {
            let v12 = v1 * v6 / 10000;
            v5 = v12;
            let v13 = 0x2::token::split<T0>(&mut arg3, v12, arg5);
            let v14 = &mut v13;
            let (v15, v16, v17) = charge_taxes_on_burn_tax<T0>(arg1, arg2, arg4, v14, treasury_pct<T0>(arg4), arg5);
            v2 = v17;
            v3 = v16;
            v4 = v15;
            let v18 = 0x2::token::spend<T0>(v13, arg5);
            let v19 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v19, &mut v18, arg5);
            let (_, _, _, _) = 0x2::token::confirm_request_mut<T0>(arg4, v18, arg5);
            let (v24, v25) = 0x2::token::to_coin<T0>(arg3, arg5);
            let v8 = v25;
            let v26 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v26, &mut v8, arg5);
            (v24, v8)
        };
        let v27 = SellTokensTaxed{
            token_type          : 0x1::type_name::with_defining_ids<T0>(),
            amount              : v1,
            total_tax_amount    : v5,
            honey_tax_amount    : v4,
            admin_tax_amount    : v3,
            treasury_tax_amount : v2,
            sender              : v0,
        };
        0x2::event::emit<SellTokensTaxed>(v27);
        (v7, v8)
    }

    public fun set_token_taxes<T0>(arg0: &0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::TwoAmmAccess, arg1: &mut TokenRules, arg2: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg3: &mut 0x2::token::TokenPolicy<T0>, arg4: &0x2::token::TokenPolicyCap<T0>, arg5: HoneyTaxConfig, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::token::has_rule_config<T0, HoneyTaxRule>(arg3), 10009);
        let v0 = HoneyTaxUpdated{
            token_type           : 0x1::type_name::with_defining_ids<T0>(),
            spend_pct            : arg5.spend_pct,
            transfer_pct         : arg5.transfer_pct,
            to_coin_pct          : arg5.to_coin_pct,
            from_coin_pct        : arg5.from_coin_pct,
            buy_pct              : arg5.buy_pct,
            sell_pct             : arg5.sell_pct,
            add_liquidity_pct    : arg5.add_liquidity_pct,
            remove_liquidity_pct : arg5.remove_liquidity_pct,
            treasury_pct         : arg5.treasury_pct,
        };
        0x2::event::emit<HoneyTaxUpdated>(v0);
        let v1 = HoneyTaxConfig{
            spend_pct            : arg5.spend_pct,
            transfer_pct         : arg5.transfer_pct,
            to_coin_pct          : arg5.to_coin_pct,
            from_coin_pct        : arg5.from_coin_pct,
            buy_pct              : arg5.buy_pct,
            sell_pct             : arg5.sell_pct,
            add_liquidity_pct    : arg5.add_liquidity_pct,
            remove_liquidity_pct : arg5.remove_liquidity_pct,
            treasury_pct         : arg5.treasury_pct,
            bag                  : 0x2::bag::new(arg7),
            version              : arg5.version,
        };
        let v2 = HoneyTaxRule{dummy_field: false};
        0x2::token::add_rule_config<T0, HoneyTaxRule, HoneyTaxConfig>(v2, arg3, arg4, arg5, arg7);
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::create_fee_collector<T0>(arg0, arg2, arg7);
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::set_creator_tax_pct_for_token<T0>(arg2, arg4, arg6);
        0x2::linked_table::push_back<0x1::ascii::String, HoneyTaxConfig>(&mut arg1.token_rules, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), v1);
        0x2::token::add_rule_for_action<T0, HoneyTaxRule>(arg3, arg4, 0x2::token::transfer_action(), arg7);
        0x2::token::add_rule_for_action<T0, HoneyTaxRule>(arg3, arg4, 0x2::token::spend_action(), arg7);
        0x2::token::add_rule_for_action<T0, HoneyTaxRule>(arg3, arg4, 0x2::token::to_coin_action(), arg7);
        0x2::token::add_rule_for_action<T0, HoneyTaxRule>(arg3, arg4, 0x2::token::from_coin_action(), arg7);
    }

    public fun spend_pct<T0>(arg0: &0x2::token::TokenPolicy<T0>) : u64 {
        let (v0, _, _, _, _, _, _, _, _) = get_honey_taxes<T0>(arg0);
        v0
    }

    public fun spend_with_tax<T0>(arg0: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<T0>, arg1: &0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg2: 0x2::token::Token<T0>, arg3: &mut 0x2::token::TokenPolicy<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::token::ActionRequest<T0> {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::token::value<T0>(&arg2);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = if (is_exempt<T0>(arg3, v0)) {
            0
        } else {
            spend_pct<T0>(arg3)
        };
        let v7 = if (v6 == 0) {
            let v7 = 0x2::token::spend<T0>(arg2, arg4);
            let v8 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v8, &mut v7, arg4);
            v7
        } else {
            v5 = v1 * v6 / 10000;
            let v9 = &mut arg2;
            let (v10, v11, v12) = charge_taxes_on_burn_tax<T0>(arg0, arg1, arg3, v9, treasury_pct<T0>(arg3), arg4);
            v2 = v12;
            v3 = v11;
            v4 = v10;
            let v7 = 0x2::token::spend<T0>(arg2, arg4);
            let v13 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v13, &mut v7, arg4);
            v7
        };
        let v14 = SpendTaxed{
            token_type          : 0x1::type_name::with_defining_ids<T0>(),
            amount              : v1,
            total_tax_amount    : v5,
            honey_tax_amount    : v4,
            admin_tax_amount    : v3,
            treasury_tax_amount : v2,
            sender              : v0,
        };
        0x2::event::emit<SpendTaxed>(v14);
        v7
    }

    public fun to_coin_for_add_liquidity_with_tax<T0>(arg0: &TokenTradeCap, arg1: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<T0>, arg2: &0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg3: 0x2::token::Token<T0>, arg4: &mut 0x2::token::TokenPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::token::ActionRequest<T0>) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::token::value<T0>(&arg3);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = if (is_exempt<T0>(arg4, v0)) {
            0
        } else {
            add_liquidity_pct<T0>(arg4)
        };
        let (v7, v8) = if (v6 == 0) {
            let (v9, v10) = 0x2::token::to_coin<T0>(arg3, arg5);
            let v8 = v10;
            let v11 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v11, &mut v8, arg5);
            (v9, v8)
        } else {
            let v12 = v1 * v6 / 10000;
            v5 = v12;
            let v13 = 0x2::token::split<T0>(&mut arg3, v12, arg5);
            let v14 = &mut v13;
            let (v15, v16, v17) = charge_taxes_on_burn_tax<T0>(arg1, arg2, arg4, v14, treasury_pct<T0>(arg4), arg5);
            v2 = v17;
            v3 = v16;
            v4 = v15;
            let v18 = 0x2::token::spend<T0>(v13, arg5);
            let v19 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v19, &mut v18, arg5);
            let (_, _, _, _) = 0x2::token::confirm_request_mut<T0>(arg4, v18, arg5);
            let (v24, v25) = 0x2::token::to_coin<T0>(arg3, arg5);
            let v8 = v25;
            let v26 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v26, &mut v8, arg5);
            (v24, v8)
        };
        let v27 = AddLiquidityTaxed{
            token_type          : 0x1::type_name::with_defining_ids<T0>(),
            amount              : v1,
            total_tax_amount    : v5,
            honey_tax_amount    : v4,
            admin_tax_amount    : v3,
            treasury_tax_amount : v2,
            sender              : v0,
        };
        0x2::event::emit<AddLiquidityTaxed>(v27);
        (v7, v8)
    }

    public fun to_coin_pct<T0>(arg0: &0x2::token::TokenPolicy<T0>) : u64 {
        let (_, _, _, v3, _, _, _, _, _) = get_honey_taxes<T0>(arg0);
        v3
    }

    public fun to_coin_with_tax<T0>(arg0: 0x2::token::Token<T0>, arg1: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<T0>, arg2: &0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg3: &mut 0x2::token::TokenPolicy<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::token::ActionRequest<T0>) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::token::value<T0>(&arg0);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = if (is_exempt<T0>(arg3, v0)) {
            0
        } else {
            to_coin_pct<T0>(arg3)
        };
        let (v7, v8) = if (v6 == 0) {
            let (v9, v10) = 0x2::token::to_coin<T0>(arg0, arg4);
            let v8 = v10;
            let v11 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v11, &mut v8, arg4);
            (v9, v8)
        } else {
            let v12 = v1 * v6 / 10000;
            v5 = v12;
            let v13 = 0x2::token::split<T0>(&mut arg0, v12, arg4);
            let v14 = &mut v13;
            let (v15, v16, v17) = charge_taxes_on_burn_tax<T0>(arg1, arg2, arg3, v14, treasury_pct<T0>(arg3), arg4);
            v2 = v17;
            v3 = v16;
            v4 = v15;
            let v18 = 0x2::token::spend<T0>(v13, arg4);
            let v19 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v19, &mut v18, arg4);
            let (_, _, _, _) = 0x2::token::confirm_request_mut<T0>(arg3, v18, arg4);
            let (v24, v25) = 0x2::token::to_coin<T0>(arg0, arg4);
            let v8 = v25;
            let v26 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v26, &mut v8, arg4);
            (v24, v8)
        };
        let v27 = TokenToCoinActioned{
            token_type          : 0x1::type_name::with_defining_ids<T0>(),
            amount              : v1,
            total_tax_amount    : v5,
            honey_tax_amount    : v4,
            admin_tax_amount    : v3,
            treasury_tax_amount : v2,
            sender              : v0,
        };
        0x2::event::emit<TokenToCoinActioned>(v27);
        (v7, v8)
    }

    public fun transfer_pct<T0>(arg0: &0x2::token::TokenPolicy<T0>) : u64 {
        let (_, _, v2, _, _, _, _, _, _) = get_honey_taxes<T0>(arg0);
        v2
    }

    public fun transfer_with_tax<T0>(arg0: 0x2::token::Token<T0>, arg1: address, arg2: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<T0>, arg3: &0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg4: &mut 0x2::token::TokenPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::token::Token<T0>, 0x2::token::ActionRequest<T0>) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::token::value<T0>(&arg0);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x2::token::zero<T0>(arg5);
        let v7 = if (is_exempt<T0>(arg4, v0) || is_exempt<T0>(arg4, arg1)) {
            0
        } else {
            transfer_pct<T0>(arg4)
        };
        let v8 = if (v7 == 0) {
            let v8 = 0x2::token::transfer<T0>(arg0, arg1, arg5);
            let v9 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v9, &mut v8, arg5);
            v8
        } else {
            let v10 = v1 * v7 / 10000;
            v5 = v10;
            let v11 = 0x2::token::split<T0>(&mut arg0, v10, arg5);
            let v12 = &mut v11;
            let (v13, v14, v15) = charge_taxes_on_burn_tax<T0>(arg2, arg3, arg4, v12, treasury_pct<T0>(arg4), arg5);
            v2 = v15;
            v3 = v14;
            v4 = v13;
            let v16 = 0x2::token::spend<T0>(v11, arg5);
            let v17 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v17, &mut v16, arg5);
            let (_, _, _, _) = 0x2::token::confirm_request_mut<T0>(arg4, v16, arg5);
            let v8 = 0x2::token::transfer<T0>(arg0, arg1, arg5);
            let v22 = HoneyTaxRule{dummy_field: false};
            0x2::token::add_approval<T0, HoneyTaxRule>(v22, &mut v8, arg5);
            v8
        };
        let v23 = TokensTransferred{
            token_type          : 0x1::type_name::with_defining_ids<T0>(),
            transferred_amount  : v1,
            total_tax_amount    : v5,
            honey_tax_amount    : v4,
            admin_tax_amount    : v3,
            treasury_tax_amount : v2,
            sender              : v0,
            recipient           : arg1,
        };
        0x2::event::emit<TokensTransferred>(v23);
        (v6, v8)
    }

    public fun transfer_without_tax<T0>(arg0: &TokenTradeCap, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::token::ActionRequest<T0> {
        let (v0, v1) = 0x2::token::from_coin<T0>(arg2, arg4);
        let v2 = v1;
        let v3 = HoneyTaxRule{dummy_field: false};
        0x2::token::add_approval<T0, HoneyTaxRule>(v3, &mut v2, arg4);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg1, v2, arg4);
        let v8 = 0x2::token::transfer<T0>(v0, arg3, arg4);
        let v9 = HoneyTaxRule{dummy_field: false};
        0x2::token::add_approval<T0, HoneyTaxRule>(v9, &mut v8, arg4);
        let v10 = TokensTransferred{
            token_type          : 0x1::type_name::with_defining_ids<T0>(),
            transferred_amount  : 0x2::coin::value<T0>(&arg2),
            total_tax_amount    : 0,
            honey_tax_amount    : 0,
            admin_tax_amount    : 0,
            treasury_tax_amount : 0,
            sender              : 0x2::tx_context::sender(arg4),
            recipient           : arg3,
        };
        0x2::event::emit<TokensTransferred>(v10);
        v8
    }

    public fun treasury_pct<T0>(arg0: &0x2::token::TokenPolicy<T0>) : u64 {
        let (_, _, _, _, _, _, _, _, v8) = get_honey_taxes<T0>(arg0);
        v8
    }

    public fun update_honey_tax_config_version<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>) {
        assert!(0x2::token::has_rule_config<T0, HoneyTaxRule>(arg0), 10010);
        let v0 = HoneyTaxRule{dummy_field: false};
        0x2::token::rule_config_mut<T0, HoneyTaxRule, HoneyTaxConfig>(v0, arg0, arg1).version = 0;
    }

    public fun update_honey_taxes<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &mut TokenRules, arg2: &0x2::token::TokenPolicyCap<T0>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<u64>) {
        assert!(0x2::token::has_rule_config<T0, HoneyTaxRule>(arg0), 10010);
        let v0 = HoneyTaxRule{dummy_field: false};
        let v1 = 0x2::token::rule_config_mut<T0, HoneyTaxRule, HoneyTaxConfig>(v0, arg0, arg2);
        if (0x1::option::is_some<u64>(&arg3)) {
            assert!(*0x1::option::borrow<u64>(&arg3) <= 10000, 10001);
            v1.spend_pct = *0x1::option::borrow<u64>(&arg3);
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            assert!(*0x1::option::borrow<u64>(&arg4) <= 10000, 10004);
            v1.from_coin_pct = *0x1::option::borrow<u64>(&arg4);
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            assert!(*0x1::option::borrow<u64>(&arg5) <= 10000, 10002);
            v1.transfer_pct = *0x1::option::borrow<u64>(&arg5);
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            assert!(*0x1::option::borrow<u64>(&arg6) <= 10000, 10003);
            v1.to_coin_pct = *0x1::option::borrow<u64>(&arg6);
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            assert!(*0x1::option::borrow<u64>(&arg7) <= 10000, 10005);
            v1.buy_pct = *0x1::option::borrow<u64>(&arg7);
        };
        if (0x1::option::is_some<u64>(&arg8)) {
            assert!(*0x1::option::borrow<u64>(&arg8) <= 10000, 10006);
            v1.sell_pct = *0x1::option::borrow<u64>(&arg8);
        };
        if (0x1::option::is_some<u64>(&arg9)) {
            assert!(*0x1::option::borrow<u64>(&arg9) <= 10000, 10007);
            v1.add_liquidity_pct = *0x1::option::borrow<u64>(&arg9);
        };
        if (0x1::option::is_some<u64>(&arg10)) {
            assert!(*0x1::option::borrow<u64>(&arg10) <= 10000, 10008);
            v1.remove_liquidity_pct = *0x1::option::borrow<u64>(&arg10);
        };
        if (0x1::option::is_some<u64>(&arg11)) {
            assert!(*0x1::option::borrow<u64>(&arg11) <= 100, 10011);
            v1.treasury_pct = *0x1::option::borrow<u64>(&arg11);
        };
        let v2 = 0x2::linked_table::remove<0x1::ascii::String, HoneyTaxConfig>(&mut arg1.token_rules, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        v2.spend_pct = v1.spend_pct;
        v2.from_coin_pct = v1.from_coin_pct;
        v2.transfer_pct = v1.transfer_pct;
        v2.to_coin_pct = v1.to_coin_pct;
        v2.buy_pct = v1.buy_pct;
        v2.sell_pct = v1.sell_pct;
        v2.add_liquidity_pct = v1.add_liquidity_pct;
        v2.remove_liquidity_pct = v1.remove_liquidity_pct;
        v2.treasury_pct = v1.treasury_pct;
        0x2::linked_table::push_back<0x1::ascii::String, HoneyTaxConfig>(&mut arg1.token_rules, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), v2);
        let v3 = HoneyTaxUpdated{
            token_type           : 0x1::type_name::with_defining_ids<T0>(),
            spend_pct            : v1.spend_pct,
            transfer_pct         : v1.transfer_pct,
            to_coin_pct          : v1.to_coin_pct,
            from_coin_pct        : v1.from_coin_pct,
            buy_pct              : v1.buy_pct,
            sell_pct             : v1.sell_pct,
            add_liquidity_pct    : v1.add_liquidity_pct,
            remove_liquidity_pct : v1.remove_liquidity_pct,
            treasury_pct         : v1.treasury_pct,
        };
        0x2::event::emit<HoneyTaxUpdated>(v3);
    }

    // decompiled from Move bytecode v6
}

