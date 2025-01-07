module 0xefd026c9211bff5aab691f41a3675bfcb5578e61d6632f8535f7e2f777a56e13::iebe {
    struct IEBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IEBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IEBE>(arg0, 9, b"IEBE", b"hend", b"bdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a0b0037-23df-485b-877c-aebe46a701b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IEBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IEBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

