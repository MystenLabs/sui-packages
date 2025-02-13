module 0xd7ec228529cf07e407e50cc6019d604e936254f6e38b56a3660cde8c7f4e3bb2::pdc {
    struct PDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"Il23Vc15dmcC0Kc-                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PDC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PDC         ")))), trim_right(b"Pepe Durex Coin                 "), trim_right(b"Introducing PepeDurexCoin  the perfect blend of humor, safety, and profit. This Valentines Day, invest in something that protects your future just as Durex protects your love life. With PepeDurexCoin, you're investing in a currency that's as strong as Pepe's optimism and as secure as your most protected moments. Don't "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDC>>(v4);
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

