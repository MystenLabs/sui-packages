module 0x60b2a06c930b4279a4622e91f699b1b6d84561bd0e655c340fed96bb488c707b::testinggaryvault {
    struct TESTINGGARYVAULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTINGGARYVAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTINGGARYVAULT>(arg0, 9, b"TESTINGGARYVAULT", b"TestingGaryVault", b"this is a testing vault created by gary", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://picsum.photos/200/300")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TESTINGGARYVAULT>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTINGGARYVAULT>>(v1);
    }

    // decompiled from Move bytecode v6
}

