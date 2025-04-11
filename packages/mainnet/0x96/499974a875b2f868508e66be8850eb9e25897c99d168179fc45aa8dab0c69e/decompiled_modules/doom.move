module 0x96499974a875b2f868508e66be8850eb9e25897c99d168179fc45aa8dab0c69e::doom {
    struct DOOM has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOOM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DOOM>>(0x2::coin::mint<DOOM>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5oE1DPKt1aFS5JUYJxE3HT9hETfqYBP1Tpo8TwWXpump.png?size=lg&key=33efcd                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOOM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DOOM    ")))), trim_right(b"Trumpocalypse                   "), trim_right(b"The year is 2025. The world stands on the edge of chaos. But the people of Springfield saw it coming. Trumpocalypse (DOOM)  not just a meme token, but a monument to the worlds wildest prediction.                                                                                                                             "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOOM>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOOM>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<DOOM>>(0x2::coin::mint<DOOM>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

