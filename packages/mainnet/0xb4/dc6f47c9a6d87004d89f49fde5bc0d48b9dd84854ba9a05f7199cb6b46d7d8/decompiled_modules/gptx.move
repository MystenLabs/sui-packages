module 0xb4dc6f47c9a6d87004d89f49fde5bc0d48b9dd84854ba9a05f7199cb6b46d7d8::gptx {
    struct GPTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPTX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3JQSDD55hkEG1KoCUAijLtEgaLzq8soGugMEcfFQk12f.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GPTX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GPTX        ")))), trim_right(b"GPTToken                        "), trim_right(b"We train an Army or Swarm of AI Agents to trade the Crypto market and bring profits in one wallet , every 24 hours . we reward our holder with frequent buybacks and burns of our GPTX .    Will burn GPTX tokens  every 2 weeks    on Mondays .                                                                                "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPTX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GPTX>>(v4);
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

