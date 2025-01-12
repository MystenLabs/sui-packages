module 0x8c5296a5a9ca04b9556b2629bf05bbd9d084baf184eea429bf4e3cef0e6d9e1d::pwh {
    struct PWH has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PWH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PWH>>(0x2::coin::mint<PWH>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PWH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EaGaNNrYgWeGuYuzFdHXA8ciyAvtu8PBHub1Te6XTTPu.png?size=lg&key=8bd78a                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PWH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PWH     ")))), trim_right(b"Pepe Wif Hat                    "), trim_right(b"The Legendary Frog has put on the Legendary Hat and is ready to take the world by storm!Pepe Wif Hat is the meme to rule them all, a perfect combination of the greatest memes,ready to conquer heights not seen before in the memecoin world                                                                                   "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWH>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PWH>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PWH>>(0x2::coin::mint<PWH>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

