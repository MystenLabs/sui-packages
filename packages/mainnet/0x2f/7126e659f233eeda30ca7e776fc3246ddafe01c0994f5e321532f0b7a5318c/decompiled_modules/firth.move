module 0x2f7126e659f233eeda30ca7e776fc3246ddafe01c0994f5e321532f0b7a5318c::firth {
    struct FIRTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRTH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FIRTH>(arg0, 6, b"FIRTH", b"firth IX by SuiAI", b"A sharp bird and a sui-analyst who loves medival clothing and provides a lot of informative and concise content related to sui on X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/pixlr_image_generator_236d4f37_fc69_4972_b717_1e1fbd0d4a0d_1c58a35202.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FIRTH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRTH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

