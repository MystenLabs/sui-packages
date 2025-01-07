module 0x801d9d1abb4534f7fc9d46a2c31143a86f1a6704ebe6e763de4fe5a84a663338::rstm {
    struct RSTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSTM>(arg0, 9, b"RSTM", b"Rostam ", x"5468652062657374205065727369616e206865726f206973206261636b20c3b120696e2063727970746f20776f726c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f5f4e95-3a59-4f63-bd2d-df8ae3dccf9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RSTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

