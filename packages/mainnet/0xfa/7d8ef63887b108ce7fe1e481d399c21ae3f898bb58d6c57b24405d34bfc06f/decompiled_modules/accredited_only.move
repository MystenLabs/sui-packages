module 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::accredited_only {
    struct AccreditedOnly has drop, store {
        force_accredited: bool,
        force_us_accredited: bool,
    }

    public fun is_force_accredited(arg0: &AccreditedOnly) : bool {
        arg0.force_accredited
    }

    public fun is_force_us_accredited(arg0: &AccreditedOnly) : bool {
        arg0.force_us_accredited
    }

    public fun new<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg1: bool, arg2: bool, arg3: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg4: &0x2::tx_context::TxContext) : 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::RuleInitWrapper<T0, AccreditedOnly> {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg3);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::RegisterRule>(arg0, 0x2::tx_context::sender(arg4)), 13835621228574146565);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_bool_rule_set_event<T0>(0x1::string::utf8(b"forceAccredited"), false, arg1);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_bool_rule_set_event<T0>(0x1::string::utf8(b"forceAccreditedUS"), false, arg2);
        let v0 = AccreditedOnly{
            force_accredited    : arg1,
            force_us_accredited : arg2,
        };
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::new_init<T0, AccreditedOnly>(v0)
    }

    public fun set_force_accredited<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::RuleUpdateWrapper<T0, AccreditedOnly>, arg2: bool, arg3: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg3);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13835621361718132741);
        let v0 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::borrow_update_mut<T0, AccreditedOnly>(arg1);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_bool_rule_set_event<T0>(0x1::string::utf8(b"forceAccredited"), v0.force_accredited, arg2);
        v0.force_accredited = arg2;
    }

    public fun set_force_us_accredited<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::RuleUpdateWrapper<T0, AccreditedOnly>, arg2: bool, arg3: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg3);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13835621439027544069);
        let v0 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::borrow_update_mut<T0, AccreditedOnly>(arg1);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_bool_rule_set_event<T0>(0x1::string::utf8(b"forceAccreditedUS"), v0.force_us_accredited, arg2);
        v0.force_us_accredited = arg2;
    }

    public fun validate_rule(arg0: &AccreditedOnly, arg1: u64, arg2: bool) {
        if (arg0.force_accredited) {
            assert!(arg2, 13835058574973206529);
        };
        if (arg0.force_us_accredited && arg1 == 1) {
            assert!(arg2, 13835340071424884739);
        };
    }

    // decompiled from Move bytecode v7
}

