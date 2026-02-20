module 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::market_type {
    struct MARKET_TYPE has drop {
        dummy_field: bool,
    }

    struct MainMarket has store, key {
        id: 0x2::object::UID,
    }

    struct XSuiMarket has store, key {
        id: 0x2::object::UID,
    }

    struct AltCoinMarket has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MARKET_TYPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MARKET_TYPE>(arg0, arg1);
        let v0 = MainMarket{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<MainMarket>(v0);
        let v1 = XSuiMarket{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<XSuiMarket>(v1);
        let v2 = AltCoinMarket{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<AltCoinMarket>(v2);
    }

    // decompiled from Move bytecode v6
}

