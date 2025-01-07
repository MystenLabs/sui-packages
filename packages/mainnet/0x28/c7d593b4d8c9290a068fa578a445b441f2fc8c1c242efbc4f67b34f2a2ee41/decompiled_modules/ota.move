module 0x28c7d593b4d8c9290a068fa578a445b441f2fc8c1c242efbc4f67b34f2a2ee41::ota {
    struct OTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTA>(arg0, 9, b"OTA", b"OTAKU", b"OTAKU JAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eda7d15e-0753-4cb3-abd8-9198487345ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

