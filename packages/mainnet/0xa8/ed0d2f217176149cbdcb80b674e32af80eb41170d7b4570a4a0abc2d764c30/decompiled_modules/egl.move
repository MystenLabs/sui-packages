module 0xa8ed0d2f217176149cbdcb80b674e32af80eb41170d7b4570a4a0abc2d764c30::egl {
    struct EGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGL>(arg0, 9, b"EGL", b"Eagle", b"Let's rise high like the eagle ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4fc030b-b2e5-4428-ad4e-0f3712d8aeec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

