module 0x981acaba40413b047c1c2f6c9f20dc298f502a41be321035a85cd640093bc37::micpodcast {
    struct MICPODCAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICPODCAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICPODCAST>(arg0, 9, b"MICPODCAST", b"Ibnu m", b"meme mic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66175501-678c-4e86-bd87-a227eee5003e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICPODCAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MICPODCAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

