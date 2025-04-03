module 0xf2c24c527e3d1b3fbd78ed5f1c97733f23ec8adfa5fe8cd66462ed7b8a8e4b21::kjr {
    struct KJR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KJR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KJR>(arg0, 9, b"KJR", b"KIM JUN RUS", b"n", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ebab24e211acb653929077062dfc2c7dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KJR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KJR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

