module 0x41fa7cb6444f900bfb68ea24d2a650a214fe404a9b593f64f1aafaebb12f121::ann {
    struct ANN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANN>(arg0, 6, b"ANN", b"an_", b"annnnn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/288635959_1177617289702575_7117542011747382689_n_08359387f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANN>>(v1);
    }

    // decompiled from Move bytecode v6
}

