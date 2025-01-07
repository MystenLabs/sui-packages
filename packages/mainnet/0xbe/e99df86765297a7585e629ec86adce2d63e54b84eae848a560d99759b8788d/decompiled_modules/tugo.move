module 0xbee99df86765297a7585e629ec86adce2d63e54b84eae848a560d99759b8788d::tugo {
    struct TUGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUGO>(arg0, 8, b"BEEP", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

