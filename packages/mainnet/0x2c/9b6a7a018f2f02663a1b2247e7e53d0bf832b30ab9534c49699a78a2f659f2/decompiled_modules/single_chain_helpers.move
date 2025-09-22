module 0x2c9b6a7a018f2f02663a1b2247e7e53d0bf832b30ab9534c49699a78a2f659f2::single_chain_helpers {
    public(friend) fun get_secret_hash<T0, T1>(arg0: address, arg1: 0x1::option::Option<address>, arg2: u64) : vector<u8> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        0x1::vector::append<u8>(&mut v1, 0x2::address::to_bytes(arg0));
        if (!0x1::type_name::is_primitive(&v0)) {
            0x1::vector::append<u8>(&mut v1, 0x1::ascii::into_bytes(0x1::type_name::into_string(v0)));
            0x1::vector::append<u8>(&mut v1, 0x2::address::to_bytes(0x1::option::extract<address>(&mut arg1)));
        } else if (0x1::ascii::into_bytes(0x1::type_name::into_string(v0)) != b"bool") {
            abort 401
        };
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg2));
        0x2::hash::keccak256(&v1)
    }

    // decompiled from Move bytecode v6
}

