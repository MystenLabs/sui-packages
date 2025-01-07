module 0xfa5714ba4a92df136fa7683faf869c7f3fdf839cd2acba6777e8b27ca45b9ec3::bab {
    struct BAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAB>(arg0, 9, b"BAB", b"BABA", b"BABA is a token for dad's lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/155cef5f-da73-4d76-9fdd-157f662cab30.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

