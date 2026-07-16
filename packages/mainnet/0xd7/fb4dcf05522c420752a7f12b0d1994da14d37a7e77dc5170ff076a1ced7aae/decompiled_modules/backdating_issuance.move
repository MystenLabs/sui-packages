module 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::backdating_issuance {
    struct BackdatingIssuance has drop, store {
        disallow_backdating: bool,
    }

    public fun is_backdating_allowed(arg0: &BackdatingIssuance) : bool {
        !arg0.disallow_backdating
    }

    public fun new<T0>(arg0: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg1: bool, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg3: &0x2::tx_context::TxContext) : 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::rule_wrapper::RuleInitWrapper<T0, BackdatingIssuance> {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg2);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::RegisterRule>(arg0, 0x2::tx_context::sender(arg3)), 13835058235670790145);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_bool_rule_set_event<T0>(0x1::string::utf8(b"disallowBackDating"), false, arg1);
        let v0 = BackdatingIssuance{disallow_backdating: arg1};
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::rule_wrapper::new_init<T0, BackdatingIssuance>(v0)
    }

    public fun set_disallow_backdating<T0>(arg0: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg1: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::rule_wrapper::RuleUpdateWrapper<T0, BackdatingIssuance>, arg2: bool, arg3: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg3);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13835058343044972545);
        let v0 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::rule_wrapper::borrow_update_mut<T0, BackdatingIssuance>(arg1);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_bool_rule_set_event<T0>(0x1::string::utf8(b"disallowBackDating"), v0.disallow_backdating, arg2);
        v0.disallow_backdating = arg2;
    }

    // decompiled from Move bytecode v7
}

