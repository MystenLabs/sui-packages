module 0x62052fc37e2420e3a7522ca6cd335d42135ad115f18d90707715841873674ce4::rizz {
    struct RIZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZ>(arg0, 6, b"RIZZ", b"Rizz Coin", b"Your portfolio just got a 10/10 Rizz.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732042216932.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIZZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

