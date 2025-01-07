module 0xe4ebf3cd148790b27f08317b3f2176f2e3140a3420cbad1bfc3b01acc3d9cef5::btl {
    struct BTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTL>(arg0, 9, b"BTL", b"buntap", b"Pufferfish are poisonous fish belonging to the Tetraodontidae family", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f907e22b-025c-4026-acf1-001c5ea3124d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

