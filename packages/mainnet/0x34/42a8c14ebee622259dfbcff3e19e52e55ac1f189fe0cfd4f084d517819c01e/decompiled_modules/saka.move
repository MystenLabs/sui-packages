module 0x3442a8c14ebee622259dfbcff3e19e52e55ac1f189fe0cfd4f084d517819c01e::saka {
    struct SAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HVMJ9aoJnW4cZCMkRGZj3GynkhXG64pwEAUxPbDapump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SAKA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SAK         ")))), trim_right(b"SCAMMING ASS KAVELL             "), trim_right(b"The Official MEME for THE PEOPLE who have been scammed and rugged by Kavell. This is the post-apocalypse of the Kavell experience. He kept taking advantage of the people who believed in him and trusted him. We decided to launch our meme. Pure momentum, community-driven with NFTs down the line. SEND IT!!! We stand with "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAKA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAKA>>(v4);
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

