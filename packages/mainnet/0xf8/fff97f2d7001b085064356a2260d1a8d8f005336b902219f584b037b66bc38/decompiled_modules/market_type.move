module 0xf8fff97f2d7001b085064356a2260d1a8d8f005336b902219f584b037b66bc38::market_type {
    struct MARKET_TYPE has drop {
        dummy_field: bool,
    }

    struct MainMarket has store, key {
        id: 0x2::object::UID,
    }

    struct STSuiMarket has store, key {
        id: 0x2::object::UID,
    }

    struct AltCoinMarket has store, key {
        id: 0x2::object::UID,
    }

    struct BTCMarket has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MARKET_TYPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MARKET_TYPE>(arg0, arg1);
        let v0 = MainMarket{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<MainMarket>(v0);
        let v1 = STSuiMarket{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<STSuiMarket>(v1);
        let v2 = AltCoinMarket{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<AltCoinMarket>(v2);
        let v3 = BTCMarket{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<BTCMarket>(v3);
    }

    // decompiled from Move bytecode v6
}

