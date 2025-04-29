module 0x1433ef0ec0d4f07c31eb75e7b143e7aa372ebc48ebefab19ca4b9fed8127bc7a::spectre {
    struct SPECTRE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SPECTRE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SPECTRE>>(0x2::coin::mint<SPECTRE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SPECTRE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x9cf0ed013e67db12ca3af8e7506fe401aa14dad6.png?size=lg&key=bc5f4b                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SPECTRE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SPECTRE ")))), trim_right(b"SPECTRE AI                      "), trim_right(b"Spectre AI is a Web3 startup that provides crypto traders and investors with all essential tools and AI-powered products for crypto market research. We are here to help you navigate the crypto market by offering a suite of Sentiment, Technical, and On-Chain tools powered by AI.                                          "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPECTRE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SPECTRE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SPECTRE>>(0x2::coin::mint<SPECTRE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

