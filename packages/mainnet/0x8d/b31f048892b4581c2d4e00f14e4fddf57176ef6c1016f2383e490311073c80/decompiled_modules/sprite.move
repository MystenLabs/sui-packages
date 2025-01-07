module 0x8db31f048892b4581c2d4e00f14e4fddf57176ef6c1016f2383e490311073c80::sprite {
    struct SPRITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRITE>(arg0, 9, b"SPRITE", b"SPRITE", b"Sprite Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPRITE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRITE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPRITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

