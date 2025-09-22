module 0xfb69d8260d5f1075ac03cb1e5fb53f7376350d9e26d44532732fe29a56884ac3::market_type {
    struct MARKET_TYPE has drop {
        dummy_field: bool,
    }

    struct MainMarket has store, key {
        id: 0x2::object::UID,
    }

    struct STSuiMarket has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MARKET_TYPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MARKET_TYPE>(arg0, arg1);
        let v0 = MainMarket{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<MainMarket>(v0);
        let v1 = STSuiMarket{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<STSuiMarket>(v1);
    }

    // decompiled from Move bytecode v6
}

