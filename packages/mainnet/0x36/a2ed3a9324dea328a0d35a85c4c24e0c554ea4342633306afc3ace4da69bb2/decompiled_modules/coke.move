module 0x36a2ed3a9324dea328a0d35a85c4c24e0c554ea4342633306afc3ace4da69bb2::coke {
    struct COKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8RmnamsR4gviq4f5nzdLzsD9SZBy19FLkGDWZsW1v1b4.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<COKE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"COKE        ")))), trim_right(b"Coke on Solana                  "), trim_right(x"47756573732077686f73206261636b2c206261636b20616761696e2121210a0a57657265206261636b21212121200a4f726967696e616c2044657620616e6420726576616d706564207465616d2072756e6e696e67207468697320746f2077686572652069742062656c6f6e67732e20537461792074756e6564206173207468697320697320696e73706972656420627920436f63612d436f6c6120746865206e756d626572206f6e6520736f6674206472696e6b20696e2074686520776f726c642e20546865206578706c6f73696f6e20726570726573656e74732074686520626164206163746f727320616e64206a65657473206173207468652070726f6a65637420736f617273206f6e20746f206e6577206865696768747320796f757665206e6576657220696d6167696e65642e204275636b6c6520757020626563"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COKE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COKE>>(v4);
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

