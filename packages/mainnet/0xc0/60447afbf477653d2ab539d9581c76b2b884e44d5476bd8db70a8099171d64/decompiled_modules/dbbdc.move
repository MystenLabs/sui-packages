module 0xc060447afbf477653d2ab539d9581c76b2b884e44d5476bd8db70a8099171d64::dbbdc {
    struct DBBDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBBDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBBDC>(arg0, 9, b"DBBDC", b"Cnncbc", b"Cncbcb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca22ccde-2a33-4575-a706-40d6ef60dfee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBBDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DBBDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

