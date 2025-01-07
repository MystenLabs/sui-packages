module 0x3e8d6d1786706537c81ad97b961d5ae74a9748b38cd78835e3dfd83011ef6c80::asa {
    struct ASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ASA>(arg0, 6, b"ASA", b"sua", b"suia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Snapshot_09_10_2023_050912_5a492b8dee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

