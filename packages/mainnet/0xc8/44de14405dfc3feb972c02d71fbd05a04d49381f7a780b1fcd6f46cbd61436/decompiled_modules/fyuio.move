module 0xc844de14405dfc3feb972c02d71fbd05a04d49381f7a780b1fcd6f46cbd61436::fyuio {
    struct FYUIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FYUIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FYUIO>(arg0, 9, b"FYUIO", b"fyli", b"dyuk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e6db56fd1b4884dbe53ed5233b7897c2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FYUIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FYUIO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

