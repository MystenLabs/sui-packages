module 0x6dca07178fbd3c5e42c33012df2238f45b446dfdd31f227efd10f054b2507ab7::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5nDSCvBxXY7hEsAbpjJr51WaLDDKgmFjNWAc6wD2pump.png?claimId=eSAwmoP5HNICCEl2                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MOON>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MOON        ")))), trim_right(b"Millionaire Out Of Nowhere      "), trim_right(x"4d696c6c696f6e61697265204f7574204f66204e6f7768657265206973206120636f6d6d756e6974792d72756e206d656d6520636f696e20666f722074686520647265616d6572732c2074686520646567656e732c20616e6420746865206c75636b79206c756e61746963732e20576520646f6e27742070756d702e205765204d4f4f4e2e200a0a4265636f6d652061204d696c6c696f6e61697265204f7574204f66204e6f7768657265202d20416c6c20796f75206861766520746f20646f20697320686f6c64202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOON>>(v4);
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

