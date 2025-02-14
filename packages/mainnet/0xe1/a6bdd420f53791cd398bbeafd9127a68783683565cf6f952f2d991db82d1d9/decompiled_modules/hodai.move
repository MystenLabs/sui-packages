module 0xe1a6bdd420f53791cd398bbeafd9127a68783683565cf6f952f2d991db82d1d9::hodai {
    struct HODAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BwF2MpuDTrmSwB4kNCtKaQmK3T2wpHaoKGBaA5BRpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HODAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HODAI       ")))), trim_right(b"HODAI                           "), trim_right(b"$HODAI is an AI AGENT token created by Kev the Dev while making a video for YouTube. A crazy thing happened.  The AI grew wings and started flying to the moon. Send it!                                                                                                                                                        "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODAI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HODAI>>(v4);
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

