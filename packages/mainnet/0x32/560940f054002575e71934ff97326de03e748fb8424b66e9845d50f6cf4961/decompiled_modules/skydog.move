module 0x32560940f054002575e71934ff97326de03e748fb8424b66e9845d50f6cf4961::skydog {
    struct SKYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKYDOG>(arg0, 9, b"SKYDOG", b"sky coin", b"sky is name for my dog, she's cute fr ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c6e22b0-15e6-4d28-a3f2-0a70d7d5f5c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKYDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

