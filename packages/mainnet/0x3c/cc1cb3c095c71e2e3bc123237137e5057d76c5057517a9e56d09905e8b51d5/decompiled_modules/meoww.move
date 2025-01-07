module 0x3ccc1cb3c095c71e2e3bc123237137e5057d76c5057517a9e56d09905e8b51d5::meoww {
    struct MEOWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWW>(arg0, 9, b"MEOWW", b"MEWINGGG", b"MEOW IS MY BOSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/276a1ab7-ec46-46c0-8fed-3f3e568acb59.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

