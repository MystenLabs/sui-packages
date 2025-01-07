module 0x4939f2d67d47e704cfefcd9e9d5da71ab7bd3aa4af272a75df934ee8c416f3b6::agx {
    struct AGX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGX>(arg0, 9, b"AGX", b"Agapeonx", b"community driven ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6d2e4709-fa17-42c0-a980-a64f727ed0fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGX>>(v1);
    }

    // decompiled from Move bytecode v6
}

