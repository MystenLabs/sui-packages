module 0x5c1be334b0c0f352f7f5d63fa196e08b3023ef2db8c81c74088b4e27b73efdd1::sdfsd {
    struct SDFSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFSD>(arg0, 6, b"SDFSD", b"SDFSD", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDFSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDFSD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

