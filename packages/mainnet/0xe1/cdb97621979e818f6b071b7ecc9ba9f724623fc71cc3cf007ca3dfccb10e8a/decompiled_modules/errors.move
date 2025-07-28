module 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::errors {
    public fun assert_auth_sig(arg0: bool) {
        assert!(arg0, 2);
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

    public fun assert_no_pending(arg0: bool) {
        assert!(arg0, 4);
    }

    public fun assert_pending_exists(arg0: bool) {
        assert!(arg0, 3);
    }

    public fun assert_raid_cooldown(arg0: bool) {
        assert!(arg0, 0);
    }

    // decompiled from Move bytecode v6
}

