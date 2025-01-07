module 0xc83f863379fa7c1f393ea9f56b152ca8b4b665af25c12803fc0aaebbb974a130::mycone {
    struct MYCONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYCONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCONE>(arg0, 6, b"MYCONE", b"MYCONE Task 2", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

