module 0x5ae7fbc9965c7af5d9c4284ca046ead8512018ba38d919b911ee3a56f7d003b1::hoppy {
    struct HOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8biCUXyVydbEqX36W7KfUwu6yfsC5sADHf9aU5FFpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HOPPY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Hoppy       ")))), trim_right(b"Hoppy                           "), trim_right(b"Welcome to the world of Hoppy, a vibrant and adventurous memecoin inspired by the whimsical frog character from Matt Furies 2012 comic book The Night Riders. Hoppy reborn with his iconic green skin & curious spirit, embodies the joy of exploration and the magic of imagination. This memecoin isnt just a tokenits a celeb"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPY>>(v4);
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

