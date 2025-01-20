module 0x4fd81bee7b8e550aa25f8cceef1e29dc7390b2bf318e262509586a4a534c648e::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELANIA>(arg0, 6, b"MELANIA", b"Wrapped Coin for Melania", b"Sudo Wrapped Coin for Official Melania", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MELANIA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MELANIA>>(v0);
    }

    // decompiled from Move bytecode v6
}

