module 0x3811578fe812a28956124904246d0a28b2f7d5c363019f4f8e00e2a8a5e65e6e::megalottoa {
    struct MEGALOTTOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGALOTTOA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6mU21Djay3HqY5wCXh3iCdCxwzHCSR6WTw22e2qHREV.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MEGALOTTOA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MEGALOTTO   ")))), trim_right(b"MEGA LOTTO                      "), trim_right(b"MEGA LOTTO is a cryptocurrency where every transaction contributes a 5% fee to an hourly jackpot. by holding MEGA LOTTO tokens, youre automatically entered for a chance to win. The more you hold, the better your odds  but anyone can win. Transparent, fair, and rewarding, LuckyChain turns every hour into a game of chanc"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGALOTTOA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGALOTTOA>>(v4);
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

