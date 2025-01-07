module 0xf481eaa21c2e15ba577e6b1f5a84990a941b82c2450cf8ce2ba7d5da6ec8abe5::dgdg {
    struct DGDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGDG>(arg0, 9, b"DGDG", b"Aman", b"Anime dekho jaldi se", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fdf812a6-e569-4767-a965-f1e7eac7da94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

