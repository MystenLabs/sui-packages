module 0x4d8e92666af943f1acf80588c2f17d4624dd4c9a11c0f6244b94497eb1611cea::dogshit {
    struct DOGSHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSHIT>(arg0, 6, b"DOGSHIT", b"Dogshit Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGSHIT>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSHIT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGSHIT>>(v2);
    }

    // decompiled from Move bytecode v6
}

