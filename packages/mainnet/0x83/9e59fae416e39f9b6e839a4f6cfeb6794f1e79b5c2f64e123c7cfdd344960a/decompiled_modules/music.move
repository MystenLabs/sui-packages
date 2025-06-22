module 0x839e59fae416e39f9b6e839a4f6cfeb6794f1e79b5c2f64e123c7cfdd344960a::music {
    struct MUSIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/QmRmLTCSiZNVkbm8RXQggkNhyMyGCpb5cfqCCABk3zhgrU                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MUSIC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MUSIC   ")))), trim_right(b"music.cXc.world                 "), trim_right(b"We send the best from each nation on our music map to the top charts, where listeners put up blinders to focus on their local area, and take charge of what music from their area to show the world. Purely entertainment, not an investment.                                                                                   "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSIC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSIC>>(v4);
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

