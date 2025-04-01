module 0x3a754d7e027a06281f5eeba026e49fc9b586be1cb247473881546a0ddb9f202::czsol {
    struct CZSOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZSOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5dfjRH2gPwP7qPjLB4xkYmH22dxvB4itpfywexFLU5hc.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CZSOL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CZSOL       ")))), trim_right(b"CZ Ghibli Solana Rewards        "), trim_right(x"435a20474849424c4920534f4c414e4120524557415244532028435a20476869626c6929200a697320616e20696e6e6f76617469766520746f6b656e206f6e2074686520536f6c616e6120626c6f636b636861696e2c2064657369676e656420746f207265776172642069747320636f6d6d756e6974792077697468206578636c757369766520616e6420666173742062656e65666974732e204a6f696e20757320616e64207365697a6520746865206f70706f7274756e69746965732120202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZSOL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZSOL>>(v4);
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

