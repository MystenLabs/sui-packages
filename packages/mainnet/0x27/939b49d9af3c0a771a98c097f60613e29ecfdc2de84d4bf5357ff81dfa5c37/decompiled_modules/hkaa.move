module 0x27939b49d9af3c0a771a98c097f60613e29ecfdc2de84d4bf5357ff81dfa5c37::hkaa {
    struct HKAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HKAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"e53461f71fcb1df8cca62384d421b00e573c816266f66fcb3b15311856334a94                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HKAA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HKAA        ")))), trim_right(b"HypnoKaa                        "), trim_right(b"Kaa is a large, hypnotic python who appears in Rudyard Kipling's original stories and all major adaptations, including the Disney animated films and live-action versions. In Kiplings book, Kaa is actually an ally to Mowgli, while in the Disney versions, Kaa is often portrayed as a comic villain who tries to hypnotize a"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKAA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HKAA>>(v4);
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

