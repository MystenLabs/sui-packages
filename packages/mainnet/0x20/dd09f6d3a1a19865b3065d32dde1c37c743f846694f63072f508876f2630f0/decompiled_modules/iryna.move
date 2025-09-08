module 0x20dd09f6d3a1a19865b3065d32dde1c37c743f846694f63072f508876f2630f0::iryna {
    struct IRYNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRYNA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"54e4515243d9b654f9f5a3c2cb89fcd076743cfc96525072c22b392616b820fd                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<IRYNA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"IRYNA       ")))), trim_right(b"Justice for Iryna               "), trim_right(x"546865206f6e6520616e64206f6e6c792074727565204f472065766572206465706c6f796564206f6e2050756d7066756e3a2031393a35393a303720204175672032352c20323032352028555443290a0a43544f2068616e646c656420627920616e20657870657269656e636564207465616d20206e6f2062756e646c652c206e6f206661726d2e0a0a434120656e6473207769746820766d454e2020616c6d6f7374206c6f6f6b73206c696b6520414d454e0a0a576520617265207468652063686f73656e206f6e6573212020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRYNA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRYNA>>(v4);
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

