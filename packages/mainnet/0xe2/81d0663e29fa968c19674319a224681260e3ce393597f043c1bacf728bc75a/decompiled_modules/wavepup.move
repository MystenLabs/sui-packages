module 0xe281d0663e29fa968c19674319a224681260e3ce393597f043c1bacf728bc75a::wavepup {
    struct WAVEPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVEPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVEPUP>(arg0, 9, b"WAVEPUP", b"WPUP", b"WavePUP meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9bc45ba0-e121-4428-90cb-40aea784585c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVEPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVEPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

