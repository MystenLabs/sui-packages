module 0x2ff1da5670834922a4dc43704c814273d6067d7a4163f3f2240273eb6632b47::de_meme {
    struct DE_MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DE_MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DE_MEME>(arg0, 6, b"DE MEME", b"Doctor Meme", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DE_MEME>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DE_MEME>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DE_MEME>>(v2);
    }

    // decompiled from Move bytecode v6
}

