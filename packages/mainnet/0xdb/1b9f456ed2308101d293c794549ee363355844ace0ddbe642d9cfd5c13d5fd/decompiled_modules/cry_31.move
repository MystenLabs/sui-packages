module 0xdb1b9f456ed2308101d293c794549ee363355844ace0ddbe642d9cfd5c13d5fd::cry_31 {
    struct CRY_31 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRY_31, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRY_31>(arg0, 9, b"CRY_31", b"Cry", b"Cry for what", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a27b4571-5a4e-42fe-9eed-e540fe7df237.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRY_31>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRY_31>>(v1);
    }

    // decompiled from Move bytecode v6
}

