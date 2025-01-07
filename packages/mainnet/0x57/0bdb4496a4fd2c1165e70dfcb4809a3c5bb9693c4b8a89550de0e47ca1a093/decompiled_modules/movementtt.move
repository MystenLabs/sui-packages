module 0x570bdb4496a4fd2c1165e70dfcb4809a3c5bb9693c4b8a89550de0e47ca1a093::movementtt {
    struct MOVEMENTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEMENTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEMENTTT>(arg0, 9, b"MOVEMENTTT", b"Gmove", b"Gmove go to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0b16395f-9853-46a8-a9b9-2fec3943055c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEMENTTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOVEMENTTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

