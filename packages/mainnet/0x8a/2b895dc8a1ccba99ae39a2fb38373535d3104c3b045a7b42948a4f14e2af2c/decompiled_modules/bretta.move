module 0x8a2b895dc8a1ccba99ae39a2fb38373535d3104c3b045a7b42948a4f14e2af2c::bretta {
    struct BRETTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETTA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DXBYAw9aQheMdujaLZYnVSpKSK4n8jMS7HfLbiv5RWnS.png?claimId=c391ba99c5f4                                                                                                                                                                                                          ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BRETTA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BRETTA      ")))), trim_right(b"Bretta (Brett's Wife)           "), trim_right(b"Bretta's perched on her throne of anticipation, eagerly awaiting Brett's alimony like it's the season finale of her favorite reality show , wondering if it'll pop up before her pet goldfish becomes a viral TikTok sensation with its underwater dance moves!                                                                 "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETTA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETTA>>(v4);
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

