module 0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::reader {
    public fun current<T0>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg2: bool) : (u128, u128, u64, u64, u64, u64, u128, u128, u64, bool) {
        if (0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::size<T0>(arg0) != 2) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, false)
        };
        decode_pool(0x1::bcs::to_bytes<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(arg0), 0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::total_protocol_fee(arg1), arg2)
    }

    fun decode_pool(arg0: vector<u8>, arg1: u64, arg2: bool) : (u128, u128, u64, u64, u64, u64, u128, u128, u64, bool) {
        if (0x1::vector::length<u8>(&arg0) > 8192) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, false)
        };
        let v0 = 0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::new(arg0);
        0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::skip(&mut v0, 32);
        let v1 = &mut v0;
        skip_bytes(v1);
        0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::skip(&mut v0, 48);
        let v2 = &mut v0;
        let v3 = &mut v0;
        let v4 = read_u128s(v3);
        let v5 = &mut v0;
        let v6 = read_u64s(v5);
        let v7 = &mut v0;
        let v8 = read_u64s(v7);
        let v9 = &mut v0;
        let v10 = read_u64s(v9);
        0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::skip(&mut v0, 0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::length(&mut v0) * 8);
        0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::skip(&mut v0, 0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::length(&mut v0) * 8);
        if (0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::boolean(&mut v0)) {
            let v11 = &mut v0;
            skip_bytes(v11);
        };
        let v12 = &mut v0;
        let v13 = read_u128s(v12);
        0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::skip(&mut v0, 17);
        let v14 = if (0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::read_u64(&mut v0) == 0) {
            if (skip_names(v2) == 2) {
                if (0x1::vector::length<u128>(&v4) == 2) {
                    if (0x1::vector::length<u64>(&v6) == 2) {
                        if (0x1::vector::length<u64>(&v8) == 2) {
                            if (0x1::vector::length<u64>(&v10) == 2) {
                                if (0x1::vector::length<u128>(&v13) == 2) {
                                    0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::is_empty(&v0)
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
        let v15 = v14 && arg1 < 1000000000000000000;
        if (!v15) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, false)
        };
        let v16 = if (arg2) {
            0
        } else {
            1
        };
        let v17 = if (arg2) {
            1
        } else {
            0
        };
        (*0x1::vector::borrow<u128>(&v4, v16), *0x1::vector::borrow<u128>(&v4, v17), *0x1::vector::borrow<u64>(&v6, v16), *0x1::vector::borrow<u64>(&v6, v17), *0x1::vector::borrow<u64>(&v8, v16), *0x1::vector::borrow<u64>(&v10, v17), *0x1::vector::borrow<u128>(&v13, v16), *0x1::vector::borrow<u128>(&v13, v17), arg1, true)
    }

    fun read_u128s(arg0: &mut 0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::Cursor) : vector<u128> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::length(arg0)) {
            0x1::vector::push_back<u128>(&mut v0, 0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::read_u128(arg0));
            v1 = v1 + 1;
        };
        v0
    }

    fun read_u64s(arg0: &mut 0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::Cursor) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::length(arg0)) {
            0x1::vector::push_back<u64>(&mut v0, 0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::read_u64(arg0));
            v1 = v1 + 1;
        };
        v0
    }

    fun skip_bytes(arg0: &mut 0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::Cursor) {
        0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::skip(arg0, 0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::length(arg0));
    }

    fun skip_names(arg0: &mut 0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::Cursor) : u64 {
        let v0 = 0x3e9d50b0fd9774732260055c2faf9e7ac3641d79a8c96dd44cf0abc214d952bd::cursor::length(arg0);
        let v1 = 0;
        while (v1 < v0) {
            skip_bytes(arg0);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

