module 0xf8b77d78c68a89681a8be2535a2b29be519aa18bf3c2dd6f0c9fac2f3596a0ff::f4r {
    struct F4R has drop {
        dummy_field: bool,
    }

    fun init(arg0: F4R, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<F4R>(arg0, 9, b"F4R", b"THE FOUR", b"EXPERIENCE THE FOUR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/80b91f4758541a7a0fc2b7cb21a8e969blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<F4R>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F4R>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

