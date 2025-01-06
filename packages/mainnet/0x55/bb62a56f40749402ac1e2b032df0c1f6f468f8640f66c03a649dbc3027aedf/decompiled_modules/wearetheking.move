module 0x55bb62a56f40749402ac1e2b032df0c1f6f468f8640f66c03a649dbc3027aedf::wearetheking {
    struct WEARETHEKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEARETHEKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WEARETHEKING>(arg0, 6, b"WEARETHEKING", b"RealMadridAI by SuiAI", b"The biggest club in the football world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_1fce595889.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WEARETHEKING>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEARETHEKING>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

