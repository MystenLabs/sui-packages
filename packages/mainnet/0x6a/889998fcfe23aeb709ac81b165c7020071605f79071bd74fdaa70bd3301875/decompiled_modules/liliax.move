module 0x6a889998fcfe23aeb709ac81b165c7020071605f79071bd74fdaa70bd3301875::liliax {
    struct LILIAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILIAX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/E65V4wNhm2M9siKJc6N1eNHpSYj9Htx3GJvKg7L1pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LILIAX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LILIAX      ")))), trim_right(b"LILIAX AI                       "), trim_right(x"54686520536d6172740a414920417373697374616e740a416c7761797320526561647920746f2048656c700a4c494c49415820697320616e20616476616e63656420414920617373697374616e742064657369676e656420746f2070726f766964652070726163746963616c20616e6420656666696369656e7420736f6c7574696f6e7320666f7220616c6c20796f7572206e656564732e205769746820636f6e74696e756f75736c792065766f6c76696e67206d616368696e65206c6561726e696e67206361706162696c69746965732c204c494c4941582063616e20756e6465727374616e6420616e6420726573706f6e6420746f206120776964652072616e6765206f6620726571756573747320696e20616e20696e7374616e742e205768657468657220666f7220627573696e6573732c20656475636174696f6e2c"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILIAX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILIAX>>(v4);
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

