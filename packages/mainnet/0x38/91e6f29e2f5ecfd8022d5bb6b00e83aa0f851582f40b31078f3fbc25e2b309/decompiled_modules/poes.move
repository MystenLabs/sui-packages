module 0x3891e6f29e2f5ecfd8022d5bb6b00e83aa0f851582f40b31078f3fbc25e2b309::poes {
    struct POES has drop {
        dummy_field: bool,
    }

    fun init(arg0: POES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POES>(arg0, 6, b"POES", b"PAONNES", b"fighter\", warrior confrontation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1761609401210.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

