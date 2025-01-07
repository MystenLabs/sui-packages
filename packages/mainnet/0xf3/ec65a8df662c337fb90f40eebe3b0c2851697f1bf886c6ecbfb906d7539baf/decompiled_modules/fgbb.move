module 0xf3ec65a8df662c337fb90f40eebe3b0c2851697f1bf886c6ecbfb906d7539baf::fgbb {
    struct FGBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGBB>(arg0, 9, b"FGBB", b"Fhbb", b"Chubb v", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6a3571f-0669-4912-a8b2-039366814272.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FGBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

