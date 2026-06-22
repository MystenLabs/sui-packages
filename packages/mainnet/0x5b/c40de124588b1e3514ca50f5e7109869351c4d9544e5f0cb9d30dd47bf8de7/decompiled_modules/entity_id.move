module 0x5bc40de124588b1e3514ca50f5e7109869351c4d9544e5f0cb9d30dd47bf8de7::entity_id {
    public fun from_bytes(arg0: vector<u8>) : address {
        0x2::address::from_bytes(0x2::hash::keccak256(&arg0))
    }

    public fun from_address_with_seed(arg0: address, arg1: 0x1::ascii::String) : address {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(arg1));
        from_bytes(v0)
    }

    public fun from_address_with_u256(arg0: address, arg1: u256) : address {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u256>(&arg1));
        from_bytes(v0)
    }

    public fun from_object<T0: key>(arg0: &T0) : address {
        0x2::object::id_address<T0>(arg0)
    }

    public fun from_u256(arg0: u256) : address {
        let v0 = 0x1::bcs::to_bytes<u256>(&arg0);
        0x1::vector::append<u8>(&mut v0, b"u256");
        from_bytes(v0)
    }

    // decompiled from Move bytecode v6
}

