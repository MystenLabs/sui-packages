module 0x54abb19b43a06596a75c5d838d1716cef8b0f420b93be5010c9377e744038589::odina {
    struct ODINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODINA>(arg0, 9, b"ODINA", b"Christian ", b"Fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66112dad-c510-4c6f-9e75-4a1803d71559.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ODINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

