module 0x52a8a37b69d915070d5980b55e777868b4f9584a1cba1a63074d9265a9d138cc::squish {
    struct SQUISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUISH>(arg0, 6, b"SQUISH", b"Squish ", b"The most Inky Octo-pal, Squishy, squishy, Sui's new buddy. Your eight-armed guide to the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730988286645.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

