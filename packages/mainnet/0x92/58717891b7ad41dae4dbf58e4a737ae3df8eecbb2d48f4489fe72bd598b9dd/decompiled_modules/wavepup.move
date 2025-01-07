module 0x9258717891b7ad41dae4dbf58e4a737ae3df8eecbb2d48f4489fe72bd598b9dd::wavepup {
    struct WAVEPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVEPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVEPUP>(arg0, 9, b"WAVEPUP", b"WPUP", b"WavePUP meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4322bc2-7cb8-41bb-9ecd-424cb266665c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVEPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVEPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

