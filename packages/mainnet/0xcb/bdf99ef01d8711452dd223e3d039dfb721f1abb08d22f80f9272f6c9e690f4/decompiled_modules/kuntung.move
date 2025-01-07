module 0xcbbdf99ef01d8711452dd223e3d039dfb721f1abb08d22f80f9272f6c9e690f4::kuntung {
    struct KUNTUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUNTUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUNTUNG>(arg0, 9, b"KUNTUNG", b"Kuntung", b"eyyo kuntung on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c65d613b-5928-4042-a524-887636cc220a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUNTUNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUNTUNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

