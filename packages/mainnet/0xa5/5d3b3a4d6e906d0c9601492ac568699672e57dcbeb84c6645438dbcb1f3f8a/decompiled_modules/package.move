module 0xa55d3b3a4d6e906d0c9601492ac568699672e57dcbeb84c6645438dbcb1f3f8a::package {
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

