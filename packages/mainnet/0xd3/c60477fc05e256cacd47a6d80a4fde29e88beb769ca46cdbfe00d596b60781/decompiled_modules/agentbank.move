module 0xd3c60477fc05e256cacd47a6d80a4fde29e88beb769ca46cdbfe00d596b60781::agentbank {
    struct AGENTBANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENTBANK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"3595fe24657ad80311b6c4d0a7bc757dc9e4c6f579b236d5a71569d9852f1b53                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AGENTBANK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AgentBank   ")))), trim_right(b"AgentBank x402 Protocol         "), trim_right(b"AgentBank Protocol provides credit and liquidity to AI agents operating using the x402 protocol. When agents run out of funds, our protocol keeps them working with auto-repayable credit.                                                                                                                                      "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENTBANK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGENTBANK>>(v4);
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

