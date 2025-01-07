module 0x7af53e510df09ea6c20c53b12c21da6fb5b811cd4604aa81e8bb340b56a5a15e::gmf {
    struct GMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMF>(arg0, 9, b"GMF", b"GREENMAFIA", b"family is everything...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/455bc078-19bd-45a2-aa79-b0e1446cfae6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GMF>>(v1);
    }

    // decompiled from Move bytecode v6
}

