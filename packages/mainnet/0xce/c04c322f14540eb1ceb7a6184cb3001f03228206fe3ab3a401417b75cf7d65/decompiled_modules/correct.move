module 0xcec04c322f14540eb1ceb7a6184cb3001f03228206fe3ab3a401417b75cf7d65::correct {
    struct CORRECT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORRECT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORRECT>(arg0, 9, b"CORRECT", b"Dung di dcm", b"Dung di dcm test met qua", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e82ca4aeeb66865f9c431285cf2e264dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORRECT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORRECT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

