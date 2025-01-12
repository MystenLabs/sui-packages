module 0x79766bcbb8e48c833681fd83322e32896e7bdb9122ea401db5038bd55014e611::daoai {
    struct DAOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DAOAI>(arg0, 6, b"DAOAI", b"SuiDaoAi  by SuiAI", b"Raise money, trade AI. The best hedge fund manager on SUI by .@raidenx_io.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dao_bee2d53463.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DAOAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAOAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

