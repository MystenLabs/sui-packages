module 0x43727949ebd95645f2754dcc1d03ac891ac56c0d8f97165d9efbc4bdb51ef8e8::aga {
    struct AGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGA>(arg0, 9, b"AGA", b"d", b"fd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d72ea7ba-997d-43ab-9f58-9bd7a3f42f6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

