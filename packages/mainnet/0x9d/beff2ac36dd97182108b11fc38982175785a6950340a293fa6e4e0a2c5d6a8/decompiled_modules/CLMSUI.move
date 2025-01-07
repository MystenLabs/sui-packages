module 0x9dbeff2ac36dd97182108b11fc38982175785a6950340a293fa6e4e0a2c5d6a8::CLMSUI {
    struct CLMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLMSUI>(arg0, 6, b"CLMSUI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLMSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLMSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

