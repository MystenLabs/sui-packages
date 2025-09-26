module 0x7635c0ab998bb979f809edc40c51ef10c7cc0c6cb8d15d4325c29119366c935d::filthyshlaaag {
    struct FILTHYSHLAAAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FILTHYSHLAAAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FILTHYSHLAAAG>(arg0, 9, b"FILTHY SHLAAAG", b"SHLAAAG", b"Get yourself a cheap fooking shlaaag!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1758877617/sui_tokens/knewkjfs9rrknpmwzvvp.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FILTHYSHLAAAG>>(0x2::coin::mint<FILTHYSHLAAAG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FILTHYSHLAAAG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FILTHYSHLAAAG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

