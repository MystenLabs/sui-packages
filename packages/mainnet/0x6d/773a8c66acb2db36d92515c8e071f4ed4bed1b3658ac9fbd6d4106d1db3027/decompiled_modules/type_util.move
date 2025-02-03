module 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util {
    public fun assert_witness<T0>(arg0: 0x1::ascii::String) {
        assert!(check_witness<T0>(arg0), 2);
    }

    public fun check_witness<T0>(arg0: 0x1::ascii::String) : bool {
        let v0 = 0x1::ascii::into_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, b"::");
        0x1::vector::append<u8>(&mut v0, b"WITNESS");
        0x1::ascii::into_bytes(type_to_name<T0>()) == v0
    }

    public fun is_witness<T0>() : bool {
        0x1::ascii::into_bytes(struct_name<T0>()) == b"WITNESS"
    }

    public fun module_id<T0>() : 0x1::ascii::String {
        let v0 = 0x1::ascii::into_bytes(type_to_name<T0>());
        let v1 = b"::";
        let (v2, v3) = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::last_index_of(&v0, &v1);
        assert!(v2, 1);
        0x1::ascii::string(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::substring(&v0, 0, v3))
    }

    public fun struct_name<T0>() : 0x1::ascii::String {
        let v0 = 0x1::ascii::into_bytes(type_to_name<T0>());
        let v1 = b"::";
        let (v2, v3) = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::last_index_of(&v0, &v1);
        assert!(v2, 1);
        0x1::ascii::string(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::substring(&v0, v3 + 2, 0x1::vector::length<u8>(&v0)))
    }

    public fun type_to_name<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>())
    }

    // decompiled from Move bytecode v6
}

