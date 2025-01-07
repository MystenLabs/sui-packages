module 0x8861e44696c6d76beeeafa6d2faf6240dcfe0a039c5ab4a01e52b677d3bea041::exp {
    struct EXP has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXP>(arg0, 9, b"EXP", b"Experiment", b"Just An ExPeriment", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/92c40ca9-b78b-4a2f-a13e-1c08a4b78abb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXP>>(v1);
    }

    // decompiled from Move bytecode v6
}

