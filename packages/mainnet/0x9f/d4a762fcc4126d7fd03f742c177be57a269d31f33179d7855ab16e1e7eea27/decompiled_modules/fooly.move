module 0x9fd4a762fcc4126d7fd03f742c177be57a269d31f33179d7855ab16e1e7eea27::fooly {
    struct FOOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOOLY>(arg0, 9, b"FOOLY", b"Fool", b"Fooly meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c293a399-d0c0-4c38-8bb6-81e132bbb21b-IMG_1142.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOOLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOOLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

