module 0x217cf345071eb2ed6000cd2c115d2ce249a9449269cae20b200c68cd47ad282e::sqd {
    struct SQD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQD>(arg0, 9, b"SQD", b"Squid Test", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

