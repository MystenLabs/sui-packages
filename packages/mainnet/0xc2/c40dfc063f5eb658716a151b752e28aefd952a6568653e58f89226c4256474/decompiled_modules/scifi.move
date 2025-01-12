module 0xc2c40dfc063f5eb658716a151b752e28aefd952a6568653e58f89226c4256474::scifi {
    struct SCIFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCIFI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SCIFI>(arg0, 6, b"SCIFI", b"SciFi by SuiAI", b"Scifi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_18_09d2220d95.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCIFI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCIFI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

