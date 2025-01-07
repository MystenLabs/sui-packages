module 0x881ae2f1ed851faebfcb6dfa5bd23a99d7c63a9b966870caa654448eff13bb4::suli {
    struct SULI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULI>(arg0, 6, b"SULI", b"SULI ON SUI", x"537572766976696e67205355497320747769737420616e64207475726e73200a0a436f64652077617272696f72206279206461792c2063727970746f20656e7468757369617374206279206e69676874", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suli_99d1a6bf16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SULI>>(v1);
    }

    // decompiled from Move bytecode v6
}

