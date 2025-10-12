module 0x535310c04ed309770e4faf85a5c93e072bd54ede10f194016660326c1d71c145::market_type {
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

    struct BTCMarket has store, key {
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
        let v3 = BTCMarket{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<BTCMarket>(v3);
    }

    // decompiled from Move bytecode v6
}

