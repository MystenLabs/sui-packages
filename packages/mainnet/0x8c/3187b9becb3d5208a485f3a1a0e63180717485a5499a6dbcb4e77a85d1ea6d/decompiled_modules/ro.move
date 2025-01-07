module 0x8c3187b9becb3d5208a485f3a1a0e63180717485a5499a6dbcb4e77a85d1ea6d::ro {
    struct RO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RO>(arg0, 9, b"RO", b"Risky ", x"4920646f6ee2809974206b6e6f77207768617420796f752077616e7420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f032253-9965-4fb9-9b5d-7210b07868ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RO>>(v1);
    }

    // decompiled from Move bytecode v6
}

