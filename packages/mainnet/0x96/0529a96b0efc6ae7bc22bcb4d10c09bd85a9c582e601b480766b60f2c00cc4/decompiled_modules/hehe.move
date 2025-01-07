module 0x960529a96b0efc6ae7bc22bcb4d10c09bd85a9c582e601b480766b60f2c00cc4::hehe {
    struct HEHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHE>(arg0, 9, b"HEHE", b"Huhuhu", b"Abc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c8f7cc63-d101-47e5-a6c6-fcb51b7f6c9a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

