module 0x5d3025a25998a1fb28e0250c46d7b70600921f061b0663ad99066fc00e6c0515::grimmy {
    struct GRIMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2B83eodck3HxjbvZpJibsazGWwyFuS1o1i8nPfKApump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GRIMMY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GRIMMY      ")))), trim_right(b"Grimmy Inu                      "), trim_right(b"Grimmy Inu is a meme-inspired cryptocurrency aiming to bring humor, community-driven development, and long-term utility to the blockchain space. Drawing from the popular dog-themed meme coin culture, Grimmy Inu differentiates itself through transparency, community engagement, and sustainable growth strategies rather th"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIMMY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRIMMY>>(v4);
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

