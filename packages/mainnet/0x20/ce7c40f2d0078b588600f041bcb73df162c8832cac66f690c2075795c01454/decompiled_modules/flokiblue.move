module 0x20ce7c40f2d0078b588600f041bcb73df162c8832cac66f690c2075795c01454::flokiblue {
    struct FLOKIBLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKIBLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKIBLUE>(arg0, 0, b"FLOKIBLUE", b"Flokiblue", b"Token simple sans taxe", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FLOKIBLUE>>(0x2::coin::mint<FLOKIBLUE>(&mut v2, 100000000, arg1), @0xd2b6eb70f627fc078385ee1842991eac7ae7b84425a7380819b2dea3624e035d);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FLOKIBLUE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOKIBLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

