module 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::authorized_securities {
    struct AuthorizedSecurities has drop, store {
        max_supply: u64,
    }

    public fun is_enforced(arg0: &AuthorizedSecurities) : bool {
        arg0.max_supply > 0
    }

    public fun max_supply(arg0: &AuthorizedSecurities) : u64 {
        arg0.max_supply
    }

    public fun new<T0>(arg0: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg1: u64, arg2: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg3: &0x2::tx_context::TxContext) : 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::rule_wrapper::RuleInitWrapper<T0, AuthorizedSecurities> {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg2);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RegisterRule>(arg0, 0x2::tx_context::sender(arg3)), 13835339732122468355);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"authorizedSecurities"), 0, arg1);
        let v0 = AuthorizedSecurities{max_supply: arg1};
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::rule_wrapper::new_init<T0, AuthorizedSecurities>(v0)
    }

    public fun set_max_supply<T0>(arg0: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg1: &mut 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::rule_wrapper::RuleUpdateWrapper<T0, AuthorizedSecurities>, arg2: u64, arg3: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg3);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13835339839496650755);
        let v0 = 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::rule_wrapper::borrow_update_mut<T0, AuthorizedSecurities>(arg1);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"authorizedSecurities"), v0.max_supply, arg2);
        v0.max_supply = arg2;
    }

    public fun validate_rule(arg0: &AuthorizedSecurities, arg1: u64, arg2: u64) {
        if (arg0.max_supply == 0) {
            return
        };
        assert!(arg1 + arg2 <= arg0.max_supply, 13835058433239285761);
    }

    // decompiled from Move bytecode v7
}

