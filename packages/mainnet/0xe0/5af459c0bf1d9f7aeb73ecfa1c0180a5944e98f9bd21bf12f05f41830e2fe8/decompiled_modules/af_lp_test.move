module 0xe05af459c0bf1d9f7aeb73ecfa1c0180a5944e98f9bd21bf12f05f41830e2fe8::af_lp_test {
    struct AF_LP_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_LP_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[];
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 800000000000000000);
        0x1::vector::push_back<u64>(v2, 500000000000000018);
        0x1::vector::push_back<u64>(v2, 36);
        0x1::vector::push_back<u64>(v2, 54);
        0x1::vector::push_back<u64>(v2, 72);
        0x1::vector::push_back<u64>(v2, 90);
        0x1::vector::push_back<u64>(v2, 108);
        0x1::vector::push_back<u64>(v2, 126);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v1)) {
            let v4 = *0x1::vector::borrow<u64>(&v1, v3) - v3 * 18;
            if (v4 > 0) {
                0x1::vector::push_back<u64>(&mut v0, v4);
                v3 = v3 + 1;
                continue
            };
            /* label 4 */
            let v5 = 8;
            let v6 = b"";
            let v7 = 0;
            while (v7 < 0x1::vector::length<u64>(&v0)) {
                0x1::vector::push_back<u8>(&mut v6, ((v5 & 255) as u8));
                v5 = v5 >> 8;
                v7 = v7 + 1;
            };
            let v8 = if (b"TEST_URL" == b"TEST_URL") {
                0x1::option::none<0x2::url::Url>()
            } else {
                0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"TEST_URL"))
            };
            0x2::transfer::public_transfer<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::CreatePoolCapV2>(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::create_pool_cap_and_set_decimals<AF_LP_TEST>(arg0, b"TEST_SYMBOL", b"TEST_NAME", b"TEST_DESCRIPTION", v8, 0x1::option::some<vector<u8>>(v6), false, v0, 144 - 144, arg1), 0x2::tx_context::sender(arg1));
            return
        };
        /* goto 4 */
    }

    // decompiled from Move bytecode v6
}

