module 0xab3c8cc8ed0783a31974c2941cbfac1ac560c58c8c8bfe9112a8e8cd8196ccbb::suivrus {
    struct SUIVRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVRUS>(arg0, 0, b"SUIVRUS", b"SuiVrus", b"Token simple sans taxe", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIVRUS>>(0x2::coin::mint<SUIVRUS>(&mut v2, 100000000, arg1), @0xd2b6eb70f627fc078385ee1842991eac7ae7b84425a7380819b2dea3624e035d);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIVRUS>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIVRUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

