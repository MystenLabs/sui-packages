module 0x12199188cd3f84044df7eec970ec08908fc528ed43d709fa81ac4b2caee59e51::suikito {
    struct SUIKITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKITO>(arg0, 0, b"SUIKITO", b"Suikito Token", b"Token simple sans taxe", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIKITO>>(0x2::coin::mint<SUIKITO>(&mut v2, 100000000, arg1), @0xd2b6eb70f627fc078385ee1842991eac7ae7b84425a7380819b2dea3624e035d);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIKITO>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

