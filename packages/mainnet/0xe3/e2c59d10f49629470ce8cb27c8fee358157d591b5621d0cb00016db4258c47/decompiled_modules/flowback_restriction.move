module 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::flowback_restriction {
    struct FlowbackRestriction has drop, store {
        block_flowback_end_time_ms: u64,
    }

    public fun flowback_end_time(arg0: &FlowbackRestriction) : u64 {
        arg0.block_flowback_end_time_ms
    }

    public fun is_active(arg0: &FlowbackRestriction, arg1: &0x2::clock::Clock) : bool {
        arg0.block_flowback_end_time_ms == 0 || 0x2::clock::timestamp_ms(arg1) < arg0.block_flowback_end_time_ms
    }

    public fun new<T0>(arg0: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg1: u64, arg2: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg3: &0x2::tx_context::TxContext) : 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::rule_wrapper::RuleInitWrapper<T0, FlowbackRestriction> {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg2);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RegisterRule>(arg0, 0x2::tx_context::sender(arg3)), 13835339740712402947);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"blockFlowbackEndTime"), 0, arg1);
        let v0 = FlowbackRestriction{block_flowback_end_time_ms: arg1};
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::rule_wrapper::new_init<T0, FlowbackRestriction>(v0)
    }

    public fun set_flowback_end_time<T0>(arg0: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg1: &mut 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::rule_wrapper::RuleUpdateWrapper<T0, FlowbackRestriction>, arg2: u64, arg3: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg3);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13835339848086585347);
        let v0 = 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::rule_wrapper::borrow_update_mut<T0, FlowbackRestriction>(arg1);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"blockFlowbackEndTime"), v0.block_flowback_end_time_ms, arg2);
        v0.block_flowback_end_time_ms = arg2;
    }

    public fun validate_rule(arg0: &FlowbackRestriction, arg1: u64, arg2: u64, arg3: bool, arg4: u64) {
        let v0 = arg0.block_flowback_end_time_ms;
        let v1 = arg1 != 1 && arg2 == 1;
        let v2 = v0 == 0 || arg4 < v0;
        let v3 = if (v1) {
            if (!arg3) {
                v2
            } else {
                false
            }
        } else {
            false
        };
        assert!(!v3, 13835058514843664385);
    }

    // decompiled from Move bytecode v7
}

