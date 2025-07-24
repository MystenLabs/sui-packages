module 0xb41abdd6d646362cd183af0e01fb51aa5923d39d24232a9cc84370f2593aa3d4::msg {
    struct MSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AptX3ut9fj787mTzjVm7wTgd6qfKrcpwMgAgHvhwfSQi.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MSG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MSG         ")))), trim_right(b"Myspace Girls                   "), trim_right(x"4d797370616365204769726c732069732061206d656d6520636f696e2078206d656469612068756220666f7220776f6d656e2063726561746f72732e20546f6b656e2d706f77657265642e2053747265616d2d6675656c65642e2046756c6c79206368616f7469632e200a0a4265666f726520496e7374616772616d2e204265666f72652054696b546f6b2e204265666f7265204f6e6c7946616e732e2e2e20746865726520776173204d79537061636521204265206f757220746f70203820686f6c6465722120202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSG>>(v4);
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

