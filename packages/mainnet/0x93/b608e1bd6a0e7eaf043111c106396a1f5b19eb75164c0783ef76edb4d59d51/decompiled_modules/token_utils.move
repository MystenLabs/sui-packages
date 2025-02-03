module 0x93b608e1bd6a0e7eaf043111c106396a1f5b19eb75164c0783ef76edb4d59d51::token_utils {
    public fun calculate_token_id<T0: drop>() : address {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x2::address::from_bytes(0x2::hash::keccak256(&v0))
    }

    // decompiled from Move bytecode v6
}

