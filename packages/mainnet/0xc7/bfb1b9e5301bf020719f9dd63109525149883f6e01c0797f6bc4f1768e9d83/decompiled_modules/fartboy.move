module 0xc7bfb1b9e5301bf020719f9dd63109525149883f6e01c0797f6bc4f1768e9d83::fartboy {
    struct FARTBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/y1AZt42vceCmStjW4zetK3VoNarC1VxJ5iDjpiupump.png?claimId=bs8E-SpfD596DDXT                                                                                                                                                                                                       ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FARTBOY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FARTBOY     ")))), trim_right(b"FARTBOY                         "), trim_right(x"4c61756e63686564206f6e204a616e75617279203574682c2046415254424f59207761732072756767656420627920697473206f726967696e616c20646576656c6f7065722c206275742074686520726573696c69656e7420436f696e734b696420636f6d6d756e69747920746f6f6b206f7665722c2072657669766564207468652070726f6a6563742c20616e64207472616e73666f726d656420697420696e746f20612073796d626f6c206f66206f7267616e69632067726f77746820616e6420636f6d6d756e6974792d64726976656e20737472656e6774682e0a0a5468652070726f6a65637420647261777320696e737069726174696f6e2066726f6d2046617274626f792c207468652068696c6172696f757320616e6420706f70756c6172206368696c6472656e7320626f6f6b20736572696573206279204164"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTBOY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTBOY>>(v4);
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

