module 0x938a6c34db7acb9ea0346433bb66eb3ce4eb98f669ade935c1eb306d8f9b8781::suipop {
    struct SUIPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPOP>(arg0, 9, b"POP", b"SUIPOP", b"This is a coin will make you POP your pants off!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d3hnfqimznafg0.cloudfront.net/image-handler/ts/20200218065624/ri/950/src/images/Article_Images/ImageForArticle_227_15820269818147731.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPOP>>(v1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SUIPOP>(&mut v2, 10000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPOP>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

