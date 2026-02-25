module 0x5c5a599c38455556dbf8557c8c336cd4d3fae605b1b196c9514c87a5b9974a25::itoft {
    struct ITOFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITOFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITOFT>(arg0, 6, b"ITOFT", b"ItsTimeToOFT", b"Omnichain token deployed via LayerZero V2", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ITOFT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITOFT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

