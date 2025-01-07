module 0xf48549e2785b5d59f2cd27b3f2359f11d62ca0966d740c2317e0c6ca608ff94c::telegrum {
    struct TELEGRUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TELEGRUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TELEGRUM>(arg0, 9, b"TELEGRUM", b"TLG", b"telegruum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/64a94587-2d6a-4061-af9b-2f4992a8ec8c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TELEGRUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TELEGRUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

