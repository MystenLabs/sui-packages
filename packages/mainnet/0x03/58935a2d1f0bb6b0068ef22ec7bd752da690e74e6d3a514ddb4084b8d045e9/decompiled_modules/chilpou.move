module 0x358935a2d1f0bb6b0068ef22ec7bd752da690e74e6d3a514ddb4084b8d045e9::chilpou {
    struct CHILPOU has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILPOU>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHILPOU>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CHILPOU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6abzx8ZTLnmS5Yr2JEVSmqp68maxn1cNCu6dxssQpump.png?size=lg&key=0a6420                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<CHILPOU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CHILPOU ")))), trim_right(b"Chill Pou                       "), trim_right(b"Hey, it's me, Chill Pou! Remember me from the game you loved? Now I'm back, cooler than ever, and here to chill with you in the crypto world. I'm all about good vibes, memes, and bringing the fun back to the blockchain. Let's vibe together and make some legendary memories!                                               "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILPOU>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHILPOU>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHILPOU>>(0x2::coin::mint<CHILPOU>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHILPOU>>(v4, 0x2::tx_context::sender(arg1));
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

