module 0xc0d9c09f1d45e8a8a19fee5c3879a333ed41ca47f4ba8209323beecc00707461::ziggyfox {
    struct ZIGGYFOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIGGYFOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"n9WHRr0c6ryh1qO2                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ZIGGYFOX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ZiggyFox    ")))), trim_right(b"Ziggy The Fox                   "), trim_right(x"496e2072656d656d6272616e6365206f66205a696767792074686520666f782e2053686520776173206d616c6963696f75736c792076696f6c617465642c207368617665642026206c65667420616c6f6e65206f6e206120666c6f6174696e67207069656365206f66206963652e205a6967677920776173206120626561757466756c2052656420466f782c206275742073686520776173207365656b696e67207761726d7468206f6e206120636f6c64206e69676874202620736f6d6520737472616e6765727320746f6f6b206164766174616765206f6620686572206b696e6420736f756c2e0d0a0d0a224c6f63616c206f6666696369616c7320726573706f6e646564206f6e20536174757264617920746f2063616c6c732061626f75742074686520666f78206265696e6720737472616e646564206f6e2074686520"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIGGYFOX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZIGGYFOX>>(v4);
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

