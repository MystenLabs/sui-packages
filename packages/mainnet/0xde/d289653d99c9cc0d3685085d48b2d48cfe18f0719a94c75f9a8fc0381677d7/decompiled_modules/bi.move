module 0xded289653d99c9cc0d3685085d48b2d48cfe18f0719a94c75f9a8fc0381677d7::bi {
    struct BI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BI>(arg0, 9, b"BI", b"Jay", b"A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c5593ef-130a-4409-87c2-b13d9e322576.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BI>>(v1);
    }

    // decompiled from Move bytecode v6
}

