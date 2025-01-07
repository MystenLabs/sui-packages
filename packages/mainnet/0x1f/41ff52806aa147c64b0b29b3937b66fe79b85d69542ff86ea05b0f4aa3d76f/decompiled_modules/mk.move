module 0x1f41ff52806aa147c64b0b29b3937b66fe79b85d69542ff86ea05b0f4aa3d76f::mk {
    struct MK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MK>(arg0, 9, b"MK", b"Maakida", b"Just a meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d6737d1-e08b-438f-8fde-b4967ff4ef33.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MK>>(v1);
    }

    // decompiled from Move bytecode v6
}

