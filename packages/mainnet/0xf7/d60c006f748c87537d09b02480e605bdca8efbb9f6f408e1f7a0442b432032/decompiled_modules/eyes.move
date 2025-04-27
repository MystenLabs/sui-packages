module 0xf7d60c006f748c87537d09b02480e605bdca8efbb9f6f408e1f7a0442b432032::eyes {
    struct EYES has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYES, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v10 = if (b"https://clipartix.com/wp-content/uploads/2016/07/Clip-art-eyes-free.png" == b"empty") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://clipartix.com/wp-content/uploads/2016/07/Clip-art-eyes-free.png"))
        };
        0x2::transfer::public_transfer<0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::CreatePoolCapV2>(0xc05d18dd6b61f510786e0c6df15f769fbc1b7d317341251eca2af4370c7426c3::pool::create_pool_cap_and_set_decimals<EYES>(arg0, b"EYES", b"Eyes", b"pretty eyes that are watching you", v10, 0x1::option::some<vector<u8>>(v0), true, v1, 0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

