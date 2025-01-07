module 0xfdbcee95e131eb36d3552bc29c7e1e751fa7396394e22dd179d66d59557ab2fb::bucks {
    struct BUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCKS>(arg0, 6, b"BUCKS", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUCKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCKS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

