module 0x11f7abe71fa045d3e258d93961d1e31998b4ded84f6e4e7a3bc46ea16003d8ed::pnerd {
    struct PNERD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNERD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafybeieo62xh7qyb2qyirct3kfico3xuuoebyuwkzlaa2jipvgzpwp7quu                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<PNERD>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PNERD   ")))), trim_right(b"Phart Nerd Tokens               "), trim_right(b"I am Pharty McNerdson and the only reason you should buy my token is to make me rich                                                                                                                                                                                                                                            "), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<PNERD>>(0x2::coin::mint<PNERD>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PNERD>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNERD>>(v3);
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

