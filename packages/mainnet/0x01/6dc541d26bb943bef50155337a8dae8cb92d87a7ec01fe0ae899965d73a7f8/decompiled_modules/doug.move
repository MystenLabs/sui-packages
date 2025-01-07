module 0x16dc541d26bb943bef50155337a8dae8cb92d87a7ec01fe0ae899965d73a7f8::doug {
    struct DOUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOUG>(arg0, 6, b"DOUG", b"Doug The Dolphin", b"The dope dolphin is coming to turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731004673895.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

