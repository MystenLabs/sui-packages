module 0x833a81daf0191953605817b291c2131fb07b746dcecbba5d14f570e795dc1d47::peps {
    struct PEPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPS>(arg0, 9, b"PEPS", b"Pepe USA", b"The only thing that matters to you right ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/14bf0141-57d1-4c23-b7ff-a6e5468b1836.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

