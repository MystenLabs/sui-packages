module 0x1d4cfbb25c689a010f4d77863e067dc42bba82d61b4b19623f539543c0040504::virginboss {
    struct VIRGINBOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIRGINBOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/45R3UjVDNa5vwnNTLQ2eFtJtrQSWdkKMaJ9M9AxDyHir.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VIRGINBOSS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VirginBoss  ")))), trim_right(b"Virginia Final BOSS             "), trim_right(b"A vision of modern strength and cutting-edge style. Her confident gaze, framed by sleek, futuristic goggles, suggests a forward-thinking individual ready to embrace new frontiers.                                                                                                                                             "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIRGINBOSS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIRGINBOSS>>(v4);
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

