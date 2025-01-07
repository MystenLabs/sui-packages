module 0xb71fb5075cf95b03009bc43169a70b6c14651d88658f7dc2e78fd0c91f1c29d6::sbkabosu {
    struct SBKABOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBKABOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x216daa111d9e25b6cc4e0c92a407467e287d459c.png?size=lg&key=003d27                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SBKABOSU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SBKabosu")))), trim_right(b"Baby Kabosu                     "), trim_right(b"BABY KABOSU is the next chapter in the legacy of Kabosu, the legendary Shiba Inu who stole the hearts of millions as the face of the iconic Doge meme. She became an internet sensation when her quirky, sideways glance went viral in 2010.                                                                                    "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBKABOSU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBKABOSU>>(v4);
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

