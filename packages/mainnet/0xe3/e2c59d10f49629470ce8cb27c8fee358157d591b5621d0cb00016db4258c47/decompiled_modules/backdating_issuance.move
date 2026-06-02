module 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::backdating_issuance {
    struct BackdatingIssuance has drop, store {
        disallow_backdating: bool,
    }

    public fun is_backdating_allowed(arg0: &BackdatingIssuance) : bool {
        !arg0.disallow_backdating
    }

    public fun new<T0>(arg0: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg1: bool, arg2: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg3: &0x2::tx_context::TxContext) : 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::rule_wrapper::RuleInitWrapper<T0, BackdatingIssuance> {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg2);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RegisterRule>(arg0, 0x2::tx_context::sender(arg3)), 13835058235670790145);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::events::emit_bool_rule_set_event<T0>(0x1::string::utf8(b"disallowBackDating"), false, arg1);
        let v0 = BackdatingIssuance{disallow_backdating: arg1};
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::rule_wrapper::new_init<T0, BackdatingIssuance>(v0)
    }

    public fun set_disallow_backdating<T0>(arg0: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg1: &mut 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::rule_wrapper::RuleUpdateWrapper<T0, BackdatingIssuance>, arg2: bool, arg3: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg3);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13835058343044972545);
        let v0 = 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::rule_wrapper::borrow_update_mut<T0, BackdatingIssuance>(arg1);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::events::emit_bool_rule_set_event<T0>(0x1::string::utf8(b"disallowBackDating"), v0.disallow_backdating, arg2);
        v0.disallow_backdating = arg2;
    }

    // decompiled from Move bytecode v7
}

