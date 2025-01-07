module 0x6c106e2b3a68b8ab7711c593cff445b4e52c23efaa1aa539d172635d5b383c6e::goida {
    struct GOIDA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GOIDA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GOIDA>>(0x2::coin::mint<GOIDA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GOIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOIDA>(arg0, 6, b"GOIDA", b"GOI", b"https://d3hnfqimznafg0.cloudfront.net/image-handler/ts/20200218065624/ri/950/src/images/Article_Images/ImageForArticle_227_15820269818147731.png", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOIDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOIDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

