module 0x871bbe62538928fb91113655a19e691d989ff053c9540b7d6ef3b813ba4d972a::wape {
    struct WAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAPE>(arg0, 6, b"WAPE", b"WHATEVER APE SUI", x"4f776e2024574150452c2061636869657665206162736f6c7574656c79206e6f7468696e67200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FKW_Wg4y_WUA_Aib_Qa_de21a00590.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

