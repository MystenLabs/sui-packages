module 0xfdde1bba0ab0da110554ceed17b587999301c0a2c9952e663891fca2d0860a6f::wdym {
    struct WDYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDYM>(arg0, 6, b"WDYM", b"What doo you mean?", b"What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? What doo you mean? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/maxresdefault_322ea697ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDYM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WDYM>>(v1);
    }

    // decompiled from Move bytecode v6
}

