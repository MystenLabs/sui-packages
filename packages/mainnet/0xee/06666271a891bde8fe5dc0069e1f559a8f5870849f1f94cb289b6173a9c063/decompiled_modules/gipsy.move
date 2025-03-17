module 0xee06666271a891bde8fe5dc0069e1f559a8f5870849f1f94cb289b6173a9c063::gipsy {
    struct GIPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIPSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIPSY>(arg0, 9, b"GIPSY", b"Gipsy", b"Gipsy Danger coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/756aea8d-a0da-4a51-a8af-853b1e949604.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIPSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIPSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

