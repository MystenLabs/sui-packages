module 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::authorized_securities {
    struct AuthorizedSecurities has drop, store {
        max_supply: u64,
    }

    public fun is_enforced(arg0: &AuthorizedSecurities) : bool {
        arg0.max_supply > 0
    }

    public fun max_supply(arg0: &AuthorizedSecurities) : u64 {
        arg0.max_supply
    }

    public fun new<T0>(arg0: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg1: u64, arg2: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg3: &0x2::tx_context::TxContext) : 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::rule_wrapper::RuleInitWrapper<T0, AuthorizedSecurities> {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg2);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::RegisterRule>(arg0, 0x2::tx_context::sender(arg3)), 13835339732122468355);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"authorizedSecurities"), 0, arg1);
        let v0 = AuthorizedSecurities{max_supply: arg1};
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::rule_wrapper::new_init<T0, AuthorizedSecurities>(v0)
    }

    public fun set_max_supply<T0>(arg0: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::Auth<T0>, arg1: &mut 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::rule_wrapper::RuleUpdateWrapper<T0, AuthorizedSecurities>, arg2: u64, arg3: &0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::version::check_is_valid(arg3);
        assert!(0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::trust_service::owner_has_ability<T0, 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::abilities::ManageRules>(arg0, 0x2::tx_context::sender(arg4)), 13835339839496650755);
        let v0 = 0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::rule_wrapper::borrow_update_mut<T0, AuthorizedSecurities>(arg1);
        0xd7fb4dcf05522c420752a7f12b0d1994da14d37a7e77dc5170ff076a1ced7aae::events::emit_uint_rule_set_event<T0>(0x1::string::utf8(b"authorizedSecurities"), v0.max_supply, arg2);
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

