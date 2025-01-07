module 0xc602a897c5057f1d409ed286e997b337b918845279d96cad2514eb583ada3661::anime00 {
    struct ANIME00 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIME00, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANIME00>(arg0, 9, b"ANIME00", b"Anime", b"Token for Anime lover", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fcecdecb-b8e6-4847-a8e3-ad62b881a997.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIME00>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANIME00>>(v1);
    }

    // decompiled from Move bytecode v6
}

