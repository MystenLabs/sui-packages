module 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::auth {
    public fun assert_auth<T0: drop>(arg0: &0x1::type_name::TypeName) {
        assert!(*arg0 == 0x1::type_name::with_original_ids<T0>(), 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_wrong_adapter());
    }

    public fun assert_auth_match(arg0: &0x1::type_name::TypeName, arg1: &0x1::type_name::TypeName) {
        assert!(arg0 == arg1, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_wrong_adapter());
    }

    public fun auth_type_of<T0: drop>() : 0x1::type_name::TypeName {
        0x1::type_name::with_original_ids<T0>()
    }

    // decompiled from Move bytecode v7
}

