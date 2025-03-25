module 0x93b6e3432bdf986099feee41910b0dcc8d1db9040e2d3c27ccf20330c18a79ca::wal_test {
    struct WAL_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAL_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAL_TEST>(arg0, 9, b"WAL_TEST", b"WAL Token Test", b"xxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"xxx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WAL_TEST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAL_TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAL_TEST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

