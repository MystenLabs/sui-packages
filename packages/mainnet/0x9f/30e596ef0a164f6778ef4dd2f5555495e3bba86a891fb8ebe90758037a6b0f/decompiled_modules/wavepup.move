module 0x9f30e596ef0a164f6778ef4dd2f5555495e3bba86a891fb8ebe90758037a6b0f::wavepup {
    struct WAVEPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVEPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVEPUP>(arg0, 9, b"WAVEPUP", b"WPUP", b"WavePUP meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/38c153fc-8846-4cb3-b117-914048878c0b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVEPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVEPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

