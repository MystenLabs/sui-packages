module 0x8e18a84611aba65600c43f616d2685a9267a5cb802fd4271402951c523546485::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BULL>(arg0, 6, b"BULL", b"BULL", b"@suilaunchcoin $BULL + BULL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"null")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

