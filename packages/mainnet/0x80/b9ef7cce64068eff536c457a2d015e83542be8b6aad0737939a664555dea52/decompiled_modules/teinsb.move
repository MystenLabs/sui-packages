module 0x80b9ef7cce64068eff536c457a2d015e83542be8b6aad0737939a664555dea52::teinsb {
    struct TEINSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEINSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEINSB>(arg0, 9, b"TEINSB", b"benene", b"nsmsm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e91d6a7-22bd-4b24-9cf4-79368cdd3a7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEINSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEINSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

