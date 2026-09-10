module 0x8cd7036a55237ea5d75e72802319b189e0294c708dbdc67c95b1136b9fd646fc::reader {
    public fun current<T0>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg2: bool) : (u128, u128, u64, u64, u64, u64, u128, u128, u64, bool) {
        if (0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::size<T0>(arg0) != 2) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, false)
        };
        let v0 = 0x1::bcs::to_bytes<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(arg0);
        if (0x1::vector::length<u8>(&v0) > 8192) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, false)
        };
        let v1 = 0x2::bcs::new(v0);
        0x2::bcs::peel_address(&mut v1);
        0x2::bcs::peel_vec_u8(&mut v1);
        0x2::bcs::peel_address(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        let v2 = 0x2::bcs::peel_vec_vec_u8(&mut v1);
        let v3 = 0x2::bcs::peel_vec_u128(&mut v1);
        let v4 = 0x2::bcs::peel_vec_u64(&mut v1);
        let v5 = 0x2::bcs::peel_vec_u64(&mut v1);
        let v6 = 0x2::bcs::peel_vec_u64(&mut v1);
        0x2::bcs::peel_vec_u64(&mut v1);
        0x2::bcs::peel_vec_u64(&mut v1);
        if (0x2::bcs::peel_bool(&mut v1)) {
            0x2::bcs::peel_vec_u8(&mut v1);
        };
        let v7 = 0x2::bcs::peel_vec_u128(&mut v1);
        0x2::bcs::peel_u8(&mut v1);
        0x2::bcs::peel_u128(&mut v1);
        let v8 = 0x2::bcs::into_remainder_bytes(v1);
        let v9 = if (0x2::bcs::peel_u64(&mut v1) == 0) {
            if (0x1::vector::length<vector<u8>>(&v2) == 2) {
                if (0x1::vector::length<u128>(&v3) == 2) {
                    if (0x1::vector::length<u64>(&v4) == 2) {
                        if (0x1::vector::length<u64>(&v5) == 2) {
                            if (0x1::vector::length<u64>(&v6) == 2) {
                                if (0x1::vector::length<u128>(&v7) == 2) {
                                    0x1::vector::is_empty<u8>(&v8)
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v10 = 0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::total_protocol_fee(arg1);
        let v11 = v9 && v10 < 1000000000000000000;
        if (!v11) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, false)
        };
        let v12 = if (arg2) {
            0
        } else {
            1
        };
        let v13 = if (arg2) {
            1
        } else {
            0
        };
        (*0x1::vector::borrow<u128>(&v3, v12), *0x1::vector::borrow<u128>(&v3, v13), *0x1::vector::borrow<u64>(&v4, v12), *0x1::vector::borrow<u64>(&v4, v13), *0x1::vector::borrow<u64>(&v5, v12), *0x1::vector::borrow<u64>(&v6, v13), *0x1::vector::borrow<u128>(&v7, v12), *0x1::vector::borrow<u128>(&v7, v13), v10, true)
    }

    // decompiled from Move bytecode v7
}

