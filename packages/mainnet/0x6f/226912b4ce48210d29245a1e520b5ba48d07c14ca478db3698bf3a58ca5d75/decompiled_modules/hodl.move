module 0x6f226912b4ce48210d29245a1e520b5ba48d07c14ca478db3698bf3a58ca5d75::hodl {
    struct HODL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HODL>(arg0, 6, b"HODL", b"HODL by SuiAI", b"No rugs welcomed here, TG and X coming soon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1737740213695_62846616_3a8b_413b_8756_fbefa363234e_1_2_e8a2b2902a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HODL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

