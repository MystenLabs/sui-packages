module 0x25d89ffef58f3f2cbb8a273e7cb078b51499ed9b9f38bf019f52769287a9137d::aimemes {
    struct AIMEMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIMEMES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/APRoR3bJJb4AQdsV2N8ia2kqZ8cmtDTsgSdGVXAvpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AIMEMES>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AiMemes     ")))), trim_right(b"Ai Memes                        "), trim_right(x"414920766964656f2067656e65726174696f6e20697320626c6f77696e672075702062656361757365206974207475726e732073696d706c6520696465617320696e746f2066756c6c20766964656f7320696e207365636f6e64732e200a0a4e6f206275646765742c206e6f2063616d6572612c20616e64206e6f20637265772e204a7573742074797065207768617420796f752077616e7420616e6420697420637265617465732069742e205065726665637420666f72206d656d65732c20736b6974732c2065646974732c206f7220636f6e74656e74207468617420677261627320617474656e74696f6e20666173742e0a0a41492069732074686520667574757265206f6620656e7465727461696e6d656e742e2020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIMEMES>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIMEMES>>(v4);
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

