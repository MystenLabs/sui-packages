module 0x5ddbac581737de19918b1964af0aff804fb8df19a45303802c37ea96c095a898::poppy {
    struct POPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPPY>(arg0, 9, b"POPPY", b"Puppy", b"Cute long ear puppy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/48a59b7d-249d-4602-afaf-451f8a4dea78.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

