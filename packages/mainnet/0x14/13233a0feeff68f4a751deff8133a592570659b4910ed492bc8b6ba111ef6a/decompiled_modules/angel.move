module 0x1413233a0feeff68f4a751deff8133a592570659b4910ed492bc8b6ba111ef6a::angel {
    struct ANGEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGEL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8zp9AtDapxZ3oa5t9Q4aNFhFaHupKZPioVynjoSnpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ANGEL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ANGEL       ")))), trim_right(b"ANGEL_COIN                      "), trim_right(x"414e47454c5f434f494e2028414e47454c290a57656c636f6d6520746f20414e47454c5f434f494e2c20796f7572207469636b657420746f205041524144495345212020414e47454c5f434f494e206f666665727320756e6971756520666561747572657320616e64206f70706f7274756e697469657320666f7220626f746820736561736f6e656420696e766573746f727320616e64206e6577636f6d6572732e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGEL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGEL>>(v4);
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

