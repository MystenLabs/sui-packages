module 0xa9b532bf46b7d38a22ed397e5da6dccc8eb13f3a8c8b323b1dc30e85b305c654::af_lp {
    struct AF_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = vector[];
        let v2 = 2313;
        0x1::vector::push_back<u8>(&mut v0, ((v2 & 255) as u8));
        0x1::vector::push_back<u64>(&mut v1, 500000000000000000);
        let v3 = v2 >> 8;
        let v4 = v3;
        0x1::vector::push_back<u8>(&mut v0, ((v3 & 255) as u8));
        0x1::vector::push_back<u64>(&mut v1, 500000000000000000);
        if (0 > 0) {
            let v5 = v3 >> 8;
            v4 = v5;
            0x1::vector::push_back<u8>(&mut v0, ((v5 & 255) as u8));
            0x1::vector::push_back<u64>(&mut v1, 0);
        };
        if (0 > 0) {
            let v6 = v4 >> 8;
            v4 = v6;
            0x1::vector::push_back<u8>(&mut v0, ((v6 & 255) as u8));
            0x1::vector::push_back<u64>(&mut v1, 0);
        };
        if (0 > 0) {
            let v7 = v4 >> 8;
            v4 = v7;
            0x1::vector::push_back<u8>(&mut v0, ((v7 & 255) as u8));
            0x1::vector::push_back<u64>(&mut v1, 0);
        };
        if (0 > 0) {
            let v8 = v4 >> 8;
            v4 = v8;
            0x1::vector::push_back<u8>(&mut v0, ((v8 & 255) as u8));
            0x1::vector::push_back<u64>(&mut v1, 0);
        };
        if (0 > 0) {
            let v9 = v4 >> 8;
            v4 = v9;
            0x1::vector::push_back<u8>(&mut v0, ((v9 & 255) as u8));
            0x1::vector::push_back<u64>(&mut v1, 0);
        };
        if (0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((v4 >> 8 & 255) as u8));
            0x1::vector::push_back<u64>(&mut v1, 0);
        };
        let v10 = if (b"empty" == b"empty") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"empty"))
        };
        0x2::transfer::public_transfer<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::CreatePoolCapV2>(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::create_pool_cap_and_set_decimals<AF_LP>(arg0, b"LP_SYMBOL", b"Lp Name", b"Lp coin description", v10, 0x1::option::some<vector<u8>>(v0), false, v1, 0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

