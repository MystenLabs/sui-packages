module 0x3a483163831d2fc94c2ea8e745afdf78befaf40e4ea67a3f2d9bd19b282628af::fine {
    struct FINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"cddb01407863d71c4b83790065740e1e9e9ab481678b688b69011400e731bce2                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FINE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FINE        ")))), trim_right(b"Fine Coin                       "), trim_right(x"2446494e45202074686520656d6f74696f6e616c20737570706f727420746f6b656e20666f72206576657279207472616465722077686f2070726574656e64732065766572797468696e67206973206f6b61792e0a0a467265616b6564204f75742e20496e7365637572652e204e6575726f7469632e20456d6f74696f6e616c2e20200a42757420746865206d61736b207374617973206f6e2e2054686520766f6963652073746179732063616c6d2e20200a4e6f20776f72726965732062726f2c20496d2066696e652e0a0a2446494e452069736e74206a7573742061206d656d6520206974732061206d6f76656d656e742e20200a412072656d696e6465722074686174206576656e207768656e20746865206d61726b6574206973207265642c20746865207669626573207374617920677265656e2e0a0a5765206275"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINE>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

