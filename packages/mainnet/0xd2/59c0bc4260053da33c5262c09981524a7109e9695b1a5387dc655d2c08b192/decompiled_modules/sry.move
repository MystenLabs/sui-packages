module 0xd259c0bc4260053da33c5262c09981524a7109e9695b1a5387dc655d2c08b192::sry {
    struct SRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRY>(arg0, 9, b"SRY", b"SURYA", x"5765206d616b65206c6f63616c20636967617220677265617420e2809c4d414e204841564520474f4f44205649424553e2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61038dd0-5baa-4dd1-838e-4f7b2bc0f9e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

