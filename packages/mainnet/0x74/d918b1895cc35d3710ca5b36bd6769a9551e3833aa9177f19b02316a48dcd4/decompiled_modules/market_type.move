module 0x74d918b1895cc35d3710ca5b36bd6769a9551e3833aa9177f19b02316a48dcd4::market_type {
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

