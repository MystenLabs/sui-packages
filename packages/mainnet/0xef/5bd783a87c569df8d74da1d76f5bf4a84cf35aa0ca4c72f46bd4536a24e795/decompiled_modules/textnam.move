module 0xef5bd783a87c569df8d74da1d76f5bf4a84cf35aa0ca4c72f46bd4536a24e795::textnam {
    struct TEXTNAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEXTNAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEXTNAM>(arg0, 6, b"TEXTNAM", b"text name", b"text nametext nametext nametext nametext name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1765333405222.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEXTNAM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEXTNAM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

