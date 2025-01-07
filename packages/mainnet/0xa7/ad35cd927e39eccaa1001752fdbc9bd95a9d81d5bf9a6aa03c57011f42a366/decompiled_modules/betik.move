module 0xa7ad35cd927e39eccaa1001752fdbc9bd95a9d81d5bf9a6aa03c57011f42a366::betik {
    struct BETIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETIK>(arg0, 9, b"BETIK", b"kak betik ", b"kak betik token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c31a610f-cce0-449a-89b0-a3865aa3295a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BETIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

