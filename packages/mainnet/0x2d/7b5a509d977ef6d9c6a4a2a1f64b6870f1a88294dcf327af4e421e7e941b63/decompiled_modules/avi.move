module 0x2d7b5a509d977ef6d9c6a4a2a1f64b6870f1a88294dcf327af4e421e7e941b63::avi {
    struct AVI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVI>(arg0, 9, b"AVI", b"ALVIN", b"ALVIN MEME COIN FOR SALE .HAHAHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa6ff4e3-5e7d-4b41-a632-f900fcd45e43.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVI>>(v1);
    }

    // decompiled from Move bytecode v6
}

