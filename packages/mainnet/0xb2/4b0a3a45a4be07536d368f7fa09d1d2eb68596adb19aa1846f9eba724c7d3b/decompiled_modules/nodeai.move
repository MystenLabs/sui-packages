module 0xb24b0a3a45a4be07536d368f7fa09d1d2eb68596adb19aa1846f9eba724c7d3b::nodeai {
    struct NODEAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NODEAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NODEAI>>(0x2::coin::mint<NODEAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NODEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7nhddLBbPas6FmFQAM7xeysLQQgx8AtNj135K3chpump.png?size=lg&key=d631fe                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NODEAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NODEAI  ")))), trim_right(b"Node Frame AI                   "), trim_right(b"Node Frame is an agent infrastructure platform that enables swarms of autonomous agents to collaborate, adapt, and excel in decentralized systems.                                                                                                                                                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NODEAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NODEAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<NODEAI>>(0x2::coin::mint<NODEAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

