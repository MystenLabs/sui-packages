module 0x855d6e6edafcf563f6122ec166afda26d7b4fe411831f4e195a23f4d9d1aa36e::ogai {
    struct OGAI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<OGAI>, arg1: 0x2::coin::Coin<OGAI>) {
        0x2::coin::burn<OGAI>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<OGAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OGAI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: OGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/F4EktiMszSPpEibf3txnzMoehbgR9NTCHYVtfk3SGVYT.png?size=lg&key=c6d9e7                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OGAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OGAI      ")))), trim_right(b"Oogwai                          "), trim_right(b"Incubated by SHIB, Oogwai guides Longevity LLM, to unveil the secrets of longevity and enlighten human beings on ageless mastery, as the first AI Longevity Utility MEME.                                                                                                                                                       "), v2, arg1);
        let v5 = v3;
        let v6 = &mut v5;
        let v7 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v6, 1000000000000000000, v7, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OGAI>>(v5);
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

