module 0x75ba68f11bcaab0cff3fcea08a1ef32fadffc667d4e72464c19401868f1cc2a4::dr_meme {
    struct DR_MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DR_MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DR_MEME>(arg0, 6, b"DR MEME", b"Doctor Meme", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DR_MEME>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DR_MEME>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DR_MEME>>(v2);
    }

    // decompiled from Move bytecode v6
}

