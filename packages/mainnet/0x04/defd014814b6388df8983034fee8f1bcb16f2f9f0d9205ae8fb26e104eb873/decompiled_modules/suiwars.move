module 0x4defd014814b6388df8983034fee8f1bcb16f2f9f0d9205ae8fb26e104eb873::suiwars {
    struct SUIWARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWARS>(arg0, 6, b"SUIWARS", b"SuiWars", b"May the gains be with you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731022372767.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIWARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

