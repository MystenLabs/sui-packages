module 0xfae0ae31f5c41a4d04ab3098f90c95681c738c143863f958e7057a7193f4a42f::package {
    fun extract_package_address(arg0: 0x1::type_name::TypeName) : address {
        let v0 = 0x1::type_name::get_address(&arg0);
        0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v0)))
    }

    public fun original_package_of_type<T0>() : address {
        extract_package_address(0x1::type_name::get_with_original_ids<T0>())
    }

    public fun package_of_type<T0>() : address {
        extract_package_address(0x1::type_name::get<T0>())
    }

    // decompiled from Move bytecode v6
}

