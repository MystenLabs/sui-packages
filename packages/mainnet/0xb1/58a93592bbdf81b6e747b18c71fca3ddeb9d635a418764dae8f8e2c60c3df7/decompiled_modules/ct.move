module 0xb158a93592bbdf81b6e747b18c71fca3ddeb9d635a418764dae8f8e2c60c3df7::ct {
    struct CT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CT>(arg0, 9, b"CT", b"Cati ", b"Lodding ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb9e2c00-246c-4ec8-b749-21c7d55f3501.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CT>>(v1);
    }

    // decompiled from Move bytecode v6
}

