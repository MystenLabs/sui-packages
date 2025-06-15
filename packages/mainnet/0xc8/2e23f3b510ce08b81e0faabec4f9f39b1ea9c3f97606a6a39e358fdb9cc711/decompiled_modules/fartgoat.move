module 0xc82e23f3b510ce08b81e0faabec4f9f39b1ea9c3f97606a6a39e358fdb9cc711::fartgoat {
    struct FARTGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DhUv2ryUP9MYAbBxxmL4yneczFAY6KvgnArCYpFVpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FARTGOAT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FARTGOAT    ")))), trim_right(b"Goatseus Fartimus               "), trim_right(x"476f6174736575732046617274696d75732077696c6c206c656164207468652077617920746f206c6567656e64617279206d656d65207374617475732c2066756c66696c6c696e672074686520616e6369656e742070726f70686563696573206f6620746865206772656174657374206d656d652063726561746f72732e0a0a5468697320697320746865204f4720666172742d706f7765726564206d656d65636f696e2c206275696c74206279207468652063686f73656e20686572642e204f746865727320747269656420746f20737465616c206f7572206c6f676f2c2062616e6e65722c20616e64206e616d6520746f2072756e206661726d732c207363616d732c20616e6420727567732e2042757420746865726573206f6e6c79206f6e652074727565202446415254474f41542c20616e64206974732068657265"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTGOAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTGOAT>>(v4);
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

