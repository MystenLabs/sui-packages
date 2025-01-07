module 0xf016b2f7d7e785e43950d7ece5c6f5a7cb068510a6473437094b3e5a913e5fe::fsdg {
    struct FSDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSDG>(arg0, 9, b"FSDG", b"FD", b"DGSH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d4562bc-df5f-4ea6-862f-baacb161412c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

