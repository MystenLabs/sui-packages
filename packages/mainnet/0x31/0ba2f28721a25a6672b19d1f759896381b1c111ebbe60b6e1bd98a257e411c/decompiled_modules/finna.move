module 0x310ba2f28721a25a6672b19d1f759896381b1c111ebbe60b6e1bd98a257e411c::finna {
    struct FINNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINNA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8bmDcRBjBfcoAtU9xFg8gSdUzvjK85cBmdgbMN9kuBLV.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FINNA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FINNA       ")))), trim_right(b"Finna AI                        "), trim_right(b"Finna is an AI-powered food analyzer that helps you understand whats really in your meal. Just snap a photo, and Finna will break down the nutrition facts, health insights, and potential risks  all in seconds. Perfect for anyone who wants to eat smarter and live healthier.                                               "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINNA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINNA>>(v4);
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

