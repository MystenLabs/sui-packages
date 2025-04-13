module 0xf3cb649ead05881990c0bfbfe53c9c128e1cba4a4dc0ff13c09a04626eb4e3ac::lofiwifhat {
    struct LOFIWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFIWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOFIWIFHAT>(arg0, 0, b"LOFIWIFHAT", b"Lofiwifhat Token", b"Token simple sans taxe", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<LOFIWIFHAT>>(0x2::coin::mint<LOFIWIFHAT>(&mut v2, 100000000, arg1), @0xd2b6eb70f627fc078385ee1842991eac7ae7b84425a7380819b2dea3624e035d);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LOFIWIFHAT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOFIWIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

