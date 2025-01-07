module 0x456809bcb06c9c1eca27298fb3faeb1c178945dd3d313fe202908e06167e5b59::rev {
    struct REV has drop {
        dummy_field: bool,
    }

    fun init(arg0: REV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REV>(arg0, 9, b"REV", b"REVIEW EVE", b"Review Everything", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e5e94a4-d202-47de-94ef-6fbf97b0e7c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REV>>(v1);
    }

    // decompiled from Move bytecode v6
}

