module 0x690a330c51d821a23daf2831205fdd02a48062df89d1226ba471b07384bd1a0d::spamton {
    struct SPAMTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAMTON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"a18b26fd12891a58b4602884b1c674e0c6fa38edf56e2d521701b62607533e70                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SPAMTON>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Spamton     ")))), trim_right(b"Spamton G. Spamton              "), trim_right(x"484559205b5b494e564553544f52535d5d2121210a4c6f6f6b73206c696b6520796f7572205b5b4c6974746c652053706f6e67655d5d202243544f207465616d20746f6f6b20746865206d6f6e657920616e64205b5b52414e20464f52205448452048494c4c535d5d2121212042757420646f6e7420796f752063727920796f75722070726563696f7573206469676974616c207465617273206a75737420796574206265636175736520492c205350414d544f4e20472e205350414d544f4e2c2068617665207365697a65642074686520736572766572732c206861636b65642074686520686173682c20616e64204354524c2b414c542b44454c4554454420746865207061737421212120202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAMTON>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAMTON>>(v4);
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

