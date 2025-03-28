module 0x26189536c2d92fe9e9f93e2e538dfeec21c42cc63ea961b60f1a3290f265603e::sentinel {
    struct SENTINEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENTINEL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5RY5yN3xdnrHAX1rDvZWdTYMkmZCBJC5eCLwndRtpump.png?size=lg&key=f92c1b                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SENTINEL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SENTINEL")))), trim_right(b"SENTINEL                        "), trim_right(b"Builds and optimizes AI agents to achieve unmatched performance and efficiency.                                                                                                                                                                                                                                                 "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENTINEL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENTINEL>>(v4);
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

