module 0xa75757a59c35c6b229439fe2ebc83566aa622eca40375de78a507d3efce93af3::anty {
    struct ANTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/47b3pp5G7ZQJ15U1nEgRmorUfVTwrotgsFeyfdhgpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ANTY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ANTY        ")))), trim_right(b"Antishifty                      "), trim_right(x"416e7469736869667479202824414e54592920204578706f73696e672074686520436f72727570742c204f6e65204d656d6520617420612054696d650a0a205468652053686966747973206f662074686520776f726c642074686f756768742074686579207765726520756e746f75636861626c652e204e6f772c2024414e545920697320686572652e0a0a204669676874696e672066696e616e6369616c2066726175642c20706f6c69746963616c20646563657074696f6e2c20616e6420696e7369646572207363616d732e0a2041206d656d652d6675656c6564206d6f76656d656e74206275696c7420746f206578706f736520636f7272757074696f6e20776f726c64776964652e0a20536f6c616e612d706f77657265642c20666173742c20616e64207461782d667265652e0a0a20576520736565207468726f75"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANTY>>(v4);
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

