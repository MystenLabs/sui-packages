module 0x38bb1c266245f45f5613aed92656c6caa023b757acd3bccd83e55b8fee1df87a::punk {
    struct PUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNK>(arg0, 6, b"PUNK", b"Crypto punk", b"In this bullish market I recommend lounging. Buy punk.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731016033857.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUNK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

