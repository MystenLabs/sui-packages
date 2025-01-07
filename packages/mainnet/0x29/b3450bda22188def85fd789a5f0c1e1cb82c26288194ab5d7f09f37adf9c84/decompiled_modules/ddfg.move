module 0x29b3450bda22188def85fd789a5f0c1e1cb82c26288194ab5d7f09f37adf9c84::ddfg {
    struct DDFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDFG>(arg0, 9, b"DDFG", x"71c6b0657274", x"c3a1647364667662", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7f1ce4d-4daf-41e1-9bcd-95990c1cd90d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

