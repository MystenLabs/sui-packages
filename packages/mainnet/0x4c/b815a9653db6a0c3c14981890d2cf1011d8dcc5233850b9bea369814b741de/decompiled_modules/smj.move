module 0x4cb815a9653db6a0c3c14981890d2cf1011d8dcc5233850b9bea369814b741de::smj {
    struct SMJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMJ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SMJ>(arg0, 6, b"SMJ", b"3 by SuiAI", b"wwwww", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1706251649780_30b676a86f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMJ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMJ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

