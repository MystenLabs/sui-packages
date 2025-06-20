module 0x3934b6aacf10991434c776de257e773692cd3b8ec9fc1613a2388e2c1efb36d0::brain {
    struct BRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5v52p7WQTVgR9N2Xmk3zhCQk3ThxR4Ut7k8Ff33xpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BRAIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BRAIN       ")))), trim_right(b"BRAINFART                       "), trim_right(b"Spawned of late-night shitposts and impulsive trades, $BRAIN isnt here to make sense its here to stink up your portfolio and brain cells at the same time. Forget roadmaps, whitepapers, or logic. Brainfart is pure madness, launched from the depths of the internet straight into the blockchain void. Think its dumb? Good. "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAIN>>(v4);
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

