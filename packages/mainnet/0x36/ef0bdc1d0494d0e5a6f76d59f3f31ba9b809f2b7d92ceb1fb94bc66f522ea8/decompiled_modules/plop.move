module 0x36ef0bdc1d0494d0e5a6f76d59f3f31ba9b809f2b7d92ceb1fb94bc66f522ea8::plop {
    struct PLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOP>(arg0, 9, b"PLOP", b"7KPLOP", b"Plop but 7K.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0a01f9d5c01a36c0d535d6c9f76ef4b0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

