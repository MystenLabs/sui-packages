module 0x464df843da930a78388e26c4a26ac1f9a0224bca5689557e9cb6d0c2f7a74cc9::yushi {
    struct YUSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUSHI>(arg0, 6, b"YUSHI", b"Yushi", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YUSHI>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUSHI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YUSHI>>(v2);
    }

    // decompiled from Move bytecode v6
}

