module 0x5dc7603ecfd19ad631b5df0a80e301967d4b87ea79f0ee0191e26a1aa30b966a::mock_sui {
    struct MOCK_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCK_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCK_SUI>(arg0, 9, b"MOCK_SUI", b"MOCK_SUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCK_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOCK_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

