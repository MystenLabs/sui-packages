module 0xfa0e8dc3ff7d10c2c085831de101cd0d2ff55c3c1c9df5005e40df84a2b718c8::patriot {
    struct PATRIOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATRIOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"a9611c32a6cc5d923276208e816b864873e1b92f892ec438667b708c0017ac64                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PATRIOT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Patriot     ")))), trim_right(b"Patriot Games                   "), trim_right(b"The Patriot token originated from a post by AFpost highlighting a bold display of American defiance against globalist agendas during a high-stakes political showdown, evoking the thrill of espionage and national pride akin to classic spy thrillers; its logo features a majestic bald eagle soaring amid red, white, and bl"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATRIOT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PATRIOT>>(v4);
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

