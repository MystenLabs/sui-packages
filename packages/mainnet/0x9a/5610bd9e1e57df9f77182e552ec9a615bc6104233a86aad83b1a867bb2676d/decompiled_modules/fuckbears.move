module 0x9a5610bd9e1e57df9f77182e552ec9a615bc6104233a86aad83b1a867bb2676d::fuckbears {
    struct FUCKBEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKBEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/hh3cS2RrgGt69bmGjiL7nUi9QaPaKCzKe6cv2VVFUCK.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FUCKBEARS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FUCKBEARS   ")))), trim_right(b"We Bullish Fuck Bears           "), trim_right(x"4c697374656e2075702c20736973736965732e2057657265205349434b20616e64205449524544206f662068656172696e67207468652073616d65207765616b2d617373204655442065766572792073696e676c652074696d6520746865206d61726b657420646970732e0a0a224f6868682062756c6c2072756e206973206f7665722c206f68686820536f6c616e6120697320646f6f6d65642c206f68686820746869732074696d65206974277320646966666572656e742e0a0a20536875742075702e204e6f7468696e6720686173206368616e6765642e2048756d616e73206172652064756d622e2054686579206e65766572206c6561726e2e200a0a42756c6c732057494e2e20426561727320636f70652e204d61726b657473207265636f7665722e20416e64207468652062696767657374206761696e733f2054"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKBEARS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCKBEARS>>(v4);
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

