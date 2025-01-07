module 0x1643030d14acc5f7fa9b3d1aa4a9b9268d74f8cab0349c7974ec6ad036e40dcd::mara {
    struct MARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARA>(arg0, 9, b"MARA", b"Marathon", b"Gjjjj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/501697bd-30f8-45d4-8091-2f0f36464978.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

