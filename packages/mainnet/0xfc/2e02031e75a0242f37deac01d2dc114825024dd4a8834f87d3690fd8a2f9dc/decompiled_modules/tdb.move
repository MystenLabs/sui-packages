module 0xfc2e02031e75a0242f37deac01d2dc114825024dd4a8834f87d3690fd8a2f9dc::tdb {
    struct TDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDB>(arg0, 9, b"TDB", b"TEST DON BUY", b"TEST DON BUY PLS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TDB>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDB>>(v2, @0xb98b463f912e60e2ae74989f69c447fe5d4920c4ee9c399b061384853e0b3e26);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

