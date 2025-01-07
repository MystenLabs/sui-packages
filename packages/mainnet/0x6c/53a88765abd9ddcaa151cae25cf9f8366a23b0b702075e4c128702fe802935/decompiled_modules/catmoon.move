module 0x6c53a88765abd9ddcaa151cae25cf9f8366a23b0b702075e4c128702fe802935::catmoon {
    struct CATMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATMOON>(arg0, 9, b"CATMOON", b"Catt", b"catmoon is meme coin fron telegram app", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5fdf65d8-025f-4f81-b580-aed6edc54ff6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

