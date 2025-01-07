module 0xf2f33f789575b2ab3cbd0f0f8d9395d8e3d2fa4df92ab49fec36d497461335df::hue {
    struct HUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUE>(arg0, 9, b"HUE", b"Hue", b"Hue thuong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4636a3c0-b278-4212-ae4f-f2a095ae1888.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

