module 0x8640b0da7d113392aa02ebcc5ba1f7aed75e1b4a5d8465d3d5c794414d58a12c::elmo {
    struct ELMO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ELMO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ELMO>>(0x2::coin::mint<ELMO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ELMO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GUay2sbTzeanKsQK1coWSzoQXDRUw9mbnfb1gVMLpump.png?size=lg&key=7a4254                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ELMO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ELMO    ")))), trim_right(b"ELMO                            "), trim_right(b"ELMO, a meme coin crafted by a dedicated team of 10 talented developers. ELMO is set to shake up the crypto landscape and become a standout choice for investors everywhere. We believe that with the right community and strategy, even a small coin can achieve phenomenal success!                                           "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELMO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ELMO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<ELMO>>(0x2::coin::mint<ELMO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

