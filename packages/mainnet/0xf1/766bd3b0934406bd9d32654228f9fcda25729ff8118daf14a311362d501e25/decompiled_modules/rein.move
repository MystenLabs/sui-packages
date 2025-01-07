module 0xf1766bd3b0934406bd9d32654228f9fcda25729ff8118daf14a311362d501e25::rein {
    struct REIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<REIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<REIN>>(0x2::coin::mint<REIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: REIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Sk4AuXpDyYcCWthSfVB6tdJkwwHQ6CUQQfym5uMpump.png?size=lg&key=f68bc6                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<REIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"REIN    ")))), trim_right(b"Rein The Reindeer               "), trim_right(b"Rein was born during the Great Winter Festival, a magical time when the northern lights illuminate the skies and the forest comes alive with joy. His mother, a gentle reindeer named Glimmer, was the leader of their herd, known for her wisdom and grace.                                                                    "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REIN>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<REIN>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<REIN>>(0x2::coin::mint<REIN>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

