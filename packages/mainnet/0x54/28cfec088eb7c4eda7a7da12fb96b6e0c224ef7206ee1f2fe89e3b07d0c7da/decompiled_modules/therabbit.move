module 0x5428cfec088eb7c4eda7a7da12fb96b6e0c224ef7206ee1f2fe89e3b07d0c7da::therabbit {
    struct THERABBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: THERABBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8mUp1qQCxSNjnWKn4euUbHNC4ebxhvwMufSner3tpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<THERABBIT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"THERABBIT   ")))), trim_right(b"The Rabbit Hole                 "), trim_right(x"57656c636f6d6520746f2052616262697420486f6c65204d656469612c207468652066697273742032342f372063727970746f206e657773206f75746c65742e20537570706f7274207573206f6e2074686973206a6f75726e657920616e6420676f20677261622024544845524142424954200a0a284261736564206f6e205468652052616262697420486f6c65202d20456c6f6e204d75736b277320736563726574206163636f756e742920202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THERABBIT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THERABBIT>>(v4);
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

