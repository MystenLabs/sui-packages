module 0x3f49e937252989aa749374d50579e94ecc93dc334cd26f3098598691f46830fe::matt {
    struct MATT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MATT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MATT>>(0x2::coin::mint<MATT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MATT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/ENbq7nXqnApZZMdQcNUTqdweHprxqivYmf9n62S2pump.png?size=lg&key=2383c6                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MATT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Matt    ")))), trim_right(b"MattFurie                       "), trim_right(b"Matt Furie, the father of Boys Club and creator of Pepe, Andy, Brett, and Landwolf, has become a memecoin himself! Styled as a green punk icon, hes taking over the crypto scene with boss-level swagger and dominance.                                                                                                         "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MATT>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MATT>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MATT>>(0x2::coin::mint<MATT>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

