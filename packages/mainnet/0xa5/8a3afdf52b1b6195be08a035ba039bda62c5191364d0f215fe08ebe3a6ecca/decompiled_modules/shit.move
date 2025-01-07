module 0xa58a3afdf52b1b6195be08a035ba039bda62c5191364d0f215fe08ebe3a6ecca::shit {
    struct SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIT>(arg0, 6, b"SHIT", b"SHUIT", x"546865205348554954455354206d656d65206f6e20235355490a0a68747470733a2f2f782e636f6d2f73687569746d656d650a0a68747470733a2f2f742e6d652f53485549544d454d450a0a68747470733a2f2f73687569742e756e697665722e73652f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_036a5b14eb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

