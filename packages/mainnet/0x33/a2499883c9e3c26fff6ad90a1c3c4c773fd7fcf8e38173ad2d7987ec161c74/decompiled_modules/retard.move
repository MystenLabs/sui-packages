module 0x33a2499883c9e3c26fff6ad90a1c3c4c773fd7fcf8e38173ad2d7987ec161c74::retard {
    struct RETARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARD>(arg0, 6, b"RETARD", b"RETARDcoin", b"Me like to do da Cha Cha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1745518114894.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RETARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

