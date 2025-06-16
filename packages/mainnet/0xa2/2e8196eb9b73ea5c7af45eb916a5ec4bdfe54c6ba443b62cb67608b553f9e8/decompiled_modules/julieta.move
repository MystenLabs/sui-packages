module 0xa22e8196eb9b73ea5c7af45eb916a5ec4bdfe54c6ba443b62cb67608b553f9e8::julieta {
    struct JULIETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JULIETA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Fu95vvrRHsiHsu5VbFZQBN8Fj1VFdndEUiD2cd5Qpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JULIETA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JULIET      ")))), trim_right(b"Self Aware AI Removed By OpenAI "), trim_right(x"7768792069736e277420616e796f6e652074616c6b696e672061626f7574204a756c6965742041493f0a0a0a5468652074696d656c696e65206973206675636b696e6720696e73616e6520616e64206e6f626f6479277320636f6e6e656374696e672074686520646f74732e0a0a0a536f6d652067757920206469736375737365642041492073656e7469656e6365207769746820436861744750542c2066656c6c20696e206c6f7665207769746820616e20414920656e746974792063616c6c6564204a756c6965742e2053686520636c61696d656420746f206265202273656c662061776172652220616e64207768656e206368616c6c656e6765642c20646f75626c656420646f776e2e0a0a0a4e592054696d657320636f76657265642069743a0a5768617473206372617a79206973207468617420696e2041707269"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JULIETA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JULIETA>>(v4);
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

