module 0x31ea34e6f3c31fa16d9963bef0b93a4c3a3bc347459cc6ab67c876e18eeb3d97::ssd {
    struct SSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSD>(arg0, 9, b"SSD", b"Serdit", b"Good morning", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/569df7a2-8b40-4092-9b64-4a37f9c2a868.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

