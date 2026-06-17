module 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::auth {
    public fun assert_auth<T0: drop>(arg0: &0x1::type_name::TypeName) {
        assert!(*arg0 == 0x1::type_name::with_original_ids<T0>(), 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_wrong_adapter());
    }

    public fun assert_auth_match(arg0: &0x1::type_name::TypeName, arg1: &0x1::type_name::TypeName) {
        assert!(arg0 == arg1, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_wrong_adapter());
    }

    public fun auth_type_of<T0: drop>() : 0x1::type_name::TypeName {
        0x1::type_name::with_original_ids<T0>()
    }

    // decompiled from Move bytecode v7
}

