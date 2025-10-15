module 0x3f69ce6565e9fe4ea008991124745e36aea6feddd720475ba2033e9888e513ce::drgnbrv {
    struct DRGNBRV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRGNBRV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"742048d56108a01cd4ac5b6557824ebf1fe07d2c22463402c0cbac6920cf1420                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DRGNBRV>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DRGNBRV     ")))), trim_right(b" BRAVE THE DRAGON               "), trim_right(b" BRAVE THE DRAGON ($DRGNBRV)  The Kingdom Has Risen. The Fire Lives Within. From the ashes of delay and doubt, a new legend awakens. Brave the Dragon is not just a token, its a saga of courage, destiny, and power. In this world, only the bold rise to claim the throne. Every holder becomes part of the legend, standing a"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRGNBRV>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRGNBRV>>(v4);
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

