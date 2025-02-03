module 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::token_utils {
    public fun calculate_token_id<T0: drop>() : address {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x2::address::from_bytes(0x2::hash::keccak256(&v0))
    }

    // decompiled from Move bytecode v6
}

