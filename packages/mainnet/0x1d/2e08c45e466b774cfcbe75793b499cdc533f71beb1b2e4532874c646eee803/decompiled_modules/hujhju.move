module 0x1d2e08c45e466b774cfcbe75793b499cdc533f71beb1b2e4532874c646eee803::hujhju {
    struct HUJHJU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUJHJU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUJHJU>(arg0, 9, b"Hujhju", b"miyy80", b"cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b0b969a76ac6ce3438cad47e3dbfe846blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUJHJU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUJHJU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

