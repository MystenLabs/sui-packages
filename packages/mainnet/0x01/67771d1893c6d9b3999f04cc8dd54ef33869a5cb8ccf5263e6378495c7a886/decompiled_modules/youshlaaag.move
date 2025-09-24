module 0x167771d1893c6d9b3999f04cc8dd54ef33869a5cb8ccf5263e6378495c7a886::youshlaaag {
    struct YOUSHLAAAG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<YOUSHLAAAG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YOUSHLAAAG>>(0x2::coin::mint<YOUSHLAAAG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: YOUSHLAAAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOUSHLAAAG>(arg0, 9, b"YOU SHLAAAG", b"SHLAAAG", b"YOU SHLAAAGS!", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<YOUSHLAAAG>>(0x2::coin::mint<YOUSHLAAAG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOUSHLAAAG>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YOUSHLAAAG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

