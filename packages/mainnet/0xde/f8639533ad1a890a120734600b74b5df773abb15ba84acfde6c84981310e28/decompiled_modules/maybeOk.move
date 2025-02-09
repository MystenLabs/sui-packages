module 0xdef8639533ad1a890a120734600b74b5df773abb15ba84acfde6c84981310e28::maybeOk {
    struct MAYBEOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAYBEOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAYBEOK>(arg0, 8, b"MAYBEOK", b"MAYBEOK", b"this is person test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAYBEOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAYBEOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

