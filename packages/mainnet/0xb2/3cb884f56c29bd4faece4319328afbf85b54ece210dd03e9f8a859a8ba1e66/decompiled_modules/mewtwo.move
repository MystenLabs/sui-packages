module 0xb23cb884f56c29bd4faece4319328afbf85b54ece210dd03e9f8a859a8ba1e66::mewtwo {
    struct MEWTWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWTWO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"af978973c2266edf6ab1d910bea3895f9149d119f73ecbd94790c9ae55d99783                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MEWTWO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MEWTWO      ")))), trim_right(b"Mewtwo                          "), trim_right(b"$MEWTWO keeps things sharp and efficient. No noise, no filler  just clean structure and fast execution. Everything here is built to be easy to understand and quick to use. If you prefer clear direction, smooth flow, and a space that doesnt waste your time, this mentality fits you perfectly.                             "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWTWO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEWTWO>>(v4);
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

