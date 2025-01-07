module 0xcb30d1b38e2d9059ae599662b2f4fdb2f02baeeb1568c1f28854bf6c56a36f4::grim {
    struct GRIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRIM>(arg0, 6, b"GRIM", b"Grim", b"$GRIM - Taking CULT vibe to new depths on Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730716756239.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRIM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

