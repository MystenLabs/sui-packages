module 0x4bd6e922d2923eb30fafe10b88e288e05960ffcca7499e0a113d49d9f374faad::rex {
    struct REX has drop {
        dummy_field: bool,
    }

    fun init(arg0: REX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REX>(arg0, 6, b"REX", b"suirex", b"Something big and blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rex_c26a17d932.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REX>>(v1);
    }

    // decompiled from Move bytecode v6
}

