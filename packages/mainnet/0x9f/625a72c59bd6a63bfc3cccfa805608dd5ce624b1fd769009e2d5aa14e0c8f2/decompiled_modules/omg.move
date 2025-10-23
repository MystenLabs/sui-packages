module 0x9f625a72c59bd6a63bfc3cccfa805608dd5ce624b1fd769009e2d5aa14e0c8f2::omg {
    struct OMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"4b27c69602c38ba212e93efa8a1407096a3da8de95217caa052e71ff8b9e94db                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OMG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OMG         ")))), trim_right(b"OH MY GOD                       "), trim_right(b"Oh My God is  a guy who accidentally wins everything possible. Buys a token as a joke  gets a Lamborghini. Opens a mystery box on a stream  finds a million dollars inside. Permanently in shock from his own luck, screaming OH MY GOD and having no idea what's going on.                                                     "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMG>>(v4);
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

