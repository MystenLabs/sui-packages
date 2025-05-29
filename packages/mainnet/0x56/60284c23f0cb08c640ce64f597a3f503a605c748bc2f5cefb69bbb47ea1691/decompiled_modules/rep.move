module 0x5660284c23f0cb08c640ce64f597a3f503a605c748bc2f5cefb69bbb47ea1691::rep {
    struct REP has drop {
        dummy_field: bool,
    }

    fun init(arg0: REP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REP>(arg0, 9, b"REP", b"GIVEREP", b"this meme coins user yappers @giverep ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9073663982c72021b8736380617e4be0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

