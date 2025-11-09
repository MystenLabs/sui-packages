module 0x25bfd7129e57e04f076218ebd0432189457a5e48e078bbbb45d0a638699d354a::skryla {
    struct SKRYLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKRYLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKRYLA>(arg0, 6, b"SKRYLA", b"SKRYLA", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKRYLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKRYLA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

