module 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::utils {
    public fun asset_to_entity_id(arg0: 0x1::ascii::String, arg1: u256) : address {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u256::to_string(arg1)));
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    public fun get_treasury_cap_key_address<T0>() : address {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::coin::TreasuryCap<T0>>()));
        0x2::address::from_bytes(0x2::hash::keccak256(&v0))
    }

    // decompiled from Move bytecode v6
}

