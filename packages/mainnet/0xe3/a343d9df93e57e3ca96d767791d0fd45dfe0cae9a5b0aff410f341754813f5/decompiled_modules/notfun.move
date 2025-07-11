module 0xe3a343d9df93e57e3ca96d767791d0fd45dfe0cae9a5b0aff410f341754813f5::notfun {
    struct NOTFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTFUN>(arg0, 6, b"NOTFUN", b"DUMP.NOTFUN", b"DUMP.NOTFUN?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752244900967.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTFUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTFUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

