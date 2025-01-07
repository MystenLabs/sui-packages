module 0x5fdc9ca9de9e514fb8e368a933a34d027ea383820cbe7932e1b44c8f692e33a6::bad {
    struct BAD has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BAD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BAD>>(0x2::coin::mint<BAD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x32b86b99441480a7e5bd3a26c124ec2373e3f015.png?size=lg&key=82d5ac                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BAD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BAD     ")))), trim_right(b"BAD IDEA AI                     "), trim_right(b"Bad Idea AI ($BAD), an official partner of Shiba Inu, is a decentralized experiment that combines Blockchain, AI, and DAOs in a risky, meme-worthy concoction. From robotic personal assistants to self-driving cars, AI technology has infiltrated every aspect of our lives, leaving us both awestruck and anxious.           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAD>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BAD>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BAD>>(0x2::coin::mint<BAD>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

