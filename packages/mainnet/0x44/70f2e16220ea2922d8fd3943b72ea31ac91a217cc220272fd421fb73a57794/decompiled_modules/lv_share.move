module 0x4470f2e16220ea2922d8fd3943b72ea31ac91a217cc220272fd421fb73a57794::lv_share {
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

