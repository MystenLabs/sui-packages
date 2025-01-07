module 0xd428a7aba2841bbcc42d4bc640919a376a62f96e4727cfca42c8d597521b09e1::aliens {
    struct ALIENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALIENS>(arg0, 9, b"ALIENS", b"Alien", b"Alien on mountains..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/176509cf-f39b-484b-b422-5970e6e4b781.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALIENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

