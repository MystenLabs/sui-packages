module 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::auth {
    public fun assert_auth<T0: drop>(arg0: &0x1::type_name::TypeName) {
        assert!(*arg0 == 0x1::type_name::with_original_ids<T0>(), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::errors::e_wrong_adapter());
    }

    public fun assert_auth_match(arg0: &0x1::type_name::TypeName, arg1: &0x1::type_name::TypeName) {
        assert!(arg0 == arg1, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::errors::e_wrong_adapter());
    }

    public fun auth_type_of<T0: drop>() : 0x1::type_name::TypeName {
        0x1::type_name::with_original_ids<T0>()
    }

    // decompiled from Move bytecode v7
}

