module 0x8328740dfb0543481c83f750866738ef56b0608edb23d6ec2463f114f80afc0c::hihi {
    struct HIHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIHI>(arg0, 9, b"HIHI", b"phuduc", x"70687564756320c491e1bab9702074726169207369c3aa752063c3a2702076697070726f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c94c5f17-e4f2-4e91-925c-23f4cf684e69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

