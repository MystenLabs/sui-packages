module 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::force_full_transfer {
    struct ForceFullTransfer has drop, store {
        force_full_transfer_us: bool,
        force_full_transfer_worldwide: bool,
    }

    public fun is_force_us(arg0: &ForceFullTransfer) : bool {
        arg0.force_full_transfer_us
    }

    public fun is_force_worldwide(arg0: &ForceFullTransfer) : bool {
        arg0.force_full_transfer_worldwide
    }

    public fun new<T0>(arg0: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg1: bool, arg2: bool, arg3: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg4: &0x2::tx_context::TxContext) : 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::rule_wrapper::RuleInitWrapper<T0, ForceFullTransfer> {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg3);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RegisterRule>(arg0, 0x2::tx_context::sender(arg4)), 13835339749302337539);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::events::emit_bool_rule_set_event<T0>(0x1::string::utf8(b"forceFullTransfer"), false, arg1);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::events::emit_bool_rule_set_event<T0>(0x1::string::utf8(b"worldWideForceFullTransfer"), false, arg2);
        let v0 = ForceFullTransfer{
            force_full_transfer_us        : arg1,
            force_full_transfer_worldwide : arg2,
        };
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::rule_wrapper::new_init<T0, ForceFullTransfer>(v0)
    }

    public fun set_force_us<T0>(arg0: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg1: &mut 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::rule_wrapper::RuleUpdateWrapper<T0, ForceFullTransfer>, arg2: bool, arg3: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg3);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13835339882446323715);
        let v0 = 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::rule_wrapper::borrow_update_mut<T0, ForceFullTransfer>(arg1);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::events::emit_bool_rule_set_event<T0>(0x1::string::utf8(b"forceFullTransfer"), v0.force_full_transfer_us, arg2);
        v0.force_full_transfer_us = arg2;
    }

    public fun set_force_worldwide<T0>(arg0: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg1: &mut 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::rule_wrapper::RuleUpdateWrapper<T0, ForceFullTransfer>, arg2: bool, arg3: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg3);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13835339976935604227);
        let v0 = 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::rule_wrapper::borrow_update_mut<T0, ForceFullTransfer>(arg1);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::events::emit_bool_rule_set_event<T0>(0x1::string::utf8(b"worldWideForceFullTransfer"), v0.force_full_transfer_worldwide, arg2);
        v0.force_full_transfer_worldwide = arg2;
    }

    public fun validate_rule(arg0: &ForceFullTransfer, arg1: u64, arg2: bool, arg3: bool) {
        if (arg2) {
            return
        };
        assert!(!arg0.force_full_transfer_worldwide || arg3, 13835058617922879489);
        let v0 = if (!arg0.force_full_transfer_us) {
            true
        } else if (!(arg1 == 1)) {
            true
        } else {
            arg3
        };
        assert!(v0, 13835058652282617857);
    }

    // decompiled from Move bytecode v7
}

