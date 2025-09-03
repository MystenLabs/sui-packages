module 0xbb46f4487fcdc94ff3f92cd0161478e7ea2eb8062467286d6798f58fbecef73f::milo {
    struct MILO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/JDvsf5t2R7KDF66eBP566RSyLoK9X5UQdjmLGR1iMBU1.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MILO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MILO        ")))), trim_right(b"MILO                            "), trim_right(b"Here lives MILO, the playful spirit of the forest. He doesnt keep records or guard treasureshe dances between trees of charts, hides jokes behind glowing candles, and shows travelers paths no map could ever mark.                                                                                                            "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILO>>(v4);
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

