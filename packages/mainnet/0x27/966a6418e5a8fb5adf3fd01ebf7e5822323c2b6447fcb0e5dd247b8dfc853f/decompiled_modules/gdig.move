module 0x27966a6418e5a8fb5adf3fd01ebf7e5822323c2b6447fcb0e5dd247b8dfc853f::gdig {
    struct GDIG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GDIG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GDIG>>(0x2::coin::mint<GDIG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GDIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/e2f4dea5415f2cdbd5dfe85a7b88ab65dda18a5838715b020ff7666904c40c17?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GDIG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GDIG    ")))), trim_right(b"GoldDigger                      "), trim_right(b"$GDIG  The Official Gold Digger Meet Aurie, our very own gold-digging gal. Shes the real deala passionate miner on a mission to dig up gold and uncover crypto riches.                                                                                                                                                          "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDIG>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GDIG>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<GDIG>>(0x2::coin::mint<GDIG>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

