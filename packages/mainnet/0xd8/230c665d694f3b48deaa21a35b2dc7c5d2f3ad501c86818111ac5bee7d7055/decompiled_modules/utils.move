module 0xd8230c665d694f3b48deaa21a35b2dc7c5d2f3ad501c86818111ac5bee7d7055::utils {
    public fun is_base<T0>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v0);
        let v2 = b"0x2::sui::SUI";
        if (0x1::vector::length<u8>(&v1) != 0x1::vector::length<u8>(&v2)) {
            return false
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            if (*0x1::vector::borrow<u8>(&v1, v3) != *0x1::vector::borrow<u8>(&v2, v3)) {
                return false
            };
            v3 = v3 + 1;
        };
        true
    }

    // decompiled from Move bytecode v6
}

