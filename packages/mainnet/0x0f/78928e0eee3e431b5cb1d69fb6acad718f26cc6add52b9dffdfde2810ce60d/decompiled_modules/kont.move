module 0xf78928e0eee3e431b5cb1d69fb6acad718f26cc6add52b9dffdfde2810ce60d::kont {
    struct KONT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONT>(arg0, 9, b"KONT", b"Kontol", b"Kontol is a the greatest think in this world, they can make a new entity's, and if in this word the kontol be fanish so the human will be gone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a976fc80-b734-4dfe-b46c-0c8b1dc1b69a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KONT>>(v1);
    }

    // decompiled from Move bytecode v6
}

