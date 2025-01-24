module 0xf68c5e0dddc0168d567e668bf6bc265895da31ef8ce445a7288aff902aa6e57a::msn {
    struct MSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2XSEKTd9A5xMeGM72YxUxCFZFP3DpHQfcBykvkkypump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MSN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MSN         ")))), trim_right(b"MSN Messenger                   "), trim_right(b"Before Facebook and the social media hype, people used to communicate through MSN. Youd run home after school, turn on your ADSL router, and hope the phone wouldnt ring, or the internet wouldnt disconnect when it did. Then, youd chat with all your friends in Comic Sans, while that famous MSN bell jingle echoed every ti"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSN>>(v4);
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

