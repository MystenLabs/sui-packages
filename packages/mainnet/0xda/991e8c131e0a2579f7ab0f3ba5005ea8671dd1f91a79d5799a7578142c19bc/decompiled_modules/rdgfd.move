module 0xda991e8c131e0a2579f7ab0f3ba5005ea8671dd1f91a79d5799a7578142c19bc::rdgfd {
    struct RDGFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDGFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDGFD>(arg0, 9, b"RDGFD", b"Ifeanyi", b"Ugdfgy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/329508b9-0e2d-40e4-858f-7e2f656b8e84.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDGFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RDGFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

