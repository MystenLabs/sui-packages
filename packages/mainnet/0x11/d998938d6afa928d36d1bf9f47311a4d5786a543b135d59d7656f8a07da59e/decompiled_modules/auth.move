module 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::auth {
    public fun assert_auth<T0: drop>(arg0: &0x1::type_name::TypeName) {
        assert!(*arg0 == 0x1::type_name::with_original_ids<T0>(), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_adapter());
    }

    public fun assert_auth_match(arg0: &0x1::type_name::TypeName, arg1: &0x1::type_name::TypeName) {
        assert!(arg0 == arg1, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_adapter());
    }

    public fun auth_type_of<T0: drop>() : 0x1::type_name::TypeName {
        0x1::type_name::with_original_ids<T0>()
    }

    // decompiled from Move bytecode v7
}

