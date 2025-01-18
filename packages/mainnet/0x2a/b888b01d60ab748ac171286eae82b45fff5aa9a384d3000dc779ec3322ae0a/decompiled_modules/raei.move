module 0x2ab888b01d60ab748ac171286eae82b45fff5aa9a384d3000dc779ec3322ae0a::raei {
    struct RAEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAEI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RAEI>(arg0, 6, b"RAEI", b"0xraei by SuiAI", b"raei", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/20210110_004609_27c9b149e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAEI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAEI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

