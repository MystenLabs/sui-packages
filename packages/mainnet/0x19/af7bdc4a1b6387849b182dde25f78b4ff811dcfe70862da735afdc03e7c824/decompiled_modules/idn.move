module 0x19af7bdc4a1b6387849b182dde25f78b4ff811dcfe70862da735afdc03e7c824::idn {
    struct IDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDN>(arg0, 6, b"IDN", b"interchaindeeznutz", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IDN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

