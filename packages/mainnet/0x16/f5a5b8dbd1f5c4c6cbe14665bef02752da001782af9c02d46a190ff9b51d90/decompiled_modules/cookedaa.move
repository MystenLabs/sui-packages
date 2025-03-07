module 0x16f5a5b8dbd1f5c4c6cbe14665bef02752da001782af9c02d46a190ff9b51d90::cookedaa {
    struct COOKEDAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOKEDAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"wAgXhJd__yKz-aaF                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<COOKEDAA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Cooked      ")))), trim_right(b"HumanityIsCooked                "), trim_right(x"2448756d616e6974794973436f6f6b65642069736e74206a757374206120746f6b656e2c2069747320612077616b652d75702063616c6c207772617070656420696e2061206d656d652e204173206172746966696369616c20696e74656c6c6967656e636520726163657320616865616420666173746572207468616e206f7572206162696c69747920746f20636f6e74726f6c2069742c207468697320636f696e20737061726b73206120676c6f62616c20636f6e766572736174696f6e2061626f757420412e492e20616c69676e6d656e742c20746865207269736b73206f662072756e61776179207375706572696e74656c6c6967656e63652c20616e6420776865746865722068756d616e6974792068617320616c726561647920636f6f6b656420697473206f776e20666174652e0d0a0d0a57686174202448756d"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOKEDAA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOKEDAA>>(v4);
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

