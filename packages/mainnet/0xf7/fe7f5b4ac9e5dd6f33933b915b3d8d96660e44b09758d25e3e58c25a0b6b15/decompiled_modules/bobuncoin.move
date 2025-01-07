module 0xf7fe7f5b4ac9e5dd6f33933b915b3d8d96660e44b09758d25e3e58c25a0b6b15::bobuncoin {
    struct BOBUNCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBUNCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBUNCOIN>(arg0, 9, b"BOBUNCOIN", b"BOBUN", b"Top coin meme BONUN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ba971bf-89a2-4395-aa69-c5a0c8728907.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBUNCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBUNCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

