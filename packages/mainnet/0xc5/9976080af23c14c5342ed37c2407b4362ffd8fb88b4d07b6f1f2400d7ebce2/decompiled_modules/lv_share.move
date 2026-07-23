module 0xc59976080af23c14c5342ed37c2407b4362ffd8fb88b4d07b6f1f2400d7ebce2::lv_share {
    struct LV_SHARE has key {
        id: 0x2::object::UID,
    }

    public fun register_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<LV_SHARE> {
        assert!(!0x2::coin_registry::exists<LV_SHARE>(arg0), 13906834277422596095);
        let (v0, v1) = 0x2::coin_registry::new_currency<LV_SHARE>(arg0, 6, arg2, arg1, 0x1::string::utf8(b"Splyce Concord lending vault share"), 0x1::string::utf8(b"https://splyce.fi"), arg3);
        0x2::coin_registry::finalize_and_delete_metadata_cap<LV_SHARE>(v0, arg3);
        v1
    }

    // decompiled from Move bytecode v7
}

