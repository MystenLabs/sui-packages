module 0x80fddd3b859ecd9f45cbc453c455ebf6d7a1cfb3b30df90927aab333e33270d8::boden {
    struct BODEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BODEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BODEN>(arg0, 4, b"BODEN", b"Joe Boden", b"First crypto ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imagedelivery.net/cBNDGgkrsEA-b_ixIp9SkQ/btc.png/public")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BODEN>(&mut v2, 33300000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BODEN>>(v2, @0x94fbcf49867fd909e6b2ecf2802c4b2bba7c9b2d50a13abbb75dbae0216db82a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BODEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

