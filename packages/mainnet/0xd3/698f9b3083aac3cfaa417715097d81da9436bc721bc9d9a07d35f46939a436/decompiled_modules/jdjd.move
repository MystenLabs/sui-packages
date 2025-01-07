module 0xd3698f9b3083aac3cfaa417715097d81da9436bc721bc9d9a07d35f46939a436::jdjd {
    struct JDJD has drop {
        dummy_field: bool,
    }

    fun init(arg0: JDJD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JDJD>(arg0, 9, b"JDJD", b"7dj", b"Dyud", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb215705-35a9-46c3-858c-f18d8aca4741.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JDJD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JDJD>>(v1);
    }

    // decompiled from Move bytecode v6
}

