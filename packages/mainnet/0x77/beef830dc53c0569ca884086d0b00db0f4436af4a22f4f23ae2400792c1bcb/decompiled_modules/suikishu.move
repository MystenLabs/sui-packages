module 0x77beef830dc53c0569ca884086d0b00db0f4436af4a22f4f23ae2400792c1bcb::suikishu {
    struct SUIKISHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKISHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKISHU>(arg0, 6, b"SUIKISHU", b"SKISHU", b"100000000", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKISHU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKISHU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

