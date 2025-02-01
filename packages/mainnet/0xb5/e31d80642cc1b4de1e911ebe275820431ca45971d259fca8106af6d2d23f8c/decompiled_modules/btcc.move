module 0xb5e31d80642cc1b4de1e911ebe275820431ca45971d259fca8106af6d2d23f8c::btcc {
    struct BTCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"FT-i2CuoXvfUcVAq                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BTCC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BTCC        ")))), trim_right(b"Bitcent                         "), trim_right(x"42697463656e7420284254434329206973206120646563656e7472616c697a65642063727970746f63757272656e6379206c61756e63686564206f6e2074686520536f6c616e6120436861696e20766961205261796469756d204465782c2077697468206120746f74616c20737570706c79206f6620312062696c6c696f6e20746f6b656e732e204c657665726167696e6720536f6c616e61277320686967682d737065656420696e6672617374727563747572652c2042697463656e7420666163696c69746174657320666173742c207365637572652c20616e64206c6f772d636f7374206d6963726f7472616e73616374696f6e732e0d0a0d0a42697463656e74206c65766572616765732074686520656666696369656e6379206f662074686520536f6c616e61206e6574776f726b20746f206d616b6520736d616c6c"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCC>>(v4);
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

