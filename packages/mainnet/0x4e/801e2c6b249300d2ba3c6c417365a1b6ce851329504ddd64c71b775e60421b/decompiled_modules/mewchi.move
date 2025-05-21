module 0x4e801e2c6b249300d2ba3c6c417365a1b6ce851329504ddd64c71b775e60421b::mewchi {
    struct MEWCHI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEWCHI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MEWCHI>>(0x2::coin::mint<MEWCHI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MEWCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://pbs.twimg.com/profile_images/1925188139012022272/4i3HJQNS_400x400.jpg                                                                                                                                                                                                                                                   ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MEWCHI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MEWCHI  ")))), trim_right(b"MEWCHI                          "), trim_right(b"Welcome to the purr-fect fusion of cuteness and crypto: MewChi! Blending the playful charm of a meowing cat (Mew) with the squishy goodness of mochi (Chi), MewChi is here to warm hearts and shake up the meme coin scene on the Sui Network.                                                                                  "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEWCHI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEWCHI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MEWCHI>>(0x2::coin::mint<MEWCHI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

