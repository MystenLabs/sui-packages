module 0x58dfb287c749b91ed8adb55cca3488b2077e31f83c02cd716ecf7a037d98a13a::bkri {
    struct BKRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKRI>(arg0, 9, b"BKRI", b"Bakri", b"Bakri is native name of goat in Urdu language.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/726f2482-aa55-4a92-9ac4-608c31fa8bd0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKRI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BKRI>>(v1);
    }

    // decompiled from Move bytecode v6
}

