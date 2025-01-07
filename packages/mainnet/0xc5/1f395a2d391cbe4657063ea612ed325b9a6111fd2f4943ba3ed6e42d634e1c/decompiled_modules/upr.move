module 0xc51f395a2d391cbe4657063ea612ed325b9a6111fd2f4943ba3ed6e42d634e1c::upr {
    struct UPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPR>(arg0, 9, b"UPR", b"upper", x"616368696576696e67206c6f6674792070726f6669747320616e64207265616368696e67206e65772073756d6d697473206f66207375636365737320f09f8f94efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d041c58-8528-4811-a040-622b2a37e48e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

