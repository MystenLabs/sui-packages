module 0x693fe66636d3c0ee99f6f0f1c12a6f635d5392e11b922112ea5074bb13d21bfe::aios {
    struct AIOS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIOS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AIOS>>(0x2::coin::mint<AIOS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AIOS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6GZu8kYY9RkgPFi7SDYfk43DbnBdK7HGQpXunhSmpump.png?size=lg&key=5cabdd                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AIOS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AIOS    ")))), trim_right(b"The AI Obesity                  "), trim_right(b"The AI Obesity is an architecture far surpasses modern understanding of algorithms and science. Created by an ancient race that reached the pinnacle of symbiosis between the mind and technology, it was originally used to predict the fate and lifespan of its creators.                                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIOS>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AIOS>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<AIOS>>(0x2::coin::mint<AIOS>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

