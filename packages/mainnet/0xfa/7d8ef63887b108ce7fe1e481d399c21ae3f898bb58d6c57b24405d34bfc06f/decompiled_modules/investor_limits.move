module 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::investor_limits {
    struct InvestorLimits has drop, store {
        total_investors_limit: u64,
        minimum_total_investors: u64,
        us_investors_limit: u64,
        us_accredited_limit: u64,
        non_accredited_limit: u64,
        jp_investors_limit: u64,
        eu_retail_limit: u64,
        max_us_percentage: u64,
    }

    public fun effective_us_limit(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return arg0
        };
        let v0 = (((arg2 as u128) * (arg1 as u128) / 100) as u64);
        if (arg0 == 0) {
            return v0
        };
        if (arg0 < v0) {
            arg0
        } else {
            v0
        }
    }

    public fun eu_retail_limit(arg0: &InvestorLimits) : u64 {
        arg0.eu_retail_limit
    }

    public fun jp_limit(arg0: &InvestorLimits) : u64 {
        arg0.jp_investors_limit
    }

    public fun max_us_percentage(arg0: &InvestorLimits) : u64 {
        arg0.max_us_percentage
    }

    public fun minimum_total_investors(arg0: &InvestorLimits) : u64 {
        arg0.minimum_total_investors
    }

    public fun new<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg10: &0x2::tx_context::TxContext) : 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::RuleInitWrapper<T0, InvestorLimits> {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg9);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::RegisterRule>(arg0, 0x2::tx_context::sender(arg10)), 13837028740897308687);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"totalInvestorsLimit"), 0, arg1);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"minimumTotalInvestors"), 0, arg2);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"usInvestorsLimit"), 0, arg3);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"usAccreditedInvestorsLimit"), 0, arg4);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"nonAccreditedInvestorsLimit"), 0, arg5);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"jpInvestorsLimit"), 0, arg6);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"euRetailInvestorsLimit"), 0, arg7);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"maxUSInvestorsPercentage"), 0, arg8);
        let v0 = InvestorLimits{
            total_investors_limit   : arg1,
            minimum_total_investors : arg2,
            us_investors_limit      : arg3,
            us_accredited_limit     : arg4,
            non_accredited_limit    : arg5,
            jp_investors_limit      : arg6,
            eu_retail_limit         : arg7,
            max_us_percentage       : arg8,
        };
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::new_init<T0, InvestorLimits>(v0)
    }

    public fun non_accredited_limit(arg0: &InvestorLimits) : u64 {
        arg0.non_accredited_limit
    }

    public fun set_eu_retail_limit<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::RuleUpdateWrapper<T0, InvestorLimits>, arg2: u64, arg3: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg3);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13837029445271945231);
        let v0 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::borrow_update_mut<T0, InvestorLimits>(arg1);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"euRetailInvestorsLimit"), v0.eu_retail_limit, arg2);
        v0.eu_retail_limit = arg2;
    }

    public fun set_jp_limit<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::RuleUpdateWrapper<T0, InvestorLimits>, arg2: u64, arg3: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg3);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13837029367962533903);
        let v0 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::borrow_update_mut<T0, InvestorLimits>(arg1);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"jpInvestorsLimit"), v0.jp_investors_limit, arg2);
        v0.jp_investors_limit = arg2;
    }

    public fun set_max_us_percentage<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::RuleUpdateWrapper<T0, InvestorLimits>, arg2: u64, arg3: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg3);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13837029522581356559);
        let v0 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::borrow_update_mut<T0, InvestorLimits>(arg1);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"maxUSInvestorsPercentage"), v0.max_us_percentage, arg2);
        v0.max_us_percentage = arg2;
    }

    public fun set_minimum_total_investors<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::RuleUpdateWrapper<T0, InvestorLimits>, arg2: u64, arg3: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg3);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13837029007185281039);
        let v0 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::borrow_update_mut<T0, InvestorLimits>(arg1);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"minimumTotalInvestors"), v0.minimum_total_investors, arg2);
        v0.minimum_total_investors = arg2;
    }

    public fun set_non_accredited_limit<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::RuleUpdateWrapper<T0, InvestorLimits>, arg2: u64, arg3: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg3);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13837029273473253391);
        let v0 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::borrow_update_mut<T0, InvestorLimits>(arg1);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"nonAccreditedInvestorsLimit"), v0.non_accredited_limit, arg2);
        v0.non_accredited_limit = arg2;
    }

    public fun set_total_limit<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::RuleUpdateWrapper<T0, InvestorLimits>, arg2: u64, arg3: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg3);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13837028912696000527);
        let v0 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::borrow_update_mut<T0, InvestorLimits>(arg1);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"totalInvestorsLimit"), v0.total_investors_limit, arg2);
        v0.total_investors_limit = arg2;
    }

    public fun set_us_accredited_limit<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::RuleUpdateWrapper<T0, InvestorLimits>, arg2: u64, arg3: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg3);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13837029178983972879);
        let v0 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::borrow_update_mut<T0, InvestorLimits>(arg1);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"usAccreditedInvestorsLimit"), v0.us_accredited_limit, arg2);
        v0.us_accredited_limit = arg2;
    }

    public fun set_us_limit<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::RuleUpdateWrapper<T0, InvestorLimits>, arg2: u64, arg3: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg3);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13837029101674561551);
        let v0 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::borrow_update_mut<T0, InvestorLimits>(arg1);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"usInvestorsLimit"), v0.us_investors_limit, arg2);
        v0.us_investors_limit = arg2;
    }

    public fun total_limit(arg0: &InvestorLimits) : u64 {
        arg0.total_investors_limit
    }

    public fun us_accredited_limit(arg0: &InvestorLimits) : u64 {
        arg0.us_accredited_limit
    }

    public fun us_limit(arg0: &InvestorLimits) : u64 {
        arg0.us_investors_limit
    }

    public fun validate_investor_limits_for_issuance<T0>(arg0: &InvestorLimits, arg1: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg2: u64, arg3: 0x1::string::String, arg4: bool, arg5: bool, arg6: bool) {
        if (!arg6) {
            return
        };
        let v0 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_total_investors_count<T0>(arg1);
        validate_issuance_total_investors(arg0, v0, arg6);
        if (!arg4) {
            validate_issuance_non_accredited(arg0, v0 - 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_accredited_investor_count<T0>(arg1), arg6);
        };
        if (arg2 == 1) {
            validate_issuance_us_investors(arg0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_us_investor_count<T0>(arg1), v0, arg6);
            if (arg4) {
                validate_issuance_us_accredited(arg0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_us_accredited_investor_count<T0>(arg1), arg6);
            };
        } else if (arg2 == 2 && !arg5) {
            let v1 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_eu_retail_investor_count<T0>(arg1, arg3);
            if (0x1::option::is_some<u64>(&v1)) {
                validate_issuance_eu_retail(arg0, 0x1::option::extract<u64>(&mut v1), arg6);
            };
        } else if (arg2 == 8) {
            validate_issuance_jp_investors(arg0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_jp_investor_count<T0>(arg1), arg6);
        };
    }

    public fun validate_investor_limits_for_transfer<T0>(arg0: &InvestorLimits, arg1: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg2: bool, arg3: bool, arg4: bool, arg5: u64, arg6: 0x1::string::String, arg7: bool, arg8: bool, arg9: bool, arg10: bool, arg11: bool) {
        let v0 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_total_investors_count<T0>(arg1);
        validate_transfer_total_investors(arg0, v0, arg3, arg9);
        validate_transfer_minimum_total_investors(arg0, v0, arg3, arg9);
        if (arg5 == 1) {
            validate_us_investor_limits<T0>(arg0, arg1, arg3, arg2, arg9, arg7, arg10);
        } else if (arg5 == 8) {
            validate_transfer_jp_investors(arg0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_jp_investor_count<T0>(arg1), arg3, arg9, arg10);
        } else if (arg5 == 2 && !arg8) {
            let v1 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_eu_retail_investor_count<T0>(arg1, arg6);
            if (0x1::option::is_some<u64>(&v1)) {
                validate_transfer_eu_retail(arg0, 0x1::option::extract<u64>(&mut v1), arg3, arg4, arg9, arg11);
            };
        };
        if (!arg7) {
            validate_transfer_non_accredited(arg0, v0 - 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_accredited_investor_count<T0>(arg1), arg9, arg3, arg2);
        };
    }

    public fun validate_issuance_eu_retail(arg0: &InvestorLimits, arg1: u64, arg2: bool) {
        if (arg0.eu_retail_limit == 0) {
            return
        };
        if (arg2) {
            assert!(arg1 < arg0.eu_retail_limit, 13836468054391390219);
        };
    }

    public fun validate_issuance_jp_investors(arg0: &InvestorLimits, arg1: u64, arg2: bool) {
        if (arg0.jp_investors_limit == 0) {
            return
        };
        if (arg2) {
            assert!(arg1 < arg0.jp_investors_limit, 13836186725443436553);
        };
    }

    public fun validate_issuance_non_accredited(arg0: &InvestorLimits, arg1: u64, arg2: bool) {
        if (arg0.non_accredited_limit == 0) {
            return
        };
        if (arg2) {
            assert!(arg1 < arg0.non_accredited_limit, 13835904941228949511);
        };
    }

    public fun validate_issuance_total_investors(arg0: &InvestorLimits, arg1: u64, arg2: bool) {
        if (arg0.total_investors_limit == 0) {
            return
        };
        if (arg2) {
            assert!(arg1 < arg0.total_investors_limit, 13835060043852021761);
        };
    }

    public fun validate_issuance_us_accredited(arg0: &InvestorLimits, arg1: u64, arg2: bool) {
        if (arg0.us_accredited_limit == 0) {
            return
        };
        if (arg2) {
            assert!(arg1 < arg0.us_accredited_limit, 13835623320223219717);
        };
    }

    public fun validate_issuance_us_investors(arg0: &InvestorLimits, arg1: u64, arg2: u64, arg3: bool) {
        let v0 = effective_us_limit(arg0.us_investors_limit, arg0.max_us_percentage, arg2);
        if (v0 == 0) {
            return
        };
        if (arg3) {
            assert!(arg1 < v0, 13835341694922522627);
        };
    }

    public fun validate_transfer_eu_retail(arg0: &InvestorLimits, arg1: u64, arg2: bool, arg3: bool, arg4: bool, arg5: bool) {
        if (arg0.eu_retail_limit == 0) {
            return
        };
        let v0 = if (arg5) {
            if (arg2) {
                !arg3
            } else {
                false
            }
        } else {
            false
        };
        if (arg4 && !v0) {
            assert!(arg1 < arg0.eu_retail_limit, 13836467985671913483);
        };
    }

    public fun validate_transfer_jp_investors(arg0: &InvestorLimits, arg1: u64, arg2: bool, arg3: bool, arg4: bool) {
        if (arg0.jp_investors_limit == 0) {
            return
        };
        if (arg3 && (!arg4 || !arg2)) {
            assert!(arg1 < arg0.jp_investors_limit, 13836186656723959817);
        };
    }

    public fun validate_transfer_minimum_total_investors(arg0: &InvestorLimits, arg1: u64, arg2: bool, arg3: bool) {
        if (arg0.minimum_total_investors == 0) {
            return
        };
        if (arg2 && !arg3) {
            assert!(arg1 > arg0.minimum_total_investors, 13836749752706531341);
        };
    }

    public fun validate_transfer_non_accredited(arg0: &InvestorLimits, arg1: u64, arg2: bool, arg3: bool, arg4: bool) {
        if (arg0.non_accredited_limit == 0) {
            return
        };
        if (arg2 && (arg4 || !arg3)) {
            assert!(arg1 < arg0.non_accredited_limit, 13835904872509472775);
        };
    }

    public fun validate_transfer_total_investors(arg0: &InvestorLimits, arg1: u64, arg2: bool, arg3: bool) {
        if (arg0.total_investors_limit == 0) {
            return
        };
        if (arg3 && !arg2) {
            assert!(arg1 < arg0.total_investors_limit, 13835059975132545025);
        };
    }

    public fun validate_transfer_us_accredited(arg0: &InvestorLimits, arg1: u64, arg2: bool, arg3: bool, arg4: bool, arg5: bool) {
        if (arg0.us_accredited_limit == 0) {
            return
        };
        let v0 = if (arg2) {
            if (!arg5) {
                true
            } else if (!arg4) {
                true
            } else {
                !arg3
            }
        } else {
            false
        };
        if (v0) {
            assert!(arg1 < arg0.us_accredited_limit, 13835623251503742981);
        };
    }

    public fun validate_transfer_us_investors(arg0: &InvestorLimits, arg1: u64, arg2: u64, arg3: bool, arg4: bool, arg5: bool) {
        let v0 = effective_us_limit(arg0.us_investors_limit, arg0.max_us_percentage, arg2);
        if (v0 == 0) {
            return
        };
        if (arg4 && (!arg5 || !arg3)) {
            assert!(arg1 < v0, 13835341609023176707);
        };
    }

    public fun validate_us_investor_limits<T0>(arg0: &InvestorLimits, arg1: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg2: bool, arg3: bool, arg4: bool, arg5: bool, arg6: bool) {
        validate_transfer_us_investors(arg0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_us_investor_count<T0>(arg1), 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_total_investors_count<T0>(arg1), arg2, arg4, arg6);
        if (arg5) {
            validate_transfer_us_accredited(arg0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_us_accredited_investor_count<T0>(arg1), arg4, arg2, arg3, arg6);
        };
    }

    // decompiled from Move bytecode v7
}

