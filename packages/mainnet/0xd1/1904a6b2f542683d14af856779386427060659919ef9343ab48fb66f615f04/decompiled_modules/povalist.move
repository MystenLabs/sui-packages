module 0xd11904a6b2f542683d14af856779386427060659919ef9343ab48fb66f615f04::povalist {
    struct POVALIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: POVALIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POVALIST>(arg0, 9, b"POVALIST", b"TECNOPOVA", b"Ffydfhg fswdhh sswfhv uhfgih fshhkg ddcjbdr jgfchngf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8bb1bd45-325c-4a8d-aac4-ec4e1c511539.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POVALIST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POVALIST>>(v1);
    }

    // decompiled from Move bytecode v6
}

