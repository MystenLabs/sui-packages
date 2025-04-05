module 0xa23c9599ae5419af3ac77fd12703bb252dcc72d89cc8550788fd7f1ba728e558::qg89 {
    struct QG89 has drop {
        dummy_field: bool,
    }

    fun init(arg0: QG89, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QG89>(arg0, 9, b"Qg89", b"tyjrtbg", b"tyhgdj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/055a9e19e38b5fb0d7a2c01696853745blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QG89>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QG89>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

