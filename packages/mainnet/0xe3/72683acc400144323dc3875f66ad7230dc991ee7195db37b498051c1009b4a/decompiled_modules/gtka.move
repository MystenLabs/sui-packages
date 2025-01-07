module 0xe372683acc400144323dc3875f66ad7230dc991ee7195db37b498051c1009b4a::gtka {
    struct GTKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTKA>(arg0, 9, b"GTKA", b"Gatuka", b"That one you love, like nothing else. How much do you need it?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b6ff410-c2d1-4597-8256-a02f68c9230a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

