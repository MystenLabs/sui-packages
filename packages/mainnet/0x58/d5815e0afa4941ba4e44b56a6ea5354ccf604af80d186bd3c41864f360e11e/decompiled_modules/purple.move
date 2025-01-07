module 0x58d5815e0afa4941ba4e44b56a6ea5354ccf604af80d186bd3c41864f360e11e::purple {
    struct PURPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURPLE>(arg0, 9, b"PURPLE", b"PurpleGIRL", b"Gg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/960514f7-635a-4b0d-9533-be51926a0155.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PURPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

