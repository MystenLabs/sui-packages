module 0xc2a582eb3c749254b49ee837ad5be5745812692d8efc80d837321c98a6de6d28::plove {
    struct PLOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOVE>(arg0, 9, b"PLOVE", b"PAWN LOVE", b"PAWNING LOVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d541e49-0196-40b5-a357-8e3bad3f452c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

