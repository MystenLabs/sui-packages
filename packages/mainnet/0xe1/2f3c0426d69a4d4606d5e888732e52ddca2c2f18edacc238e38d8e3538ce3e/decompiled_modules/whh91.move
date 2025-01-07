module 0xe12f3c0426d69a4d4606d5e888732e52ddca2c2f18edacc238e38d8e3538ce3e::whh91 {
    struct WHH91 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHH91, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHH91>(arg0, 9, b"WHH91", b"HH91", b"Meme on sui chain HH91", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/359d4ed9-f4aa-49d9-885e-c7220c5059a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHH91>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHH91>>(v1);
    }

    // decompiled from Move bytecode v6
}

