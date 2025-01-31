module 0x4726897798e37cd932aa7d02e55a6a7afc9d8972ed3d5ca9f41a45989b540c96::airena {
    struct AIRENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIRENA>(arg0, 9, b"AIRENA", b"Agent Airena", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZmotuYRZ4hq9jdtAMfbdnN6MVV5nWdtyWYHR1AjJTrJk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AIRENA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIRENA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRENA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

