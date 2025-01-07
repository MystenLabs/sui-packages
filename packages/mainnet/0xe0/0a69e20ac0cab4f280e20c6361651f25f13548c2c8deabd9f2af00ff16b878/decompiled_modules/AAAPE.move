module 0xe00a69e20ac0cab4f280e20c6361651f25f13548c2c8deabd9f2af00ff16b878::AAAPE {
    struct AAAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAPE>(arg0, 2, b"AAAPE", b"AAAPE", b"Ape gonna AAAPE on sui, https://aape.jp/, https://twitter.com/search?q=YOU%20JUST%20NEED%20TO%20FUCKIN%20AAAPE&src=typed_query", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/mgjzQpHD/aaape-Asset-2-300x.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAAPE>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAAPE>(&mut v2, 100000000000, @0x60ff6735d1330e1ee0dfd56b79ee32f120b60ff46b4681cf7a098e77bb9e61f5, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAPE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

