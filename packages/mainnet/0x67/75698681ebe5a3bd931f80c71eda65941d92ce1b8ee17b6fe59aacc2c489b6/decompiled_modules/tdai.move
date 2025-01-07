module 0x6775698681ebe5a3bd931f80c71eda65941d92ce1b8ee17b6fe59aacc2c489b6::tdai {
    struct TDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDAI>(arg0, 6, b"TDAI", b"Test DAI Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TDAI>(&mut v2, 1000000000000000000, @0xb20e3d32691f14e7c1ac9df146d39c20b0a2a9fa5f8443746004d81c2b21e45d, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TDAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDAI>>(v2, @0xb20e3d32691f14e7c1ac9df146d39c20b0a2a9fa5f8443746004d81c2b21e45d);
    }

    // decompiled from Move bytecode v6
}

