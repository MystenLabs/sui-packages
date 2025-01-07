module 0xab3fae5c68b12ef5f80d7ff922d70529056cb6d78908664a5409cf5460b3dea5::rainbow {
    struct RAINBOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAINBOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAINBOW>(arg0, 9, b"RAINBOW", b"After rain", b"do you like the rainbow created by nature after heavy rain?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e3b173c-da3e-41d7-be24-a193158264cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAINBOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAINBOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

