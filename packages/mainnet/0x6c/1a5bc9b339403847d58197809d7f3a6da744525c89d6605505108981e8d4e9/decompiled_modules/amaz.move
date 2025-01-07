module 0x6c1a5bc9b339403847d58197809d7f3a6da744525c89d6605505108981e8d4e9::amaz {
    struct AMAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMAZ>(arg0, 9, b"AMAZ", b"Reza Jamal", b"work", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/512521af-c693-4b3d-bbf7-10d70891bf38.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMAZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMAZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

