module 0xd5f9ac7b4006df11bb31bb116bf6a3027ad90bed09449383ef5e33fefe1a0421::cc {
    struct CC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CC>(arg0, 9, b"CC", b"Couple Cats", b"If you love couple cat, just buy $1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9e08c6c8fc200dd18667cd9fba04c3deblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

