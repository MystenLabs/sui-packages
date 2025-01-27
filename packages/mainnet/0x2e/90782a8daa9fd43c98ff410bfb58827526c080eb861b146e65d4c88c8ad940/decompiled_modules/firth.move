module 0x2e90782a8daa9fd43c98ff410bfb58827526c080eb861b146e65d4c88c8ad940::firth {
    struct FIRTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRTH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FIRTH>(arg0, 6, b"FIRTH", b"Firth IX by SuiAI", b"A sharp bird and a sui-analyst who loves medival clothing and provides the best sui data to x", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/pixlr_image_generator_236d4f37_fc69_4972_b717_1e1fbd0d4a0d_8037790ba5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FIRTH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRTH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

