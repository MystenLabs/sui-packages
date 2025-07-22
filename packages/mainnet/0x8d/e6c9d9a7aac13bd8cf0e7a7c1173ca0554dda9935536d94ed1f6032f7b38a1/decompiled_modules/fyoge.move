module 0x8de6c9d9a7aac13bd8cf0e7a7c1173ca0554dda9935536d94ed1f6032f7b38a1::fyoge {
    struct FYOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FYOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FYOGE>(arg0, 6, b"FYOGE", b"Fyoge Degen Fish", x"46796f67652054686520446567656e20466973680a6c696c2066697368207377696d6d696e6720696e2074686520537569205365612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiefdane3z2lmmc3mszdrzpicsrv4pttw7s43n4ryt2oax6fun2fxq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FYOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FYOGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

