module 0x469b7e984ceeed1470533ac79bf9277a23d8eefee2cba5a943c05e60b5f1acc2::elza {
    struct ELZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELZA>(arg0, 6, b"ELZA", b"ELZA-Agent", b"ElZA IS A Gril", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/meme_943b5f6ed6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

