module 0x3b0eb4b6ba3f7e2e6b0a8270de4c84d7f7ecf75ff0c311ca6c7943c986e032c7::ttest {
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

