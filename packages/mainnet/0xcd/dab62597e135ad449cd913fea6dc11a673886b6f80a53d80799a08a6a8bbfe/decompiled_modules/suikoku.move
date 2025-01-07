module 0xcddab62597e135ad449cd913fea6dc11a673886b6f80a53d80799a08a6a8bbfe::suikoku {
    struct SUIKOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKOKU>(arg0, 6, b"SUIKOKU", b"Suikoku", b"Suikoku is a blockchain project inspired by the strength, loyalty, and resilience of the Shikoku Inu, a native Japanese dog breed. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731042678454.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKOKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKOKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

