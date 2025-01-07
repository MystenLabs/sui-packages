module 0x849629f2a2a391501d2146f492d5ddb1b6a7ffb686de9123dc93e3548b00d033::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBL>(arg0, 6, b"Bubl", b"BUBL", b"The wave of bubbles on Sui is just beginning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731349239791.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

