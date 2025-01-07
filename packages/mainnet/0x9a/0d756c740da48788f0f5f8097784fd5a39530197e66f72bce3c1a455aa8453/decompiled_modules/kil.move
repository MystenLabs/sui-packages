module 0x9a0d756c740da48788f0f5f8097784fd5a39530197e66f72bce3c1a455aa8453::kil {
    struct KIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIL>(arg0, 9, b"KIL", b"DF", b"GNB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2ab30e0-6749-49fa-a10c-8d1834a59c5a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

