module 0x6573ccbb6065786b9172c7dae96d69a84d4d588d72a4b7abbd6116bd922f42a3::cc {
    struct CC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CC>(arg0, 9, b"CC", b"Df", b"Ccghbebsbsbsjsnsnsnsnsnsns", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7c91bea-d758-4bce-b84f-b5802c08e284.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CC>>(v1);
    }

    // decompiled from Move bytecode v6
}

