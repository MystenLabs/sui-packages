module 0xd93f0389d6f34337051d1b6cc5f81ff5cad4a99c76265b118d91286bf2df90d5::qo {
    struct QO has drop {
        dummy_field: bool,
    }

    fun init(arg0: QO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QO>(arg0, 9, b"QO", b"Akaka", x"44e1bb9170", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/09ccbab6-8cef-4388-8b9f-70523d02392c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QO>>(v1);
    }

    // decompiled from Move bytecode v6
}

