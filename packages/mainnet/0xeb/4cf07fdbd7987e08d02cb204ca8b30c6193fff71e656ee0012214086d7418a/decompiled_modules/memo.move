module 0xeb4cf07fdbd7987e08d02cb204ca8b30c6193fff71e656ee0012214086d7418a::memo {
    struct MEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMO>(arg0, 9, b"Memo", b"top", b"monad  tooppppp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d10a69ebde7a75205c225144ac1ee072blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

