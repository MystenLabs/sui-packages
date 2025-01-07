module 0x7dddcd66671c6b7dd584fe848cff95b4fd98d26c57a3cfb6f6895934202f21bc::deadpool {
    struct DEADPOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEADPOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEADPOOL>(arg0, 6, b"DEADPOOL", b"DEADPOOL X", b"DEADPOOL X WOLVERINE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7299_fdaf05296b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEADPOOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEADPOOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

