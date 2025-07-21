module 0x95f2e1d5a56dda8d69704d0b3a53c2046bc4ad17f0f8d40d5ddfe82152a1169c::ttest {
    struct TTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TTEST>(arg0, 6, b"TTEST", b"justatest", b"@suilaunchcoin $ttest + justatest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ttest-fmwcex.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTEST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTEST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

