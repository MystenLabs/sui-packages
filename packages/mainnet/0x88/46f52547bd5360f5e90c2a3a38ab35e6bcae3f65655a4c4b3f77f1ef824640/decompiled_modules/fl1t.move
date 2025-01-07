module 0x8846f52547bd5360f5e90c2a3a38ab35e6bcae3f65655a4c4b3f77f1ef824640::fl1t {
    struct FL1T has drop {
        dummy_field: bool,
    }

    fun init(arg0: FL1T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FL1T>(arg0, 9, b"FL1T", b"Fl1lt", b"Fl1t bl1k ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd70c041-c240-4bce-bafa-12dd879c2f82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FL1T>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FL1T>>(v1);
    }

    // decompiled from Move bytecode v6
}

