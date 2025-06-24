module 0x61a4913c06d53a1a29396e3510318765dd7682d961d49da099d61333ce7d9084::gilbert {
    struct GILBERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GILBERT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FoiPz4f17hZiRUbQUf3YjtP59475osco2zdeadndGwya.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GILBERT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GILBERT     ")))), trim_right(b"Gilbert The Dragon              "), trim_right(x"57686f20776f756c6420686176652074686f75676874207468617420616e206578706c616e6174696f6e2061626f75742070726f76696e6720736f6d657468696e6720776f756c64206861766520696e616476657274656e746c79207475726e656420696e746f2070656f706c65206372656174696e672061206d656d6520636f696e2061626f75742069742e0a0a416c6c206861696c2047696c626572742c2074686520647261676f6e20696e206f7572206c6169722e0a0a5765206172652047696c626572742c2047696c62657274206973207573202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GILBERT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GILBERT>>(v4);
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

