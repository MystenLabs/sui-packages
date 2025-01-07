module 0x9986af17d0f4fadc1a7de832b1d20cbaa0603aff01a9b63ce63acfc3a5d7bb60::memed {
    struct MEMED has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMED>(arg0, 9, b"MEMED", b"just meme", b"wave pump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f949af9-0e8b-404d-b437-5b5567820c7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMED>>(v1);
    }

    // decompiled from Move bytecode v6
}

