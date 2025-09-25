module 0x89741a3afccf3d41fec258b7cd55c139e0018dd5e5f8f4afda1b33a4e0b84db9::filthyshlaaag {
    struct FILTHYSHLAAAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FILTHYSHLAAAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FILTHYSHLAAAG>(arg0, 9, b"FILTHY SHLAAAG", b"SHLAAAG", b"Get yourself a cheap shlaaag!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1758828875/sui_tokens/wb8ifqmip8uywpjtnchh.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FILTHYSHLAAAG>>(0x2::coin::mint<FILTHYSHLAAAG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FILTHYSHLAAAG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FILTHYSHLAAAG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

