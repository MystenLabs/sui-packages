module 0x5f51605c9b3c15f36a30ba2936153b566af8c8641c7eaff21900fd9dad166cda::hue {
    struct HUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUE>(arg0, 9, b"HUE", b"Hue", b"Hue thuong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/36e7a0f4-a89c-43ca-855e-73bc6d493f9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

