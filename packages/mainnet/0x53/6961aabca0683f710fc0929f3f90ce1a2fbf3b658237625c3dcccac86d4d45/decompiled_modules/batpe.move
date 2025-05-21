module 0x536961aabca0683f710fc0929f3f90ce1a2fbf3b658237625c3dcccac86d4d45::batpe {
    struct BATPE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BATPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BATPE>>(0x2::coin::mint<BATPE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BATPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x78814e21549500543587d38e4c88d58e40a38755.png?size=lg&key=e8fe2f                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BATPE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BATPE   ")))), trim_right(b"Batman Pepe                     "), trim_right(b"Born from Gothams shadows and meme magic, Batpe rises as the crypto hero. With wit, courage, and a love for justice, he battles FUD, defeats villains, and leads his community to the moon. This is more than a storyits a revolution                                                                                           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BATPE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BATPE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BATPE>>(0x2::coin::mint<BATPE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

