module 0x51ccbd41c80730d0ebc669adf97aa8b5c85f9b9e344b8c95accb9fc2878d2c8a::whackd {
    struct WHACKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHACKD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9J9fvfK8EBse4UmrRmEue5cVrWjNMXkNShM17ZaJpump.png?claimId=8ouvzLieil9F0y4X                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WHACKD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WHACKD      ")))), trim_right(b"whacked                         "), trim_right(x"4a6f686e206c61756e63686564207468652024574841434b4420746f6b656e207769746820746865207461676c696e650a0a4570737465696e206469646e74206b696c6c2068696d73656c662c0a0a546865206e616d6520636f6d65732066726f6d20776861636b65642c206d65616e696e67206b696c6c65642e0a0a4d6341666565206576656e20676f7420697420746174746f6f65642e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHACKD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHACKD>>(v4);
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

