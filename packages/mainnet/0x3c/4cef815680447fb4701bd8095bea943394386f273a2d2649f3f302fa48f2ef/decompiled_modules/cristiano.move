module 0x3c4cef815680447fb4701bd8095bea943394386f273a2d2649f3f302fa48f2ef::cristiano {
    struct CRISTIANO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRISTIANO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRISTIANO>(arg0, 9, b"CRISTIANO", b"CR7", b"SUI SUI RONALDO, MEME RONALDO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b20c9d8-2bbd-444a-a550-21de523e81d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRISTIANO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRISTIANO>>(v1);
    }

    // decompiled from Move bytecode v6
}

