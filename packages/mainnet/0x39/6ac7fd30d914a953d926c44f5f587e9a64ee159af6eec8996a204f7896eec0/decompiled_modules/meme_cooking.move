module 0x396ac7fd30d914a953d926c44f5f587e9a64ee159af6eec8996a204f7896eec0::meme_cooking {
    struct MEME_COOKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_COOKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_COOKING>(arg0, 6, b"MEME COOKING", b"Meme Cooking", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEME_COOKING>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME_COOKING>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEME_COOKING>>(v2);
    }

    // decompiled from Move bytecode v6
}

