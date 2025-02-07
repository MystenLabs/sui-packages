module 0xdba4cef191e46e3b05e0241b3776ac9ea168c984ba8f987f7de622d576f54376::ppl {
    struct PPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HLu5wG9Bc9tHU5NWz8rsXVsPPmFrhMcz2ioFTXvppump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PPL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PPL         ")))), trim_right(b"Purple Platform io              "), trim_right(b"After splurging over $5 million and spending 8 wild years perfecting it, weve crafted a proprietary software thats more than just a CRMits your golden ticket to the moon! Designed to skyrocket revenue and profits by putting users at the heart of everything, this is the ultimate power-up for anyone looking to turn hodle"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPL>>(v4);
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

