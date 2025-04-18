module 0xb5614b4f11514d48ff917719f1ee373529cc41049210f9268d3ce784c23a85a5::spark {
    struct SPARK has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SPARK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SPARK>>(0x2::coin::mint<SPARK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SPARK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6x29W6h2W7xCrTMYumDxxMdCajqhNfRV9ffzff5SGoLD.png?size=lg&key=ab9175                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SPARK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SPARK   ")))), trim_right(b"Agentic Spark                   "), trim_right(b"Next-Gen Agentic Launchpad - From Web2 chains to Agentic freedom. Escape the algorithm. Escape the middlemen. We empower creators, businesses, and builders to thrive in this new era.                                                                                                                                          "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPARK>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SPARK>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SPARK>>(0x2::coin::mint<SPARK>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

