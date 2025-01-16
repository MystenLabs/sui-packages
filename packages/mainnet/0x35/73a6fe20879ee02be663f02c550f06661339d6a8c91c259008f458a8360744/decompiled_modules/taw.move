module 0x3573a6fe20879ee02be663f02c550f06661339d6a8c91c259008f458a8360744::taw {
    struct TAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TAW>(arg0, 6, b"TAW", b"The Acid Walrus - TAW by SuiAI", x"4d65746176657273652063686172616374657220f09f8c90202454415720746f6b656e206c61756e6368696e6720696e20405375694e6574776f726b20f09f92a7204f4720262043727970746f20646567656e2e204765656b2c20416369642c2057616c7275732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/taw_efe7b9e386.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TAW>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAW>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

