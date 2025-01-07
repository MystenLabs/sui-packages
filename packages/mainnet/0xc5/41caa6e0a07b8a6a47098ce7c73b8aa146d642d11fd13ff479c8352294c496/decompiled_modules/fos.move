module 0xc541caa6e0a07b8a6a47098ce7c73b8aa146d642d11fd13ff479c8352294c496::fos {
    struct FOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOS>(arg0, 6, b"FOS", b"Fool sui", b"Are you a fool ? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1717_d455b9cf9c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

