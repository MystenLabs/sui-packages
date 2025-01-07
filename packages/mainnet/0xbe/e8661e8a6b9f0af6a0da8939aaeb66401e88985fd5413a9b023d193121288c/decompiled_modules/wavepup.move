module 0xbee8661e8a6b9f0af6a0da8939aaeb66401e88985fd5413a9b023d193121288c::wavepup {
    struct WAVEPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVEPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVEPUP>(arg0, 9, b"WAVEPUP", b"WPUP", b"WavePUP meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d157a9cd-9fdb-4828-b6ca-b770b125ef6e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVEPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVEPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

