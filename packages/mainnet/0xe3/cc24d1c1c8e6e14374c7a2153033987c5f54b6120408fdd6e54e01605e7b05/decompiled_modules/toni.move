module 0xe3cc24d1c1c8e6e14374c7a2153033987c5f54b6120408fdd6e54e01605e7b05::toni {
    struct TONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONI>(arg0, 9, b"TONI", b"Toni con", b"Tonicon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee240773-546f-43b5-8994-d2c6780f85c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

