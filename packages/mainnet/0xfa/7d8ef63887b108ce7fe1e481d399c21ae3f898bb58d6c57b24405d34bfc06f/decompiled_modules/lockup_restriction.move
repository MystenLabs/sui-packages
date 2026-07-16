module 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::lockup_restriction {
    struct LockupRestriction has drop, store {
        us_lock_period_ms: u64,
        non_us_lock_period_ms: u64,
    }

    public fun compute_transferable_tokens(arg0: &LockupRestriction, arg1: &vector<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::Issuance>, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (0x1::vector::is_empty<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::Issuance>(arg1)) {
            return arg3
        };
        let v0 = get_lock_period(arg0, arg2);
        if (v0 == 0) {
            return arg3
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::Issuance>(arg1)) {
            let v3 = 0x1::vector::borrow<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::Issuance>(arg1, v2);
            let v4 = 0x1::u256::try_as_u64((0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::issuance_time_ms(v3) as u256) + (v0 as u256));
            assert!(0x1::option::is_some<u64>(&v4), 13835903532479676423);
            if (0x1::option::extract<u64>(&mut v4) > arg4) {
                v1 = v1 + 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::issuance_amount(v3);
            };
            v2 = v2 + 1;
        };
        let v5 = if (v1 > arg3) {
            arg3
        } else {
            v1
        };
        arg3 - v5
    }

    public fun get_lock_period(arg0: &LockupRestriction, arg1: u64) : u64 {
        if (arg1 == 1) {
            arg0.us_lock_period_ms
        } else {
            arg0.non_us_lock_period_ms
        }
    }

    public fun is_issuance_locked(arg0: &LockupRestriction, arg1: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::Issuance, arg2: u64, arg3: u64) : bool {
        let v0 = get_lock_period(arg0, arg2);
        if (v0 == 0) {
            return false
        };
        let v1 = 0x1::u256::try_as_u64((0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::issuance_time_ms(arg1) as u256) + (v0 as u256));
        assert!(0x1::option::is_some<u64>(&v1), 13835903532479676423);
        0x1::option::extract<u64>(&mut v1) > arg3
    }

    public fun lock_period_for_region(arg0: &LockupRestriction, arg1: u64) : u64 {
        get_lock_period(arg0, arg1)
    }

    public fun new<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg1: u64, arg2: u64, arg3: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg4: &0x2::tx_context::TxContext) : 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::RuleInitWrapper<T0, LockupRestriction> {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg3);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::RegisterRule>(arg0, 0x2::tx_context::sender(arg4)), 13835621284408721413);
        assert!(arg1 <= 6307200000000, 13835339813726846979);
        assert!(arg2 <= 6307200000000, 13835339818021814275);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"usLockPeriod"), 0, arg1);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"nonUSLockPeriod"), 0, arg2);
        let v0 = LockupRestriction{
            us_lock_period_ms     : arg1,
            non_us_lock_period_ms : arg2,
        };
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::new_init<T0, LockupRestriction>(v0)
    }

    public fun non_us_lock_period(arg0: &LockupRestriction) : u64 {
        arg0.non_us_lock_period_ms
    }

    public fun set_non_us_lock_period<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::RuleUpdateWrapper<T0, LockupRestriction>, arg2: u64, arg3: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg3);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13835621499157086213);
        assert!(arg2 <= 6307200000000, 13835340028475211779);
        let v0 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::borrow_update_mut<T0, LockupRestriction>(arg1);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"nonUSLockPeriod"), v0.non_us_lock_period_ms, arg2);
        v0.non_us_lock_period_ms = arg2;
    }

    public fun set_us_lock_period<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::RuleUpdateWrapper<T0, LockupRestriction>, arg2: u64, arg3: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg3);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13835621396077871109);
        assert!(arg2 <= 6307200000000, 13835339925395996675);
        let v0 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::borrow_update_mut<T0, LockupRestriction>(arg1);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"usLockPeriod"), v0.us_lock_period_ms, arg2);
        v0.us_lock_period_ms = arg2;
    }

    public fun us_lock_period(arg0: &LockupRestriction) : u64 {
        arg0.us_lock_period_ms
    }

    public fun validate_rule(arg0: &LockupRestriction, arg1: &vector<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::Issuance>, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64) {
        if (arg4) {
            return
        };
        assert!(compute_transferable_tokens(arg0, arg1, arg3, arg5, arg6) >= arg2, 13835058708117192705);
    }

    // decompiled from Move bytecode v7
}

