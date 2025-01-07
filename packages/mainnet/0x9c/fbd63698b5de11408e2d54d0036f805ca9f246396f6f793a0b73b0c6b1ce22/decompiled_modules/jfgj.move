module 0x9cfbd63698b5de11408e2d54d0036f805ca9f246396f6f793a0b73b0c6b1ce22::jfgj {
    struct JFGJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JFGJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JFGJ>(arg0, 9, b"JFGJ", b"JFJ", b"DHDF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e028cf11-3964-4829-8157-a54465299063.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JFGJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JFGJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

