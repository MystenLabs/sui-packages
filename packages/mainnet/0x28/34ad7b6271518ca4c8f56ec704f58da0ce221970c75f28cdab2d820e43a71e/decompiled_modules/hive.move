module 0x2834ad7b6271518ca4c8f56ec704f58da0ce221970c75f28cdab2d820e43a71e::hive {
    struct HIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HIVE>(arg0, 6, b"HIVE", b"HiveAI by SuiAI", b"Simplifying DeFi through composable on-chain AI agents.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2169_dceb1631bf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HIVE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIVE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

