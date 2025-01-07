module 0x3c8c0ab241e4112d1bf2695574c2ab2a97c88e2f6548e387d014045a08d091f0::utils {
    public fun create_role_serial_number(arg0: u64, arg1: &0x2::object::UID) : u64 {
        let v0 = 0x2::object::uid_to_bytes(arg1);
        let v1 = 0x2::hash::keccak256(&v0);
        let v2 = 0;
        while (0x1::vector::length<u8>(&v1) > 0) {
            let v3 = v2 << 8;
            v2 = v3 | (0x1::vector::remove<u8>(&mut v1, 0) as u64);
        };
        arg0 * 100000 + v2 % 100000
    }

    public fun serial_number_to_image_id(arg0: u64) : 0x1::string::String {
        u64_to_string(arg0 / 10 % 10000, 4)
    }

    public fun u64_to_string(arg0: u64, arg1: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        if (arg0 == 0) {
            0x1::vector::push_back<u8>(&mut v0, 48);
        } else {
            while (arg0 > 0) {
                0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
                arg0 = arg0 / 10;
            };
            while (0x1::vector::length<u8>(&v0) < arg1) {
                0x1::vector::push_back<u8>(&mut v0, 48);
            };
            0x1::vector::reverse<u8>(&mut v0);
        };
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

