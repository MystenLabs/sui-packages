module 0x2d7543d9235c017ce24db63c7997de7532437ed9ed8b52b3c846dd6198cdca99::seno {
    struct SENO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENO>(arg0, 9, b"SENO", b"Seno kong", b"Senokong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0b29030-66f4-46bc-92f6-80113fb5b981.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SENO>>(v1);
    }

    // decompiled from Move bytecode v6
}

