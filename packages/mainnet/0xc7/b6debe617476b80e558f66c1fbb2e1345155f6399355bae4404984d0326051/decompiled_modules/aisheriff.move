module 0xc7b6debe617476b80e558f66c1fbb2e1345155f6399355bae4404984d0326051::aisheriff {
    struct AISHERIFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISHERIFF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"07b8e3d14581e930ac2f785d37ab31e2cb7f5c453d85fb53025cae5629a25185                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AISHERIFF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AISHERIFF   ")))), trim_right(b"AI Sheriff                      "), trim_right(b"From devs to devs. Animated console streamer that roleplays an anime-styled sheriff while scanning Memecoins for freshly created coins. It automates multiple browsers (Dexscreener, Axiom, Solscan, Pump Fun chat), evaluates coins via a local LLM (Microsoft AI Foundry Local), and renders big ASCII-art Uanimations.       "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISHERIFF>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AISHERIFF>>(v4);
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

