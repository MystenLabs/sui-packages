module 0x7b408be78b184d656203035eccedae0832456e540af3df2e07b3e51cfc6b8912::testtas {
    struct TESTTAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTTAS>(arg0, 6, b"Testtas", b"test", b"tes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730981111517.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTTAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

