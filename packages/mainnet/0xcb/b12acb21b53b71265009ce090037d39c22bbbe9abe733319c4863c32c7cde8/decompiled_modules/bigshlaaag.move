module 0xcbb12acb21b53b71265009ce090037d39c22bbbe9abe733319c4863c32c7cde8::bigshlaaag {
    struct BIGSHLAAAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGSHLAAAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGSHLAAAG>(arg0, 9, b"BIGSHLAAAG", b"BIGSHLAAAG", b"ncdsjcndfkn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1759946226/sui_tokens/gwryfke3ciy2y4nsbhie.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BIGSHLAAAG>>(0x2::coin::mint<BIGSHLAAAG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BIGSHLAAAG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BIGSHLAAAG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

