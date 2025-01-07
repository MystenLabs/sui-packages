module 0x3e43d1af4d4c7b4dd5b4639146186dea19a5bc852d9df8b826cdc37142a93900::agla {
    struct AGLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGLA>(arg0, 9, b"AGLA", b"PIKACHU ", b"Beautiful meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/519b9f32-2e25-4f7d-a4af-4c331f3b3263.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

