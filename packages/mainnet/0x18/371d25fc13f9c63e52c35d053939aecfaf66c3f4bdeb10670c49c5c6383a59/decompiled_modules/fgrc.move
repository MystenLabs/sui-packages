module 0x18371d25fc13f9c63e52c35d053939aecfaf66c3f4bdeb10670c49c5c6383a59::fgrc {
    struct FGRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGRC>(arg0, 9, b"FGRC", b"Fragrance ", b"A sui based meme coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fec2f3c6-fb70-4870-a0bf-5360087042dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FGRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

