module 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors {
    public(friend) fun assert_auth_sig(arg0: bool) {
        assert!(arg0, 2);
    }

    public(friend) fun assert_billing_enabled(arg0: bool) {
        assert!(arg0, 15);
    }

    public(friend) fun assert_duplicate_id(arg0: bool) {
        assert!(arg0, 6);
    }

    public(friend) fun assert_has_stats_to_reset(arg0: bool) {
        assert!(arg0, 23);
    }

    public(friend) fun assert_invalid_item(arg0: bool) {
        assert!(arg0, 1);
    }

    public(friend) fun assert_invalid_type(arg0: bool) {
        assert!(arg0, 5);
    }

    public(friend) fun assert_inventory_full(arg0: bool) {
        assert!(arg0, 22);
    }

    public(friend) fun assert_is_arrested(arg0: bool) {
        assert!(arg0, 17);
    }

    public(friend) fun assert_item_equipped(arg0: bool) {
        assert!(arg0, 20);
    }

    public(friend) fun assert_no_pending(arg0: bool) {
        assert!(arg0, 4);
    }

    public(friend) fun assert_not_arrested(arg0: bool) {
        assert!(arg0, 9);
    }

    public(friend) fun assert_pending_exists(arg0: bool) {
        assert!(arg0, 3);
    }

    public(friend) fun assert_price_cap(arg0: bool) {
        assert!(arg0, 21);
    }

    public(friend) fun assert_price_multiplier_not_too_high(arg0: bool) {
        assert!(arg0, 18);
    }

    public(friend) fun assert_sufficient_payment(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 13);
    }

    public(friend) fun assert_sufficient_stamina(arg0: bool) {
        assert!(arg0, 8);
    }

    public(friend) fun assert_sufficient_stat_points(arg0: bool) {
        assert!(arg0, 12);
    }

    public(friend) fun assert_valid_stat_allocation(arg0: bool) {
        assert!(arg0, 10);
    }

    public(friend) fun assert_valid_treasury(arg0: bool) {
        assert!(arg0, 16);
    }

    // decompiled from Move bytecode v6
}

