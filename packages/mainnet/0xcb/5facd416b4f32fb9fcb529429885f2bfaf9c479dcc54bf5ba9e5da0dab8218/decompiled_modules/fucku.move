module 0xcb5facd416b4f32fb9fcb529429885f2bfaf9c479dcc54bf5ba9e5da0dab8218::fucku {
    struct FUCKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKU>(arg0, 6, b"FUCKU", b"F", b"ssss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihsob5j7p3lvudg46szgwew67l626zptpr2zxdauiz2guh3xndsou")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUCKU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

