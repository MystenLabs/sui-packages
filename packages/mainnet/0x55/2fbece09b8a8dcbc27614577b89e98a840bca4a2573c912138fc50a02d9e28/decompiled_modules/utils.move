module 0x552fbece09b8a8dcbc27614577b89e98a840bca4a2573c912138fc50a02d9e28::utils {
    public fun build_customization_signed_data(arg0: &0x2::object::UID, arg1: u64, arg2: u64, arg3: &vector<u8>) : vector<u8> {
        let v0 = 0x2::object::uid_to_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, clone_bytes(arg3));
        v0
    }

    public fun clone_bytes(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun vector_find_index<T0>(arg0: &vector<T0>, arg1: &T0) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<T0>(arg0)) {
            if (0x1::vector::borrow<T0>(arg0, v0) == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun verify_ed25519_signature(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        0x2::ed25519::ed25519_verify(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

