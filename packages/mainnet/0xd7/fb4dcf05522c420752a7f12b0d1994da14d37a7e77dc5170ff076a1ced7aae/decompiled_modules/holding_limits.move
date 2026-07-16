module 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::holding_limits {
    struct HoldingLimits has drop, store {
        min_holdings_per_investor: u64,
        max_holdings_per_investor: u64,
        region_min_tokens: 0x2::vec_map::VecMap<u64, u64>,
    }

    public fun max_holdings(arg0: &HoldingLimits) : u64 {
        arg0.max_holdings_per_investor
    }

    public fun min_holdings(arg0: &HoldingLimits) : u64 {
        arg0.min_holdings_per_investor
    }

    public fun new<T0>(arg0: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg1: u64, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg6: &0x2::tx_context::TxContext) : 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::rule_wrapper::RuleInitWrapper<T0, HoldingLimits> {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg5);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::RegisterRule>(arg0, 0x2::tx_context::sender(arg6)), 13835902742205825033);
        let v0 = 0x2::vec_map::empty<u64, u64>();
        0x1::vector::reverse<u64>(&mut arg4);
        assert!(0x1::vector::length<u64>(&arg3) == 0x1::vector::length<u64>(&arg4), 13906834453516255231);
        0x1::vector::reverse<u64>(&mut arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg3)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg3);
            let v3 = 0x1::vector::pop_back<u64>(&mut arg4);
            0x2::vec_map::insert<u64, u64>(&mut v0, v2, v3);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_string_to_uint_map_rule_set_event<T0>(0x1::string::utf8(b"regionMinTokens"), 0x1::u64::to_string(v2), 0, v3);
            if (v2 == 1) {
                0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"minUSTokens"), 0, v3);
            } else if (v2 == 2) {
                0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"minEUTokens"), 0, v3);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg3);
        0x1::vector::destroy_empty<u64>(arg4);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"minimumHoldingsPerInvestor"), 0, arg1);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"maximumHoldingsPerInvestor"), 0, arg2);
        let v4 = HoldingLimits{
            min_holdings_per_investor : arg1,
            max_holdings_per_investor : arg2,
            region_min_tokens         : v0,
        };
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::rule_wrapper::new_init<T0, HoldingLimits>(v4)
    }

    public fun region_min_holdings(arg0: &HoldingLimits, arg1: u64) : u64 {
        assert!(0x2::vec_map::contains<u64, u64>(&arg0.region_min_tokens, &arg1), 13835622263661395975);
        *0x2::vec_map::get<u64, u64>(&arg0.region_min_tokens, &arg1)
    }

    public fun remove_region_min_holdings<T0>(arg0: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg1: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::rule_wrapper::RuleUpdateWrapper<T0, HoldingLimits>, arg2: u64, arg3: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg3);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13835903296256606217);
        let v0 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::rule_wrapper::borrow_update_mut<T0, HoldingLimits>(arg1);
        if (0x2::vec_map::contains<u64, u64>(&v0.region_min_tokens, &arg2)) {
            let (_, v2) = 0x2::vec_map::remove<u64, u64>(&mut v0.region_min_tokens, &arg2);
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_string_to_uint_map_rule_set_event<T0>(0x1::string::utf8(b"regionMinTokens"), 0x1::u64::to_string(arg2), v2, 0);
            if (arg2 == 1) {
                0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"minUSTokens"), v2, 0);
            } else if (arg2 == 2) {
                0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"minEUTokens"), v2, 0);
            };
        };
    }

    public fun set_max_holdings<T0>(arg0: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg1: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::rule_wrapper::RuleUpdateWrapper<T0, HoldingLimits>, arg2: u64, arg3: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg3);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13835903047148503049);
        let v0 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::rule_wrapper::borrow_update_mut<T0, HoldingLimits>(arg1);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"maximumHoldingsPerInvestor"), v0.max_holdings_per_investor, arg2);
        v0.max_holdings_per_investor = arg2;
    }

    public fun set_min_holdings<T0>(arg0: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg1: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::rule_wrapper::RuleUpdateWrapper<T0, HoldingLimits>, arg2: u64, arg3: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg3);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13835902952659222537);
        let v0 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::rule_wrapper::borrow_update_mut<T0, HoldingLimits>(arg1);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"minimumHoldingsPerInvestor"), v0.min_holdings_per_investor, arg2);
        v0.min_holdings_per_investor = arg2;
    }

    public fun set_region_min_holdings<T0>(arg0: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg1: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::rule_wrapper::RuleUpdateWrapper<T0, HoldingLimits>, arg2: u64, arg3: u64, arg4: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg5: &0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg4);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg5)), 13835903145932750857);
        let v0 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::rule_wrapper::borrow_update_mut<T0, HoldingLimits>(arg1);
        let v1 = if (0x2::vec_map::contains<u64, u64>(&v0.region_min_tokens, &arg2)) {
            let (_, v3) = 0x2::vec_map::remove<u64, u64>(&mut v0.region_min_tokens, &arg2);
            v3
        } else {
            0
        };
        0x2::vec_map::insert<u64, u64>(&mut v0.region_min_tokens, arg2, arg3);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_string_to_uint_map_rule_set_event<T0>(0x1::string::utf8(b"regionMinTokens"), 0x1::u64::to_string(arg2), v1, arg3);
        if (arg2 == 1) {
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"minUSTokens"), v1, arg3);
        } else if (arg2 == 2) {
            0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"minEUTokens"), v1, arg3);
        };
    }

    public fun validate_holding_limits_for_issuance(arg0: &HoldingLimits, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = 0x1::u256::try_as_u64((arg2 as u256) + (arg1 as u256));
        assert!(0x1::option::is_some<u64>(&v0), 13836185247974817803);
        let v1 = 0x1::option::extract<u64>(&mut v0);
        validate_min_holdings(arg0, v1, arg3);
        validate_max_holdings(arg0, v1);
    }

    public fun validate_holding_limits_for_transfer(arg0: &HoldingLimits, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        if (!arg2) {
            let v0 = arg3 - arg1;
            if (v0 > 0) {
                validate_min_holdings(arg0, v0, arg4);
            };
        };
        let v1 = 0x1::u256::try_as_u64((arg5 as u256) + (arg1 as u256));
        assert!(0x1::option::is_some<u64>(&v1), 13836185247974817803);
        let v2 = 0x1::option::extract<u64>(&mut v1);
        validate_min_holdings(arg0, v2, arg6);
        validate_max_holdings(arg0, v2);
    }

    public fun validate_max_holdings(arg0: &HoldingLimits, arg1: u64) {
        if (arg0.max_holdings_per_investor > 0) {
            assert!(arg1 < arg0.max_holdings_per_investor, 13835340698490241029);
        };
    }

    public fun validate_min_holdings(arg0: &HoldingLimits, arg1: u64, arg2: u64) {
        if (arg0.min_holdings_per_investor > 0) {
            assert!(arg1 >= arg0.min_holdings_per_investor, 13835059154793922563);
        };
        if (0x2::vec_map::contains<u64, u64>(&arg0.region_min_tokens, &arg2)) {
            assert!(arg1 >= *0x2::vec_map::get<u64, u64>(&arg0.region_min_tokens, &arg2), 13835059180563726339);
        };
    }

    // decompiled from Move bytecode v7
}

