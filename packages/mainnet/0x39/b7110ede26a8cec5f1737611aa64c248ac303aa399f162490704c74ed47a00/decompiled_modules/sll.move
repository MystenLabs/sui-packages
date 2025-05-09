module 0x39b7110ede26a8cec5f1737611aa64c248ac303aa399f162490704c74ed47a00::sll {
    struct SLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DansfoThnSUZPXnojC4yZJcYtvB1hfMs5xcWwciMpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SLL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Sll         ")))), trim_right(b"Solanallama                     "), trim_right(b"Solana Llama (SLL) is the chillest meme coin on the Solana blockchain!  With blazing-fast transactions and neon-graffiti vibes, this sunglasses-wearing llama brings zero dramajust pure, electric fun. Join the herd for airdrops, fast trades, and a community thats all about chilling to the moon. Ready to vibe with SLL?  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLL>>(v4);
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

