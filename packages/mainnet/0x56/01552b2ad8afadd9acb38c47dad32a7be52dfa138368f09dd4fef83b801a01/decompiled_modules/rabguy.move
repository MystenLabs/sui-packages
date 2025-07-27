module 0x5601552b2ad8afadd9acb38c47dad32a7be52dfa138368f09dd4fef83b801a01::rabguy {
    struct RABGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6TRuKnjqCV1XXfS4kG8M8C48yqESL2vyDfNX2Pbp7WKC.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RABGUY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RABGUY      ")))), trim_right(b"Raccoon Baby Guy                "), trim_right(b"Rabguy: The slickest baby raccoon meme coin on Solana!  Launched with high-energy community vibes, Rabguys all about fun and potential gains. No utility, no roadmappure meme-driven hype. Check the CA and join the trash panda crew to moon!  #RABGUY #SolanaHype                                                             "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABGUY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RABGUY>>(v4);
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

