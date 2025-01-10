module 0x1771fa23d78e75e294e42df2ab701a521d1c687cf5cea18431a8945dfaa1d16a::testt {
    struct TESTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESTT>(arg0, 6, b"TESTT", b"testt by SuiAI", b"test2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/download_2e5d159c37.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

