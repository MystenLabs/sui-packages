module 0xc819aa02e0eb47d01a683cc06a8ed9a381c994b0ce34bd85d7dd16a4a49c05e6::spl402 {
    struct SPL402 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPL402, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"c943134cc60c7c427a20ddcc73662f5a74410ca089ee841371b8e7a0eb7295ea                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SPL402>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SPL402      ")))), trim_right(b"Solana 402                      "), trim_right(b"HTTP 402 protocol built for Solana from scratch. 4x faster than x402. Live on mainnet. Native Solana payments for API's, Data, MCP, AI Agents. Direct wallet-to-wallet transfers. Zero platform fees.                                                                                                                           "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPL402>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPL402>>(v4);
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

