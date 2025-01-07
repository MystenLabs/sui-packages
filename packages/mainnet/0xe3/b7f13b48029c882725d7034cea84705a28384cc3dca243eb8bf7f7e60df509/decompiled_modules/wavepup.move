module 0xe3b7f13b48029c882725d7034cea84705a28384cc3dca243eb8bf7f7e60df509::wavepup {
    struct WAVEPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVEPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVEPUP>(arg0, 9, b"WAVEPUP", b"WPUP", b"WavePUP meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ebc7f91b-50f5-419a-9f0e-7fe04ec14e53.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVEPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVEPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

