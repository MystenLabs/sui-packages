module 0xc6f646d7de675dbee5fa1f01e2e11fb539cc04bad04c87cf1140c34a2908d7e8::drm {
    struct DRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRM>(arg0, 9, b"DRM", b"Dreamy", b"this meme coin is dreamy :)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c1a8518-c114-438a-b13f-06473c4e6dec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

