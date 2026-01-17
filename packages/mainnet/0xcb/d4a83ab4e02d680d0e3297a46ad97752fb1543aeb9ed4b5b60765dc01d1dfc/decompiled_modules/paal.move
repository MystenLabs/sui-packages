module 0xcbd4a83ab4e02d680d0e3297a46ad97752fb1543aeb9ed4b5b60765dc01d1dfc::paal {
    struct PAAL has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PAAL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAAL>>(0x2::coin::mint<PAAL>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PAAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/056a9989b5d8163da103629fbfbcbe63579c3071ad1080431c6b63ed9359fb9c?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PAAL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PAAL    ")))), trim_right(b"PAAL AI                         "), trim_right(b"Powerful AI ecosystem built using Custom Data Feed and LLMs. Personalize your AI & share across all web platforms.                                                                                                                                                                                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAAL>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PAAL>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PAAL>>(0x2::coin::mint<PAAL>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

