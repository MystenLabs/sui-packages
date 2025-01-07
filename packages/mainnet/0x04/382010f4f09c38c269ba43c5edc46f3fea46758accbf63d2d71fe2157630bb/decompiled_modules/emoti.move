module 0x4382010f4f09c38c269ba43c5edc46f3fea46758accbf63d2d71fe2157630bb::emoti {
    struct EMOTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMOTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMOTI>(arg0, 9, b"EMOTI", b"EMOTICOIN", b"EMOTICOIN meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x0f7b8a61780006832aabef435db12a5e8125aae3.png?size=xl&key=ca0a26")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EMOTI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMOTI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMOTI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

