module 0x4ffc7ac4f5db7c53bde2e76541273b00abac5ca74f56d541508e6eaa50ea881a::danai {
    struct DANAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DANAI>(arg0, 6, b"DANAI", b"DANAI by SuiAI", b"Just a beatifull Agent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/daia_2cb36df9e0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DANAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

