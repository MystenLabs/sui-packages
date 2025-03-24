module 0x850be80b508402c7ddadac74b48f0c907abac201e632fc221f687ece9109daf4::zygo {
    struct ZYGO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZYGO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZYGO>>(0x2::coin::mint<ZYGO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ZYGO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/nPfZS2F3g_YfaoEo?width=150&height=150&fit=crop&quality=95&format=auto                                                                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ZYGO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Zygo    ")))), trim_right(b"Zygo the frog                   "), trim_right(b"Original team, Original project now moved to Base, Eth blockchain with lower fees! The complete project, animated series, video game, Zygo AI, Crypto tracker, NFT etc.. lets get to the moon and make meme coins great again!                                                                                                  "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZYGO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ZYGO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<ZYGO>>(0x2::coin::mint<ZYGO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

