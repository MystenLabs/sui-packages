module 0xdc8dd2be1968b2b967a22fffb0a4406e7a45f2b8610d41882a6be8a0c9526e0b::zuno {
    struct ZUNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUNO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"2fd2948402bea35e5c6221f18b7f6083259a162ce89a22f20a2d3aa064f771e1                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ZUNO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ZUNO        ")))), trim_right(b"OFFICIAL ZUNO                   "), trim_right(x"5a554e4f206973206e6f74206865726520746f207265696e76656e742074686520776865656c206f722070726f6d69736520796f7520746865206e6578742067656e65726174696f6e206f6620616e797468696e672e0a0a4974732061206d656d6520746f6b656e20206275742061206d656d6520746f6b656e20796f752063616e2061637475616c6c792074727573743a0a0a20466978656420737570706c7920286e6f206d696e7420617574686f72697479290a204e6f20667265657a6520617574686f726974790a20496d6d757461626c65206f6e2d636861696e206d657461646174610a205472616e73706172656e742076657374696e6720636f6e7472616374730a416e642074686174732069742e20536f6d6574696d6573206120746f6b656e20646f65736e74206e65656420746f206275696c6420616e2065"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUNO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUNO>>(v4);
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

