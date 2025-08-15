module 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::errors {
    public fun assert_auth_sig(arg0: bool) {
        assert!(arg0, 2);
    }

    public fun assert_billing_enabled(arg0: bool) {
        assert!(arg0, 15);
    }

    public fun assert_duplicate_id(arg0: bool) {
        assert!(arg0, 6);
    }

    public fun assert_image_too_large(arg0: bool) {
        assert!(arg0, 7);
    }

    public fun assert_invalid_item(arg0: bool) {
        assert!(arg0, 1);
    }

    public fun assert_invalid_type(arg0: bool) {
        assert!(arg0, 5);
    }

    public fun assert_is_admin(arg0: bool) {
        assert!(arg0, 14);
    }

    public fun assert_is_arrested(arg0: bool) {
        assert!(arg0, 17);
    }

    public fun assert_max_level_not_reached(arg0: bool) {
        assert!(arg0, 11);
    }

    public fun assert_no_pending(arg0: bool) {
        assert!(arg0, 4);
    }

    public fun assert_not_arrested(arg0: bool) {
        assert!(arg0, 9);
    }

    public fun assert_pending_exists(arg0: bool) {
        assert!(arg0, 3);
    }

    public fun assert_price_multiplier_not_too_high(arg0: bool) {
        assert!(arg0, 18);
    }

    public fun assert_sufficient_payment(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 13);
    }

    public fun assert_sufficient_stamina(arg0: bool) {
        assert!(arg0, 8);
    }

    public fun assert_sufficient_stat_points(arg0: bool) {
        assert!(arg0, 12);
    }

    public fun assert_valid_stat_allocation(arg0: bool) {
        assert!(arg0, 10);
    }

    public fun assert_valid_treasury(arg0: bool) {
        assert!(arg0, 16);
    }

    // decompiled from Move bytecode v6
}

