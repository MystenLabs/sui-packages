module 0x7db8bdaf54d0a59809c437a86863976a0c0dc3ed8eb70f714fbfd8b7ad29048a::l24ai {
    struct L24AI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<L24AI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<L24AI>>(0x2::coin::mint<L24AI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: L24AI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CMDKx3TGVJryRDQ2MnAkTRNSyguQLrKgiCPZ3Jc6r8r2.png?size=lg&key=2f096a                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<L24AI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"L24AI   ")))), trim_right(b"L24AI AGENT                     "), trim_right(b"unleashes AI-powered Twitter agents to supercharge your token launch or meme coin. @L24AIAGENT Automate community engagement, outreach, and content creation. Maximize your impact with 24/7 AI-driven growth.                                                                                                                  "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L24AI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<L24AI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<L24AI>>(0x2::coin::mint<L24AI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

