module 0x5da1a97cf86aa8218bd417676a6b236a238f284a86470a98e4d98e05ac973108::kas {
    struct KAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAS>(arg0, 9, b"KAS", b"Pepekas ", x"4974e28099732061205065706520636f696e20496e73696465204b52432d3230", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9e750c6-649f-4ea1-b5f5-8a93c74e83c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

