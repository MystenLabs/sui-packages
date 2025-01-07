module 0xca034e12e3521d073a6a81e1e109b92bed00f476c51d0daea5037db7d48e403e::geg {
    struct GEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEG>(arg0, 9, b"GEG", b"Ggdgdg", b"Vavag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/535698c1-c813-4e8a-ab79-c1179a8063e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

