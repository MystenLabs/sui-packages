module 0xca117e1f07c37349f8752e4e10424e8b952bb33a4676f6cae5f1eb44d7e2321::wally {
    struct WALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLY>(arg0, 6, b"WALLY", b"WALLY SUI", b"https://t.me/wallysui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_20_23_13_03_6146816470.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

