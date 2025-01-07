module 0x2adae750277f4a83bca405203d4c94e3c2eec9711a15731f8a8b23c194df40dd::mdog {
    struct MDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDOG>(arg0, 9, b"MDOG", b"MelosDog", b"Melos dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17d014b2-c562-4d1d-b8c0-4048e088f2f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

